# ************* PATH IN LINUX SYSTEM *****************

-- A path is how you refer to files and directories.

-- It gives the location of  a file or directory in the linux directory structure. 

-- There are two paths to files and directory on a linux box 
   - Absolute path:
     -- This always starts from the root directory(/).    
   - Relative path:
     -- This always starts from the current directory (.) 

FOR EXAMPLE
* Current directory: /home/Temi
-We have a test.py file inside the Temi home directory -Copy the test.py file to temi-scripts directory using:
    - The absolute path to locate it 
	- The relative path to locate it 
	
ANSWER 
- Using the absolute path
     /home/vagrant/test.py 
  - cp /home/vagrant/test.py /home/vagrant/scripts/temi-scripts
  
  
- Using the relative path 
    - This depends on where you are currently 
	- let's say i am in /home/vagrant/scripts
	 - cd ./temi-scripts
	 