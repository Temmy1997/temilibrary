# Jenkins: Leveraging SCM in Builds (Git + GitHub Webhook)

> Source: video tutorial lesson "Leveraging SCM in Builds" (instructor: Mike), plus a few extra notes of my own marked **Extra**.
> Goal: make Jenkins pull code from GitHub **and** start builds automatically when I push.

---

## 1. The big picture

Before this lesson, builds were **manual** (click "Build with Parameters"). That is not CI/CD.

This lesson has two parts:

| Part | What it gives me |
|---|---|
| **A. SCM (Source Code Management)** | Jenkins clones a Git repo into the job's workspace and builds from it |
| **B. Webhook trigger** | GitHub tells Jenkins "new push!" and the job runs by itself |

```
 Part A (manual)                      Part B (automatic)

 Me -> click Build                    Me -> git push
        |                                    |
        v                                    v
   Jenkins job                          GitHub repo
        |                                    | webhook (HTTP POST)
        v                                    v
   git clone from GitHub                Jenkins job starts
        |                                    |
        v                                    v
   run shell script                     git clone + run script
```

**Key terms**
- **SCM** = Source Code Management (Git, SVN...). Here it's Git.
- **Webhook** = GitHub sends an HTTP request to Jenkins when something happens (a push).
- **Personal Access Token (PAT)** = a secret that lets Jenkins call the GitHub API on my behalf (for example, to create the webhook).
- **Workspace** = the folder on the Jenkins node where the repo is cloned and the build runs.

---

## 2. Part A: Create a Freestyle job that uses Git

### The demo repo
- GitHub repo named `some code` (public)
- Contains `testscript.sh`, which echoes that it's from GitHub and prints the **sum of two numbers**
- The script expects two variables: `NUMBERONE` and `NUMBERTWO` (**capital letters**, they must match exactly)

### Steps

1. **New Item** -> name: `scm` -> **Freestyle project** -> **OK**
2. **Source Code Management** -> select **Git**
3. **Repository URL**: paste the repo's **HTTPS clone URL** from GitHub
   - Click outside the box. The red error disappears if Jenkins can reach the repo.
   - **No credentials needed** because the repo is **public**.
4. **Branch Specifier**: `*/master` (the video leaves it as `master`)
5. **This project is parameterized** -> add two **String parameters**:

   | Name | Default value |
   |---|---|
   | `NUMBERONE` | `1` |
   | `NUMBERTWO` | `2` |

6. **Build Steps** -> **Execute shell**:
   ```bash
   chmod +x ./testscript.sh
   ./testscript.sh
   ```
7. **Save** -> **Build with Parameters** -> accept defaults -> **Build**
8. Open the **Console Output**. Expected: the script says it is from GitHub and the total is **3**.

