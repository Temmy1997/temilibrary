# FTP (File Tranfer Protocol)

FTP(File Transfer Protocol) is used to transfer files and information between two system over a network.
But using this protocol ie not secure because it does not encrypt the traffic 
VSFTPD (Very Secure FTP Daemon)- This is a secure, stable, and fast FTP server 
VSTM is used as a default FTP server 

## INSTALLING FTP SERVER 
## Step 1: Installing FTP server 
    1. Install VFTPD System (yum install vdftpd -y)
    
    2: Enable and run VSFTPD
        Enable - systemctl enable vsftpd
        Start - systemctl start vsftpd
        Restart - systemctl restart vsftpd
        Status - systemctl status vsftpd
    
    3 Allow ports in firewall
        *firewall-cmd --zone=public --permanent --add-port=21/tcp
        *firewall-cmd --zone=public --permanent --add-service=ftp
        *firewall-cmd --reload

## Step 2: Configuring FTP server 
    1   Backup the original  vsftpd config file 
             sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.orig
    
    2. Open the vsftp config file 
            sudo vi /etc/vsftpd/vsftpd.conf
    
    3. Edit the file 
            anonymous_enable=NO             # disable  anonymous login
            local_enable=YES		        # permit local logins
            write_enable=YES		        # enable FTP commands which change the filesystem
            local_umask=022		            # value of umask for file creation for local users
            dirmessage_enable=YES	        # enable showing of messages when users first enter a new directory
            xferlog_enable=YES		        # a log file will be maintained detailing uploads and downloads
            connect_from_port_20=YES        # use port 20 (ftp-data) on the server machine for PORT style connections
            xferlog_std_format=YES          # keep standard log file format
            listen=NO   			        # prevent vsftpd from running in standalone mode
            listen_ipv6=YES		            # vsftpd will listen on an IPv6 socket instead of an IPv4 one
            pam_service_name=vsftpd         # name of the PAM service vsftpd will use
            userlist_enable=YES  	        # enable vsftpd to load a list of usernames
            tcp_wrappers=YES  		        # turn on tcp wrappers

    4. Configure FTP to allow/deny FTP access to users based on the user list file 
        * If userlist_deny=YES, Users listed in the /etc/vsftpd/user_list are denied login access 
        * If userlist_deny=NO, only allow users in this file
    
    5 Restrict FTP users to their Home directories
        * Add these two following options to the /etc/vsftpd/user_list file 
            * chroot_local_user=YES : Local users will be placed in a chroot jail, whcih is their home directory.
            * allow_writeable_chroot=YES :  To allow chroot directory to be writable. 
    6 Save the /etc/vsftp/user_list file 

## Step 3: Securing FTP Server with SELinux
    * Set SELinux boolean to allow FTP to read files in a user’s home directory.
        Command : sudo setsebool -P tftp_home_dir on 
    * Set SELinux rule to allow FTP to read/write user’s home directory
         sudo semanage boolean -m ftpd_full_access --on
    * Restart vsftpd
        sudo systemctl restart vsftpd

## Step 4: Testing FTP Server
    1. Create FTP user 
        sudo useradd ftpTemi
    2. Create Password 
        sudo passwd ftpTemi
        
