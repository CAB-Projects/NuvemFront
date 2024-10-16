# Use a base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install necessary packages


# Copy your application files
COPY . .

# Install dependencies (?)

# Expose the port your application runs on
#EXPOSE 5000

# Define the command to run your application
#CMD ["python3", "app.py"]
