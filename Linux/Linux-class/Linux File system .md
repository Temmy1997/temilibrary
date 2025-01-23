# LINUS FILES SYSTEM
The linus file system is an hierachial tree structure, starting form the root directory (/) 

## /root – The home directory of the root
** home directory of the root user.
* The home of root is located at /root
* It id diffrent from (/)
  

## /bin
- Contains mostly binaries(Binaries are some application and program that you can run)
- Contains the commands we use in linux 

## /dev 
- Contains device files
- Some of the files are generated at boot time.  

## /etc
- Everthing to configure.
- Contains most, if not all the configuration files 

## /home 
ThIS IS THE HOME Directory of all the users 
* You will find all tthe users personal directories 
* /home/user
  
## /lib
* All the libraries are found here 
* The libraries are the files that contain coodes that applicationns can use 

## /media 
* Directory for external storage 
* When you plug in an external storage  it is automatically mound on the /media directory

## /sbin – System binaries
* Similar to the /bin directory. 
* Only difference is that is contains the binaries that can only be run by root or a sudo user.

## /tmp – Temporary files
*  Holds temporary files. 
*  
## /var – Variable data files
* Programs store runtime information like system logging, user tracking, caches, and other files that system programs create and manage.
* Information about the system behavior can be founf in this directory.

## /boot – Boot files
* Contains the files of the kernel and boot image
* LILO and Grub

## /proc – Process and kernel files
* Contains the information about currently running processes and kernel parameters.
* runtime system information.

## /opt – Optional software
Coontains third-party applications files that are not available from the distribution’s repository

## /mnt – Mount directory
* Used to manually mount a filesystem.

## /usr 
* ‘/usr’ go all the executable files,
* ‘/usr/bin’ contains basic user commands
‘/usr/sbin’ contains additional commands for the administrator
‘/usr/lib’ contains the system libraries
‘/usr/share’ contains documentation or common to all libraries, for example ‘/usr/share/man’ contains the text of the manpage

## /srv – Service data
The /srv directory contains data for services provided by the system.