# Use an official Python runtime as a parent image
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# RUN instruction is used to execute command in the container. 
# pip is the package installer for Python
# requirements.txt is the file containing a list of dependencies/packages that need to be installed.
# Install any needed packages specified in requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# EXPOSE informs Docker that the container will listen on port 5000 at runtime. 
EXPOSE 5000

# Define the commnad to Run app.py when the container launches
CMD ["python", "app.py"]
