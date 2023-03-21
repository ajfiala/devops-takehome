#!/bin/bash

(
# Update package repositories
sudo yum update -y

# Install Node.js
curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
sudo yum install -y nodejs

# Install git
sudo yum install -y git

# Clone your Moleculer API repository
git clone https://https://github.com/moleculerjs/moleculer-web.git
cd your-api-repo

# Install dependencies
npm install

# Set environment variables for NATS transporter
# ip is the static private IP of the NATS ec2 instance
export NATS_URL=nats://10.0.2.102:4222

# Start the Moleculer API service
npm run start

# Check the exit status of the last command
if [ $? -eq 0 ]; then
  # Command ran successfully
  sudo echo "API Script ran successfully" > /var/log/done.txt
else
  # Command encountered an error
  sudo echo "API Script encountered an error" > /var/log/done.txt
fi
) | sudo tee /var/log/done.txt