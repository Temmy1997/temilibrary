# Sudo User

A sudo command gives trusted user with administrative permission to a linux system without sharing the root user password.

## CREATING A USER WITH USER PERMISSION

## Step 1:

- Login on centos system as root user

## Step 2:

Create a user name -- Temi

- Use the -m option: This create the user's home directory if it does not exit
- Use the -s option: This defines the new user's login shell program (Which is /bin/bash)
- Use the -c option : This defines a comment indicating this is an administrative user's account.
  SYNTAX: useradd -m -s /bin/bash -c "Administrator User" Temi

## Step 3: Set a password for the user account

Syntax: Passwd temi

## Step 4: Prompted user to change their password at their first login

* Use the chage command
* Chage command changes the number of days between password changes and the date of the last password change.
* sudo chage -d 0 (username)
  - 0:  This prompt the user to chnage their password in their next login
  - m: Set the maximun amout of days before a user
  - -l: displays the currennt password for a user.

## Step 5: Put User in Wheel Group

- Only users in wheel group can have the sudo permission and run sudo command.
- Use Usermod to add user to wheel group
- -a :Append user to a supplementary group
- -G : Specifies the group
  SYNTAX: usermod -aG wheel Temi

## Step 6: To check if a user in the Wheels grorup.

1. cat /etc/passwd, and you will see group the name listed
2. or id (username)

## Step 7: To stop asking users for password

* Add the user to the sudoers files

## Step 8: Test the sudo access

- sudo whoami  -- root(Uses the sudo permission to know the admin user)
- sudo ls -al /root  -- (Uses the sudo permission to list the content in /root directory)

Site:https://www.tecmint.com/create-sudo-user-on-centos/

## HOW TO RUN SUDO COMMAND WITHOUT PASSWORD

## Step 1:

sudo visudo (Run this command)

## Step 2:

Add this line -- temi ALL=(ALL) NOPASSWD: ALL  (USER)
                 %sys ALL=(ALL) NOPASSWD: ALL  (Group)

https://www.tecmint.com/run-sudo-command-without-password-linux/
