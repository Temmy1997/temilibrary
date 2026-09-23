# LINUX FILE PERMISSION 
Linux is an open source and multi-user operating system.
-- This means it can be accessed by many users simultaneously.
-- Beacuse it can be accessed by many users it raises security concerns as data can be corrupted damaged or stolen.  
	
## Ownership: Every files and directory is assigned three types of owner. Which are: 
*User: This is the owner of the file which is the porsion that creatd the file
			 
*Group: This contains mutiple users.
All users belonging to a group will have the same access permissinon to a file. 

*Other: This is any other user who has access to a file. 
This user does not own a file 
This user does not belong to a user group.
	
## Permission:Every file and directory has three permissinons. Which are:
*Read: This permisson gives the suthority to open and read a file.
-It list the content of the file
				
*Write: This  gives the authority to modify the content of a file
-It can add, remove and rename files stores in the directories.
				
*Execute: We always give execute permission to a bash script before we run it
-When you add execute permission to a file, it becomes an executable file You can't run a program unless the exceute permission is set.

-The reason we give execute permission, is mainly for executing/running scripts on the shell.
							    
Note:
	r  : Read permissinons
	w : Write permissinon
	x  : Execute permissinon
	-  :  no permissinon
			
Note: The first (-) means it is a file and (d) means its a directory 
		
For example:
-rw-rw-r--
			
Answer:
First part (rw-): Means read, write or edit the file but dont execute the file

Second part(rw-): This is a user group and its means you can only read, write, or edit the file.
			
Third part(r--): Means you can only read the file.
			
## CHANGING FILE AND DIRECTORY PERMISSION 
*This helps a file or directory to not be seen by other people 
    * The command to use is:
* Syntax: chmod(change mode) permission(read,write,execute) filenme 

Ways to use this command are:
1.Absolute(Numeric) mode:
*Files permissinon are represented as digit or number
*Permission can be changed for all the three owners.
	Number 				Permission type 					Symbol
		0						No permission					---
		1						Execute							--x
		2 						Write							-w-
		3						Execute and Write			    -wx
		4						Read							r--
		5						Read amd Execute			    r-x
		6						Read and Write					rw-
		7						Read , Write, and Execute		rwx
	 
NOTE:- 
- Read 4
- Write 2
- Execute 1 
	
2.Symbolic mode:
*Permission can be changed or modified for a specific owner 

*It makes use of mathematical symbols to modify a file or directory
		
Operator 							Decription
	+								Means to add a permission to a file or directory
	-								Means to remove the permision 
	=								Means to set the permissinon and overides the permissinon set earlier
			
			
User are represented as 
	u:        User/owner
	g:			Group
	o:			Other
	a:			All
					
CHANGING OWNERSHIP AND GROUP
	*The command to use is 
For user: sudo chown user filename
For group:sudo chown user:group filename/folder 

Options:
-R : Recutsive make all the files in a firectory a particular user 
				

ASSIGNMENT 

1. Create a file named bashscript.sh 
   - Write a simple bash script to print out Your name, Your age, and your Hobby on different lines 
   - Give the neccessary permission to the file, so the file can be executed 
   - Give permissions to block the file from being accessed by the public, and give group ownership just r permission 
   
2. Read about 
   - Creating/Deleting users and groups on a linux system
               			   



                              ask a user what is ther user name 
                              check if the value 








patch master 
check master node 
use lssam to check the 