Link to an SSH Blog
	https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server

## SSH

*SSH IS A SECURE
*IN SSH there are teo types of authentication
-Password
-Keys

*SSH Keys are more secure and reliable that the password
*SSh key pairs are two cryptographically secure keys
*{SSH key gen} used to generate key
	-Private Keys : These should be kept secret by the owner of the key
	 -Public Keys : This key is given to the remote server

*10.0.0.17 - JumpBox/ Bastion Host
*10.0.0.15 - Remote server

# Configuring SSH

# Step 1(Creating SSH KEYS)

*Create the SSH key on the jumpbox
*Command :ssh-keygen
*By default, this will create a 3072 bit RSA key pair
	*Private key - id_rsa
	*Public key - id_rsa.pub

# Step 2 (Copying an SSH Public Key to Your Server)

*There are several ways to to copy public key to an existing server

    1.Copying the public key using (ssh-copy-id) command
		*This command is already in an OpenSSH packages
		*This means it might alredy be available in your local system
		*When using the commad you will have to specify the REMOTE host
	Syntax: ssh-copy-id username@remotehost(IP)
		*This syntax will scan your jumbox for the public key )id_rsa.pub
		*After that it will ask for the passwrd of the remote user's account
		*The result of this syntax will copy the piblic key and its content to a file in the remote's account
		*It will be copied into a (authorized_keys file) under ~.ssh directory

    2. Copying Your Public Key Using SSH
		*Copy the contnet of the public key
		*Put the content into a file name (authorized_keys)
    *This authorized key file should be under ~.ssh directory

    *Password of the remtote host will be asked

# Step 3:(Authenticating to Your Server Using SSH Keys)

    To log into the remote host use:
		*ssh username@remote_host
	*It might ask for password

# Step 4 :Disabling Password Authentication on your Server

*Sometimes you might be able to go into a remote srver without password
*Howver if it  ask for passowrd, then we will have to change the password authentication to NO
*To do this you have to go into the sshd configuration file
	*Syntax: vim /etc/ssh/ssh_config
*Inside this file we will chnage the passowor authentication to ( NO)
*After chnaging it to NO , we retart the sshd service
	*Syntax: systemctl restart ssh

SSH CONECTION 
* SSH aia a protocol for remote co nection. 
  Remote conection  can be used ub terms of jeys or password 
  The most secure way is keys,. 

  KEYS 
  * Public key 
  * Private key 


  * 

CLIENNT 
1. ssh-keygen
id_rsa






SERVER 
