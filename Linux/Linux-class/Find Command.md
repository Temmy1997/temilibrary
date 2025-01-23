# FIND COMMAND 
Find command is used to search and lolcate the list of files and directory.
 * You can find files by: 
 1. Permission 
 2. Users
 3. Group 
 4. Files types
 5. Date
 6. Size

 # Find Files Using Name in Current Working Directory
find . -name Filename

Permission 
find . -type f -name "file1.php"

* Find file system that does not end in "php"
find . -type f -not -names "*php"
