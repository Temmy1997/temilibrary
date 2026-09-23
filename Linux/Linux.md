# LINUX PRINCIPLES 
1. Everything in linux is a file or folder.
2. Ther are small singlr purpose program.
3. Ability to chain programs together for complex operations.
4. Configuration data are stored in text file

## Arcitecture of Linux 
- Hardware
- Kernel
- Shell
- Application 

## Path to Important Directories 
- Home Directories : /root, /home/username
- User Executable: /bin, /usr/bin ,  /usr/local/bin
- 




## Command to check the OS Version 
cat /etc/os-releases
## Create more than one file
touch filename{1.10}.txt

# VIM EDITOR 

## Commands in Vim EDITOR
* Set up lines Numbers in VIM EDITOR {SET NUMBERS
}
:se nu 
* Go to the last Line use 
(G)
* Go to the first line use (gg)
* Delete a line in esc mode (dd)
* Copy (yy)
* Paste (p)
* Paste line above cursorf position (P)
* Delete word by letter (x) in esc mode 
* Search a word in the file (/)

## Commands 
* Grep - Find text from files 
* less - 
* head - Display the top 10 lines of the file 
* tail - last 10 lines in a file 
* cut - Get a particular column from a file 
     * Get just the users column in /etc/passwd file        cut -d: -f1 /etc/passwd
* sed - Serch and replace a word in the file 
* > - Redirect to a file and removes the former content of the file
* >> - Redirect an output of a commnad and append or add it to the end of the file 
* | -  Pipe - It uses the output of a command as an input for another command.
* Find - Find files with its names 
     sudo find /etc -name host*
* Locate - Search files and directores name from it database 
NOTE:Always run updatedb command before you use the locate command. 
* /dev/null -  This is a file that does not contain anything. If you put anything in this file, then its gone 
* wc -l - Count lines


## File Permission
* Read -r
* Write - w
* Execute - x    

     ## Commands 
* chown = change ownership of files and diretoties 
    chown username;group name
    

## USERS AND GROUP
* Every file is owned by a user.
* Every user has an assigned user ID (UID)
* All user names are stores in /etc/passwd
* All user password are stored in /etc/shadow
* Users are assigned a home directory 
* Users need permission to read, write, and execute other files. 

     ## Types of Users
1. Root User
    User ID = 0 
    Group ID = 0
    Home Dir = /root
    Shell = /bin/bash
2. Vagrant User
    User ID = 1000-60000
    Group ID = 1000-60000
    Home Dir = /home/username 
    Shell = /bin/bash
2. Service or Sytem User (ftp, ssh, http)
    User Id = 1- 999
    Group ID = 1 - 999
    Home Dir = /var/ftp  e.t.c
    Shell = Has no login shell (/sbin/nologin)

## Commands
* Create a user - useradd {username}
* Create a group -groupadd {username}
* Add User to a group - usermod -aG devops ansible
* Set User password - sudo passwd {username}
* Switch user -  su - {username}
* List open files by user - lsof -u {username}
* Delete user - userdel {username}
* Delete groups - userdel {groupname}


# SUDO
* SUDO gives power to a normal user to execute commands that are owned by root user.
Note: When a user has a full sudoers priviledge, it can become a root user anytime. 

## SUDO Commands 
* sudo -i => Switch to root user 
* sudo - {username} => Switch to a user 
* passwd {username} => Set user password 
* ls /etc/sudoers => To view the sudoers file 
* sudo visudo => This command adds username to sudoers file 
        * Note Set Line number command => :se nu
    Look for > Allow root to run any commands anywhere
                Add Username to a new line 

* Add NOPASSWD options in the sudoers file when you don't want to enter password after running the sudo comand. 
        => vagrant    ALL=(ALL)    NOPASSWD: ALL

# Package Management 
## YUM
* Yum is a primary package management tool for installing, updating, removing, and managing software packages in Red Hat Enterprise Linux. 
* Yum repository is located in /etc/yum.repos.d 

## APT 
* APT is a command-line utility for installing, updating, removing, and managing deb packages on Ubuntu AND Debian.
* APt repository is located /etc/apt/sources.list & 

# PROCESSES 
* PID 1 => Its the first process in linux, which is called {init / systemd}
## Commands 
* PID: Shows the unique process ID
* TTY: Shows the terminal type into which the user is logged in.
* TIME: Displays the total time that the process has been running.
* CMD: Displays the name of the command that launches the process. .
* top => Shows all dynamic processes in a system.
        It shows uptime of the system. 
* ps -ef => list all processes
* Kill => To stop a process. 
    Syntax: kill {P}

# Archiving 
* Archiving is the process of combining multiple files and directories into one file. 
* Its used as part of a system backup or when moving data from one system to another

## WE HAVE TWO METHOD OF ARCHIVING 
    1. TAR COMMAND 
    2. ZIP 
## TAR Commands 
* tar => This is an archive command that combines or store mutiple files . 
    Options for Tar Command 
        1. c – Create an archive from a file or directory
        2. x – Extract archive
        3. r – Append file to archive
        4. t - List the contents of the archive
        5. v - To ses the process creating/executing an archive file. 
        6. z- (gzip) filter the archive through gzip

    ## Create an archive
          =>   mkdir directory 
          =>   tar -czf {archive_name.tar} {created_dir}
       ## Extract or Unarchive 
          => tar -xzf archive.tar
    ## Compression of files 
         *  Compression is the process of reducing the size of a file or directory.
      ## Creating & Compressing archive file 
            tar -czvf folder.tar.gz folder 
      ## Extracting an archive compressed file 
            tar -vxzf folder.tar.gz
      ## Redirect into a file or folder
            tar -vxzf folder.tar.gz -C Dir_1/
 
 ## ZIP COMMANDS 
* Install both ZIP and UNZIP 
    ZIP   =>    zip -r Dir_2.zip Dir_2
    UNZIP =>    unzip Dir_2.zip