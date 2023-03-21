#!/bin/bash

(
# Update package repositories
sudo yum update -y

# Install Docker
sudo amazon-linux-extras install docker -y
sudo systemctl enable docker
sudo systemctl start docker

# Run NATS Docker container
sudo docker run -d --name nats -p 4222:4222 nats:latest

# Check the exit status of the last command
if [ $? -eq 0 ]; then
  # Command ran successfully
  sudo echo "NATS Script ran successfully" > /var/log/done.txt
  sudo echo "NATS Script ran successfully" > ~/done.txt
else
  # Command encountered an error
  sudo echo "NATS Script encountered an error" > /var/log/done.txt
  sudo echo "NATS Script encountered an error" > ~/done.txt
fi
) | sudo tee /var/log/done.txt