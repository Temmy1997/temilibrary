## Access Control List(ACL)
* ACL is the list of additonal users/groups and their permission tot he file.
*This is used when mutiple users from diff group need access to the same file. 

# How to know a file has ACL attached to it
* Command ls -l output shows files, their user,groups and permission.
* When a file has a + sign at the end of the permission, it shows that the file has an ACL attached to it.
For Example: -rw-r--r-+ 1   root   root  0  Sep  19  14:41  file. 

# VIEWING ACL
*getfacl is the command used to display the ACL information of a file. 
*When you display a file with no ACL , this is the results you wil see
	# getfacl test
	# file: test
	# owner: root
	# group: root
	user::rw-
	group::r--
	other::r--
*When you display a file with ACL attached to the file, this is the result you will see
	# getfacl /tmp/test
	# file: test
	# owner: root
	# group: root
	user::rw-
	user:john:rw-
	user:sam:rwx
	group::r--
	mask::rwx
	other:---

# CREATING AND MANAGING FACL
*Command setfacl is used to set ACL on a file.
*Command to set ACL on a file that a user can access on the file rw /tmp/test
	# setfacl -m u:john:rw /tmp/test
	Where:  u: users 
		   -m: used to modify ACLs on the file(s) mentioned in command line.
		   rw: read and write permission. 
*Command to set ACL on a file that a group with several users can access on the file rw /tmp/test
	# setfacl -m g:accounts:rw /tmp/test
	Where: g: groups with several users 
		   -m: used to modify ACLs on the file(s) mentioned in command line.
		   rw: read and write permission. 
			
# Default FACLs on directories 

*Default ACLs are only created on directores
*Therefore any file created in these directories, will automatically have a default FACL assigned to it. 
*Command to use it 
	*setfacl -m default:u:user:rw /directory
Result is: 
	getfacl accounts/
#   file: accounts/
#   owner: root
# group: root
user::rwx
group::r-x
other::r-x
default:user::rwx
default:user:john:rw-
default:group::r-x
default:mask::rwx
default:other::r-x
	
# REMOVING FACL 
	*We remove the FACL WITH -x