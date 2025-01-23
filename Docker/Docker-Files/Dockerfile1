# # This is my sample image
# FROM ubuntu:18.04
# LABEL maintainer="Temitope Oyeniyi" version="1.0"

# # RUN comand is usded to execute command on the command line during the image build process. 
# RUN apt-get update
# RUN apt-get install -y nginx 
# # CMD command is used to specify default command that will be executed when the container is crreated from the image. 
# CMD 


# ********************
# Dockerfile for Webserver Image
FROM httpd:2.4

# Copy the htmk directory into the image
COPY html /usr/local/apache2/htdocs/

# ***********************
# Dockerfile for pyhton web application image 
FROM python:3.8-slim-buster  

# Copy the present whole python directory to /app
COPY . /app

# WORKDIR sets the working directory as "/app" directory in the container.
WORKDIR /app

# RUN instruction is used to execute command in the container. 
# pip is the package installer for Python
# requirements.txt is the file containing a list of dependencies/packages that need to be installed.
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# EXPOSE informs Docker that the container will listen on port 5000 at runtime. 
EXPOSE 5000

# CMD command will allow the command "python app.py" to be executed by default when the container is launched. 
CMD ["python", "app.py"]