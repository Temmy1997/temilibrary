## Creating and editing files 
touch , vim, sed, nano, cat, mkdir, 

## Running programs 
systemctl (systemd)
command to check process 

## Managing users, groups and permissions

## Understanding where programs and system files are kept  

## Configuring network connections and firewalls

## Installing and configuring software 


## Building and compiling software

## Monitoring programs and processes

## Automating all of the things above (BASH, PYTHON, ANNSIBLE)


Assignment :
1. Read and complete the above heading with commands 
2. I want you to personally find one automating project each on 
- bash scripting 
- python https://chat.openai.com/chat

Bash project 
#!/bin/bash

# Ask user to input source and destination directories
read -p "Enter source directory: " src_dir
read -p "Enter destination directory: " dest_dir

# Ask user whether to move all files or specific file types
read -p "Do you want to move all files or specific file types? (all/specific): " file_choice

if [ $file_choice == "all" ]
then
  # Move all files in the source directory to the destination directory
  mv $src_dir/* $dest_dir/
else
  # Ask user to input file type to move
  read -p "Enter file type to move (e.g. txt, pdf): " file_type

  # Move only files with the specified file type to the destination directory
  mv $src_dir/*.$file_type $dest_dir/
fi

# Confirm that files have been moved
echo "Files have been moved from $src_dir to $dest_dir."