### Why the `chmod +x`? (important)
- Jenkins clones the repo into the **workspace** (the job's local directory).
- Cloned files get **default permissions**, so the script is **not executable**.
- `chmod +x ./testscript.sh` makes it executable.
- `./` means "relative to the workspace root", which is where the repo files land.

### Why the parameter names matter
- Jenkins passes job parameters to the shell as **environment variables**.
- The script reads `$NUMBERONE` and `$NUMBERTWO`, so the parameter names must match exactly.

---

## 3. Part B: Trigger builds automatically with a GitHub webhook

### Step 1: Create a Personal Access Token on GitHub
Path: **GitHub -> profile -> Settings -> Developer settings -> Personal access tokens -> Generate new token**

- Name: `jenktok` (Jenkins token)
- Scopes to tick:
  - **repo** (full repository control)
  - **admin:repo_hook** (manage webhooks), the important one. It lets Jenkins create the webhook for me.
- Generate and **copy the token now**. GitHub shows it only once.

### Step 2: Store the token in Jenkins as a credential
- **Manage Jenkins -> Credentials -> (global) -> Add Credentials**
- **Kind: Secret text**
- **Secret**: paste the token
- **ID**: anything (the video says it doesn't matter)
- **Description**: `scmhook`

### Step 3: Configure the GitHub server in Jenkins
- **Manage Jenkins -> System** (called *Configure System* in older Jenkins) -> scroll to **GitHub** / **GitHub Servers**
- Add a GitHub server (name: `scmjob` in the video)
- **Credentials**: select the `scmhook` secret text credential
- Tick **Manage hooks**
- Click **Test connection**. It should say credentials verified for my GitHub user.
- **Save**

> Without a valid token, Test connection fails, because Jenkins cannot reach the GitHub API without authentication.

### Step 3.5 (my lab, NOT in the video): Use ngrok so GitHub can reach my Jenkins
**Problem:** the payload URL can't be `localhost:8080`. A webhook is GitHub (on the internet) calling my Jenkins, and `localhost` on GitHub's side means GitHub's own machine, not my Mac. My Jenkins is also on a private LAN address, so GitHub can't reach it either.

**What I did:** used **ngrok** to expose my local Jenkins with a public HTTPS URL.

```bash
ngrok http 8080
```
- ngrok prints a **Forwarding** URL like `https://xxxx.ngrok-free.app -> http://localhost:8080`
- That public URL is what GitHub uses as the **payload URL** base.
- Keep the ngrok terminal **running** the whole time. If it stops, webhooks stop working.

Then:
1. **Manage Jenkins -> System -> Jenkins URL** = the ngrok URL (e.g. `https://xxxx.ngrok-free.app/`)
2. The webhook's **Payload URL** on GitHub becomes:
   ```
   https://xxxx.ngrok-free.app/github-webhook/
   ```
   If **Manage hooks** is on, Jenkins builds this from the Jenkins URL, so set the Jenkins URL first and then save the job.
3. **Content type**: `application/json`

**Gotchas**
- On the free plan the ngrok URL **changes every time ngrok restarts**. When it changes, update the Jenkins URL, then re-save the job (or fix the webhook's payload URL on GitHub by hand).
- Check **GitHub repo -> Settings -> Webhooks -> Recent Deliveries**. A green tick (HTTP 200) means Jenkins received it.
- ngrok's local inspector at `http://127.0.0.1:4040` shows each incoming request, which is handy for debugging.

### Step 4: Turn on the trigger in the job
- Open the `scm` job -> **Configure** -> **Build Triggers**
- Tick **GitHub hook trigger for GITScm polling**
- **Save**

### Step 5: Check that the webhook appeared on GitHub
- GitHub repo -> **Settings -> Webhooks**
- Before saving the job: no webhooks.
- After saving the job: a **webhook exists**, created automatically by Jenkins because the token had webhook permission and **Manage hooks** was on.
- With ngrok, the payload URL should start with my ngrok address, not `localhost`.

### Step 6: Test it by pushing code
On my local machine, in the cloned repo:
```bash
git status                       # video: was on branch "example"
git checkout master
ls                               # see testscript.sh
# edit testscript.sh and add an echo line
git commit -am "added"
git push origin master
```
Watch Jenkins. The job starts on its own (after a short **quiet period**), and the Console Output shows the new echo line.

**That's CI.** Push code, Jenkins builds it automatically.

---

## 4. Order of operations (checklist)

- [ ] Create a freestyle job
- [ ] Set SCM = Git with the repo URL (public repo, so no credentials)
- [ ] Add parameters `NUMBERONE`, `NUMBERTWO`
- [ ] Add the shell step (`chmod +x`, then run the script)
- [ ] Run a manual build to prove it works
- [ ] Create a GitHub token (`repo` + `admin:repo_hook`)
- [ ] Add it to Jenkins as **Secret text**
- [ ] Start **ngrok** (`ngrok http 8080`) and set the **Jenkins URL** to the ngrok URL (my lab only)
- [ ] Add GitHub server, pick the credential, tick **Manage hooks**, **Test connection**
- [ ] Job -> Build Triggers -> **GitHub hook trigger for GITScm polling**
- [ ] Confirm the webhook appears in GitHub
- [ ] Push a commit and watch the job trigger

---

## 5. Extra notes for my lab (Jenkins in Docker on my Mac)

These were not in the video, but they will matter for me.

### A. GitHub must be able to reach my Jenkins
- A webhook is GitHub calling **my Jenkins URL**.
- My Jenkins runs locally (`localhost:8080` or a `192.168.x.x` address), and GitHub **cannot reach** that from the internet.
- Result: the webhook gets created but deliveries **fail**. In GitHub, **Settings -> Webhooks -> Recent Deliveries** shows the errors.
- The video presumably used a Jenkins server with a public address.
- **I couldn't use `localhost:8080` as the payload URL, so I used ngrok** (see Step 3.5).

Ways to make it work for a lab:
- **Tunnel (what I used)**: `ngrok http 8080` gives a public HTTPS URL that forwards to my local Jenkins. Cloudflare Tunnel works the same way.
- **smee.io**: a webhook forwarder, with a relay client running locally.
- Set **Manage Jenkins -> System -> Jenkins URL** to the public tunnel URL so the webhook URL is correct.
- Or use **Poll SCM** (e.g. `H/2 * * * *`) as a fallback. Jenkins asks GitHub for changes on a schedule, with no inbound access needed.

### B. The webhook URL format
```
http(s)://<JENKINS_PUBLIC_URL>/github-webhook/
```
Content type is `application/json`. The trailing slash matters.

### C. Required plugins
- **Git** plugin
- **GitHub** plugin (adds the GitHub server config and the hook trigger)

### D. Branch name: `master` vs `main`
- New GitHub repos default to **`main`**. If the build can't find `master`, change the branch specifier to `*/main`.

### E. Token security
- Prefer a **fine-grained** token limited to the one repo, with webhook (repository webhooks) read/write permission. Classic tokens with `repo` are broad.
- Never commit tokens to Git or paste them in chat.
- Delete tokens I no longer use (the instructor deletes his and makes a new one).

### F. Private repos
- This demo repo is public, so no Git credentials are needed.
- For a private repo, add a credential (**Username with password**, where the password is a token, or an **SSH key**) and select it in the job's SCM section.

### G. What "quiet period" means
- After the webhook arrives, Jenkins waits a few seconds before starting. This groups rapid pushes into one build.

---

## 6. Troubleshooting

| Problem | What to check |
|---|---|
| Red error under Repository URL | Wrong URL, repo is private (needs credentials), or Jenkins has no internet |
| `testscript.sh: Permission denied` | Missing `chmod +x ./testscript.sh` |
| Script prints a total of 0 or errors | Parameter names don't match (`NUMBERONE`, `NUMBERTWO`, case-sensitive) |
| `Couldn't find any revision to build` | Branch specifier doesn't exist (`master` vs `main`) |
| Test connection fails | Bad or expired token, missing scopes, wrong credential kind (must be **Secret text**) |
| Webhook didn't appear on GitHub | **Manage hooks** unticked, token lacks `admin:repo_hook`, or the trigger wasn't saved in the job |
| Webhook exists but job doesn't trigger | GitHub can't reach Jenkins (see section 5A), or check **Recent Deliveries** in GitHub for the error code |
| Webhook payload URL says `localhost` | Jenkins URL isn't set to the ngrok URL. Fix it, then re-save the job. |
| Webhooks worked yesterday, fail today | ngrok restarted and the URL changed (free plan). Update the Jenkins URL and the webhook. |
| ngrok URL shows a warning/error page | ngrok isn't running, or it's pointing at the wrong port (should be 8080) |
| Job triggered by push but built old code | Wrong branch pushed, or branch specifier doesn't match |

---

## 7. Quick recap

1. **SCM** = tell the job where the code lives (Git URL + branch).
2. Cloned files are **not executable** by default, so `chmod +x`.
3. **Parameters** become environment variables for the shell script.
4. **Webhook** = GitHub pings Jenkins on every push.
5. A **token** with `repo` + `admin:repo_hook` lets Jenkins create the webhook automatically.
6. Trigger to enable: **GitHub hook trigger for GITScm polling**.
7. For a local Jenkins, GitHub needs a **public URL**. `localhost:8080` can't work as the payload URL, so I used **ngrok** (`ngrok http 8080`) and set the Jenkins URL to the ngrok address.

**Next lesson (from the video):** testing and test reports in Jenkins.

---

## 8. My notes / questions

- `TODO`: Try this with my Docker Jenkins plus ngrok
- `TODO`: Convert the freestyle job into a Pipeline job (`Jenkinsfile` in the repo)
- `TODO`:
