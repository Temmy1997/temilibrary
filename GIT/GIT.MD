NOTE: There is a diffrent between Git and Github

# GIT
* Git is a free open source verion control system.
* It's a tool that helps you track changes to your files (especially code) over time

## What Git does:
* Tracks changes: Records every change you make to your files.   
* Manages versions: Allows you to go back to previous versions of your files if needed.   
* Facilitates branching: Lets you create separate versions of your project to work on different features without affecting the main project.
* Merges changes: Helps you combine changes from different branches back into the main project.

   
## Version control
* This is a way we programmers track our code changes.
* We bsically save the initial verion of our code in GIT and when we update the code we can save it into GIT again.
* As our code continues to change we can look back at all the changes we have made in our code.

## NOTE:
This version contol helps us to check what we change in our code, track done bugs, and go back to a previoud verion of code.

* Repository: This is basically a folder where my project is kept.

# GITHUB

* Github is basically a website that host all repository.
* GitHub is a web-based platform that provides hosting for Git repositories. It's like an online storage space for your Git projects.

## What Github does:

* Hosts repositories: Provides a central location to store your Git projects.   
* Enables collaboration: Makes it easy for multiple people to work on the same project.   
* Provides tools for code review: Offers features like pull requests and code reviews to help teams collaborate effectively.   
* Offers issue tracking: Helps you track bugs and feature requests.   
* Provides a social network for developers: Allows you to discover and contribute to open-source projects.

# GIT COMMANDS

* clone => Brings a repository that is on Github into a folder in my local machine.
* add => Track all the changes in GIT.
* commit => SAVE all the changes I made in Git.
* push => Once I have made the changes locally on my computer, this command uploads the file to Github.
* pull => Download changes to my local computer from Github.
* git init : initialize local repo (Create a new git repo)
* git remote add : add a new repository
* git clone: to clone an existing repo

# Flow of pushing local files and folder changes to remote repo

- git add `<all-changes>`: # This adds all files in the current directory to the staging area. 
- git add <filename1> <filename2>  # add specific files TO THE staging area 
- git commit -m "`<description>`"
- git push -u origin `<current-local-branch>`
- always run git status to check current status of your git repo
- git branch: This is used to create a new branch (git branch [new-branch-name)
- -git branch -d {branch-name} -- Delete branch
- git checkout -b `<new-branch-name>` `<current-branch-you-are-checking-off-from>`: create new branch off another updated branch
- git checkout "branch-name"(SWITCH INTO A BRANCH)
