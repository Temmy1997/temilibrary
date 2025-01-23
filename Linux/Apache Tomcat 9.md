# Install Tomcat 9 on CentOS 8
Apache Tomcat is an open-source java-capable HTTPS server developed by the Apache software foundation. 
* Apaceh tomact is used to execute special jave programs known as "JAVA SERVLET" 
  ## INSTALLATION 
1. Install Java on CentOS 8
   Note: 
   *Check if Java is alredy installed 
   * java --version 
   * If not installed use this command:
        sudo yum -y install java-11-openjdk java-11-openjdk-devel 
2. Create tomcat user and group
   Mkdir /opt/tomcat
   Create a group: groupadd tomcat 
   Create a user: useradd -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
3. Download Tomcat 
   export VER="9.0.64"
wget https://archive.apache.org/dist/tomcat/tomcat-9/v${VER}/bin/apache-tomcat-${VER}.tar.gz

4. Extract downloaded file into /usr/share
   sudo tar xvf apache-tomcat-${VER}.tar.gz -C /usr/share/
   
5.  Create a symbolic link to extracted tomcat data 
   sudo ln -s /usr/share/apache-tomcat-9.0.64/ /usr/share/tomcat

6. Set proper directory permissions.
   chown -R tomcat:tomcat /usr/share/tomcat/
   chown -R tomcat:tomcat /usr/share/apache-tomcat-9.0.64/

7. /usr/share/tomcat will contain:
   bin: Contains binary and scripts
   conf: System-wide configuration files 
   lib: Webapps to be deployed 
   logs: Tomcat logs files 
   temp  
   webapps:  Tomcat's system wide library 
   work: Tomcat's working directory
8. Start and enable the Tomcat service 
    systemctl status tomcat
    systemctl enable tomcat
9.  Configure Firewall
    * Allow Port used by tomcat on the firewall – TCP port 8080
    * firewall-cmd --permanent --add-port=8080/tcp
    * Reload firewall
    * firewall-cmd --reload 
10. Open the Tomcat configuration file:

sudo vi /usr/share/tomcat/conf/tomcat.conf
 
 * Add the following JAVA_OPTS line to the file: 
 JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC"

 11. Install some admin tools that will help you deploy your Java applications and manage your virtual hosts
   
   sudo yum install tomcat-webapps tomcat-admin-webapps
 
 NOTE: This adds the ROOT, examples, sample, manager, and host-manager web apps to the tomcat/webapps directory.

12. Configure Tomcat Web Management Interface

* Edit the tomcat-users.xml file
  
  sudo vi /usr/share/tomcat/conf/tomcat-users.xml

  NOTE: In order to use the manager webapp installed in the previous step, we must add a login to our Tomcat server.


  <tomcat-users>
    <user username="temi" password="Temitope1997" roles="manager-gui,admin-gui"/>
</tomcat-users>
 
 * Restart the server 
  systemctl restart tomcat

  13. Access the Web Interface
* Open in web browser:
http://server_IP_address:8080

* look at the Manager App
 http://server_IP_address:8080/manager/html

 NOTE: The Web Application Manager is used to manage your Java applications. You can Start, Stop, Reload, Deploy, and Undeploy here.

 * look at the Host Manager,
http://server_IP_address:8080/host-manager/html/

NOTE:
From the Virtual Host Manager page, you can add virtual hosts to serve your applications from.

14. Finally, i can now deploy my own Java web applications!

REFRENCES 
https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-7-on-centos-7-via-yum
