# DOCKER

A docker container image is a light weight stand alone executable package of software that includes everything it needs to run an application

VM - OS - CONTAINERS - APPLICATIOM
## BENEFITS OF DOCKER
1. Isolation of application servers from the undelying host. 
2. Optimizing $ minimization of pysical servers 
3. Applications can be package and shipped 
4. Makes it easy to deploy application


## Process to create a docker container

1. App Code / Binary
2. Dockerfile
3. Docker Image
4. Docker Containers

IMAGE => CONTAINER

* Docker images is built from Dockerfile.
* All Dockerfile
* The whole idea of Docker is for developers to easily develop applications, ship them into containers which can then be deployed anywhere.

## Components of docker

Docker Engine − It is used for building Docker images and creating Docker containers.

Docker Hub − Docker Hub is a registry service on the cloud that allows you to download Docker images that are built by other communities. You can also upload your own Docker built images to Docker hub.

Docker Compose − This is used to define applications using multiple Docker containers.

## HOW TO INSTALL DOCKER

1. Step 1:
sudo yum -y update
sudo yum install -y docker

2. Step 2: Check if docker is installed 
docker
docker --version

3. STEP 3: start DOCKER
sudo systemctl start docker

4. Step 4: Add user to docker group
sudo usermod -a -G docker ec2-user

If there is no docker group then create one 

NOTE: After running this command, you may need to log out and log back in for the group membership changes to take effect.


***
1. Set up the repository
   code:
   sudo yum install -y yum-utils
   sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
2. docker run = Used to run doacker image
***

NOTE: A place where we keep docker images is called registry(E.G Dockerhub, Gitlab)

## Important Docker Command 
* docker build = Used to build an image from a docker file. 
   -t: This option specifies the name and optionally a tag to be applied to the Docker image
* Docker pull = Used to pull docker images
* docker image = List docker images 
* docker run = Run a docker image 
* docker  ps = Show running containers  
* docker inspect "container name" = To show info about a container 
* docker rm = Remove docker container 
* docker rmi -f :  remove docker images 
* 


## Docker File

* Docker file is a test file or scripts that is useed to automate the process of creating custom docker images.
* A Docker File is a simple text file with instructions on how to build your images.

## HOW TO CREATE A DOCKER FILE

1. Create a file called Docker File and edit it using vim. Please note that the name of the file has to be "Dockerfile" with "D" as capital.
2. Build your Docker File using the following instructions

## Format of a Dockerfile
FROM ubuntu:18.04
LABEL maintainer="Temitope Oyeniyi" version="1.0"

* COMMAND arguments 
RUN apt-get update
RUN apt-get install -y nginx 

NOTES 
* RUN comand is used to execute command on the command line during the image build process.
* CMD command is used to specify default command that will be executed when the container is crreated from the image. 
* COMMAND - Uppercase
* arguments - lowercase
  
## HOW TO BUILD A DOCKER IMAGE 
docker image -t "name of the image" .
* dot = This is the current working directory where the docker file is located 

## How to create a docker container 
docker run --name web1 -d -p 80:80 "DOCKER IAMGE NAME" 

## Meaning of the options used in the above command 
--name : Name of the container
-d : Run the command in the backgroud
-p : port (because container run in an internal network, we access the container from outside by using 
   the -p otion" (This is called port mapping)
   * 80:80
   * First 80 = Host port - (The virtual machine i'm using) 
   * Second 80 = Container port 
   * The first post route its request to the second port 

## Docker HUB - Public Repositories
Docker Hub is a registry service on the cloud that allows you to download Docker images that are built by other communities.
* You can also upload your own Docker built images to Docker hub

1. Create a repository in docker hub
2. When building the images make sure to put the repository name
   COMMAND:
   docker build -t webserver/web-temi:1.0 .
3. Tagging an existing local image
   COMMAND:
   docker tag `<existing-image>` `<hub-user>`/`<repo-name>`[:`<tag>`]
   docker tag webserver/web-temi:1.0 temmy1997/web-temi:1.0
4. Commit the changes
   COMMAMD:
   Syntax- docker commit `<existing-container>` `<hub-user>`/`<repo-name>`[:`<tag>`]
   docker commit web-container temmy1997/web-temi:1.0

## Assignemnt 1 

Containerize the PG-Project, by creating a custom web server image for thr project. Test the image locally, make sure you can access the website from the browser, piublish your custom docker image to dockerhub.

ANSWER

1. Create the Dockerfile
2. Use the docker build command to build the image.
3. You can test the image by running the following command
   COMMAND:
   docker run -d -p 80:80 --name web-container webserver/web-temi:1.0
4. Enter the container
   COMMAND:
   docker exec -it web-container bash

   

## Assignment 2
Dockerize a smple ythin website

# Use an official Python runtime as a parent image
FROM python:3.8-slim-buster

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["app.py"]


## ASSIGNMENT 3
 Dockerizing a simple Flask web app using Pythonn

1. Write your Flask web app code in a file named "app.py"
   NOTE:
   * Make sure to use FLask Python beacuse it is used for developing web application using python.
2. Create a file named "Dockerfile" in the same directory as your "app.py" file.
3. Create a file named "requirements.txt" in the same directory as your "app.py" file.
4. Build the Docker image
   SYNTAX: docker build -t "Image name"
   docker build -t my-flask-app .
5. Run the Docker container using the following command:
   docker run -d -p 5000:5000 --name python-web my-flask-app
   CMD => Default command that is executed when you start a container



