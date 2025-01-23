create user fidelis on the linux box
give fidelis sudo access and enable fidelis user to run sudo without password



create temporary password for fidelis and let fidelis be prompted to change his password at first login

rename the ec2 instance: prod0
the goal is for you to be the linux administrator of the linux servers running
in terms of tagging
roles
using of systems manager
patching


Create temi user and give it all the permission that ec2-user has



Assignment for this week
Learn practically and document your research on all the Linux Filesystem directories(e.g /usr, /dev e.t.c..)
Learn about NFS,  setup NFS and mount it on another VM
Learn everything about nginx ( as a webserver, proxy, e.t.c..)

HINT: try to automate some of the processes when setting-up the applications for example NFS( like creating bash script for doing some of the work). That way you are applying your bash scripting knowledge

Learn how to check the processes of nginx services 
Learn aboutb process and the error code 
what does the error code means,  what does it affect, and what causes 
 

 ## 1/20/2025 
 Different programming lanaguage and their compilier 

 * A programming language compiler is a special program that translates human-readable code (like C++, Java, or C#) into a form that a computer's processor can understand and execute
 
 * The compiler reads your source code and converts it into a low-level language called "machine code" or "assembly language." This is a set of instructions that the computer's CPU can directly understand.
 
 ## TYPES OF PROGRAMMING LANAGUAGE AND THEIR COMPILER

 ### C
 * This ia a powerful and versatile programming language. 
 * It's one of the oldest widely used languages and has had a huge influence on many other languages like C++, Java, and Python. 
        
        * COMPILIER: 
        GCC (GNU Compiler Collection)

### C++ 
* It's an "extension" of the C language, adding features that make it suitable for more complex tasks.
*  It inherits all of C's features.
* C++ programs can run very quickly. 
* It's great for applications where speed is critical, like games 

        * COMPILIER
        => Clang: Another popular open-source compiler developed by Apple
        => GCC (GNU Compiler Collection)
        => Microsoft Visual C++ (MSVC): A compiler developed by Microsoft for Windows
        => Intel C++ Compiler: Developed by Intel 

### JAVA 
* JAVA is suitable for developing applications that can run on various platforms. 
* Java is both a compiled and interpreted programming language. Because it employs both compilation and interpretation to run code, it is known as a “compiler-interpreter language.
* In order for the Java Virtual Machine to understand the Java code, it must first be compiled into an intermediate format called bytecode (JVM). 

        * COMPILIER
        => javac 
        => GNU Compilier of java

### C#
* Used for windows desktop aplication and game development. 

        * COMPILIER
        => Roslyn 
 
 
 Exaplain the last class 
 create a git hub repo 
 ## 15 git commands 
 * git init : initialize local repo (Create a new git repo)
 * git clone <repository_url>: Creates a local copy of a remote repository.
 * git status: Shows the current status of your working directory
 * git add `<all-changes>`: # This adds all files in the current directory to the staging area. 
 * git add <filename1> <filename2>  # add specific files TO THE staging area 
 * git commit -m "`<description>`" SAVE all the changes I made in Git
 * git log: Shows the commit history of the repository
 * git diff: Shows the differences between your working directory and the staging area
 * git branch: Lists all local branches.
 * git checkout <branch_name>: Switches to an existing branch.
 * git merge <branch_name>: Merges the specified branch into the current branch.
 * git push origin <branch_name>: Pushes local commits to the remote repository.
 * git pull origin <branch_name>: Pulls changes from the remote repository to your local branch.
* git branch <branch_name>: Creates a new branch.
* 
* 

 create a functional bash script (e.g calculator ), and push it to your repo 

### Python 
* Python is often called an "interpreted" language 
* Python code is first compilied into bytecode, not machine code. This bytecode is then interpreted by the Python Virtual Machine.