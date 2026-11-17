# Jenkins Agents & Distributed Builds (concise)

Based on the official Jenkins documentation (sources at the bottom).

## Key terms

| Term | Meaning |
|---|---|
| **Controller** | The Jenkins service itself. Web server and "brain": config, auth, scheduling, queue |
| **Node** | A machine that can run builds. Two types: agents and the built-in node |
| **Built-in node** | Node inside the controller process. Formerly called "master". Builds here are discouraged |
| **Agent** | Small Java client process that connects to the controller and runs tasks. Needs Java and a network connection to the controller |
| **Executor** | A slot (thread) on a node that runs one task. Executors = concurrent builds on that node |
| **Label** | Tag on a node (`linux`, `docker`, `jdk21`) used to route jobs to matching nodes |
| **Cloud** | Dynamic agent provisioning (Kubernetes, EC2, Azure VMs) |

## Why distributed builds?
- The controller stays free for orchestration (scheduling, HTTP, config).
- Builds can't touch sensitive data in `$JENKINS_HOME`. Build scripts run code written by less-trusted people.
- Scale horizontally: more agents means more parallel builds.
- Different environments per job: OS, tools, hardware.

## Best practices from the docs
- Set the **built-in node's executors to 0** (*Manage Jenkins → Nodes → Built-In Node → Configure*). Make sure agents exist first, or builds can't start.
- **SSH connector** is the preferred, most stable way to connect agents. Jenkins has a built-in SSH client. It copies and starts the agent over SSH.
- Executors per node: 1 is the safest. Roughly 1 per CPU core works for small tasks. Watch CPU, memory and I/O.
- Agents are assumed unreliable, so make them replaceable ("fungible").

## Creating an SSH agent
1. Agent machine: Java installed, a `jenkins` user, public key in `~/.ssh/authorized_keys`.
2. Jenkins: add credential, kind **SSH Username with private key** (username `jenkins`, key pasted via *Enter directly*).
3. *Manage Jenkins → Nodes → New Node →* name, **Permanent Agent**.
4. Set: remote root directory, executors, labels, usage, **Launch agents via SSH**, host, credential, host key verification strategy.
5. Save. Check the node log for connection, auth, or host-key errors.

**Usage options**
- *Use this node as much as possible*: any job may land here.
- *Only build jobs with label expressions matching this node*: only labeled jobs run here.

## Sending builds to an agent

**Freestyle job:** *Configure → Restrict where this project can be run → label expression*. Watch out for stray spaces around the label.

**Pipeline:**
```groovy
pipeline {
    agent { label 'linux' }          // or: agent { label 'linux && jdk21' }
    stages { stage('Build') { steps { sh 'hostname' } } }
}
```

| `agent` option | Meaning |
|---|---|
| `any` | Any available agent |
| `none` | No global agent. Each stage declares its own |
| `label 'x'` | Agent with that label (supports `&&`, `\|\|`, `!`) |
| `node { label 'x'; customWorkspace '/path' }` | Same as label, plus extra options |

**Multiple agents in one pipeline** (use `stash`/`unstash` to pass files between them):
```groovy
pipeline {
    agent none
    stages {
        stage('Build') {
            agent any
            steps { sh 'make'; stash includes: '**/target/*.jar', name: 'app' }
        }
        stage('Test on Linux') {
            agent { label 'linux' }
            steps { unstash 'app'; sh 'make check' }
        }
        stage('Test on Windows') {
            agent { label 'windows' }
            steps { unstash 'app'; bat 'make check' }
        }
    }
}
```
`parallel { ... }` blocks and `matrix { ... }` can also give each branch its own `agent { label ... }`.

## Scheduling in short
- Jobs restricted to a label only run on matching nodes. Unrestricted jobs pick from the available pool.
- If every matching executor is busy, the build waits in the queue.

## My lab
Controller in Docker (`/var/jenkins_home`) → SSH → agent `192.168.1.213` (user `jenkins`, home `/var/lib/jenkins`, label `linux`, Java 21 on both).
Verified with: `Building remotely on worker1 (linux) in workspace /var/lib/jenkins/workspace/...`

## Sources
- Managing Nodes: https://www.jenkins.io/doc/book/managing/nodes/
- Using Jenkins agents: https://www.jenkins.io/doc/book/using/using-agents/
- Architecting for Scale: https://www.jenkins.io/doc/book/scaling/architecting-for-scale/
- Controller Isolation: https://www.jenkins.io/doc/book/security/controller-isolation/
- Pipeline Syntax (agent): https://www.jenkins.io/doc/book/pipeline/syntax/
- Using a Jenkinsfile (multiple agents): https://www.jenkins.io/doc/book/pipeline/jenkinsfile/
- Glossary: https://www.jenkins.io/doc/book/glossary/
