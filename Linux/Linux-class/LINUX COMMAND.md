* su options user -- Switch to another user 
* sudo - Provide limited root access 
* rm - delete file 
* rm rt* - Remove all file starting with rt
* rm -rf directoryname : delete directory recursively. 
* rm *.cpp :delete all files with .cpp extension 
* /etc/passwd - where you see users 
* tail - Output of the last part of files
* lid - Displays uers on group users 
* history - used to bring out all the command used 
* cd - 
* :set nu - to put lines in a bash script 
* ctrl c - to kill a process 
* ctrl a : Take me to the front of a command 
* ctrl e - Take to the end of a command 
* cd .. : To go back one step 
* rpm | more 
* To  check and add ports 
	*lsof -i :80  -- to check for port 80 if its listening or not 
	*ss -tulnp | L
* whoami - To check users
* zip: Compresses files and directories into zip format.
* chmod - change the permissions of files and directories
'' chmod [permissions] filename
''
	* Using Numeric Mode
		4 for read (r)
		2 for write (w)
		1 for execute (x)
	* Using Symbolic Mode
		+ to add a permission
		- to remove a permission
		= to set exact permissions

chmod u+rwx filename    # Add read, write, and execute for the user
chmod g-w filename      # Remove write permission for the group
chmod o=r filename      # Set read-only permission for others
chmod a+x filename      # Add execute permission for all (user, group, others)

* chown	Changes file or directory ownership

	USER: The new owner of the file.
	GROUP: The new group associated with the file.

''
chown username filename
chown username:groupname filename

''
* ln - Used to create links between files or directories.
	- Links are pointers to the original file
	''
		ln target_file link_name
	''


''=$PATH:/place/with/the/file -- set a PATH 
*Add export PATH=$PATH:/place/with/the/file to .bashrc file  -- 
*echo -- To check the shell 
*/<word> :  To look for a word in VI editor (In Esc mode)
>  (Redirect Command): To overwrite what in a file
>> (Redirect Command): To append or add what is in a file 
	
--------------Rsync-------------------------------
*This is a fast and versatile command-line utility for synchronizing files and directories between two locations
*It provides fast incremental file transfer by transferring only the differences between the source and the destination.
*In better understanding it is used to copy a single file from one to another local location
*If the destination directory doesn’t exist, rsync will create it.
*Options
	* -a or --achieve : syncs directories recursively
	*--delete
	*-q or --quiet: To prevent non-error messages
	*-e : Allows you to choose a different remote shell
Note: By default, rsync is configured to use ssh.

HOW TO USE 
rsync [Source file] [Destination directory]
Local to Local:  rsync [OPTION] [SRC] DEST
Local to Remote: rsync [OPTION] [SRC] [USER@]IP:DEST]
Remote to Local: rsync [OPTION]... [USER@]IP:SRC... [DEST]

Note:
*SRC-Source
*DEST-Destination

-----------------nano-------------------------
*This is a command-line text editor
*Ctrl+X- To exit, but will ask whether to save or discard the file.
*Ctrl+O - Save a file 
*nano [filename] -- To open a file
*nano allow users to directly interact with the text. 
*There is no need to switch to an edit mode, like in Vim. 
*Shortcuts for using nano
		move forward one character: Ctrl+F (^F)
		move back one character: Ctrl+B (^B)
		move forward one word: Ctrl+Space (^Space)
		move back one word: Alt+Space (M-Space)
		move to the previous line: Ctrl+P (^P)
		move to the next line: Ctrl+N (^N)
		move to the next page: Ctrl+V (^V)
		move to the previous page: Ctrl+Y (^Y)
		move to the beginning of the line: Ctrl+A (^A)
		move to the end of the line: Ctrl+E (^E)

----------wget-----------------------
*This is used to download files drom the web 
*Syntax - wget [options] [URL]

