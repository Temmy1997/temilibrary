# Docker Volume 
* Docker volume is used to manage data between containiers to ensure that the data survives even if the container are removes 
* Docker volume is usd to store files on the docker docker host machine, which can also be mounted in the container. 
* This allows the files to be avaliable on the host once thecontainer has has been stopped or deleted. 

## Command:
1. docker volume ls  : List volume
2. docker volume create      Create a volume
3. docker volume inspect     Display detailed information on one or more volumes
4. docker volume prune       Remove unused local volumes
5. docker volume rm          Remove one or more volumes

- v volume-name:directory inside the container 
docker run -dit -p 80:80 -v vol1:/usr/local/apache2/htdocs  --name apache2 my-apache-container
/usr/local/apache2/htdocs/

docker run -it --rm --name nginx -p 8080:80 -v "$(pwd)"/target:/usr/share/nginx/html nginx


## BIND MOUNT 
* Bind mounts are another way to give containers access to files and folders on your host.
* They directly mount a host directory into your container. 
* Any changes made to the directory will be reflected on both sides of the mount



 # DOCKER COMPOSE 
* Used to run mutiple containers as a single service container 
FOR EXAMPLE:
If you had an application that requires NGINX and MYSql, docker smpute will help in creating one file and strta both the container as a service 
* Docker compose uses a YAML file to configure the applcation services 
* With just a simgle command, you can create and start all the services from the configuration 

## DOCKER COMPOSE FILE TEMPLATE 

Version: "3.7"
Services: 
    ...
volumes:
    ...
networks:
    ... 
## NOTES    
1. Specify the version of the compose file
2. It must have at least one service. 
3. Volumes and network are optional


 Create docker-compose.yml file 


