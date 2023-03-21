#!/bin/bash

(
# Update package repositories
sudo yum update -y

# Install Node.js
echo "Installing Node.js..."
curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
sudo yum install -y nodejs

# Install git
echo "Installing git..."
sudo yum install -y git

# Clone your Moleculer Service#1 repository
echo "Cloning Moleculer Service#1 repository..."
# service uses port 3000
git clone https://https://github.com/moleculerjs/moleculer.git
cd your-service1-repo

# Install dependencies
echo "Installing dependencies..."
npm install

# Set environment variables for NATS transporter
echo "Setting environment variables for NATS transporter..."
# ip is the static private IP of the NATS ec2 instance
export NATS_URL=nats://10.0.2.102:4222

# Start the Moleculer Service#1
echo "Starting Moleculer Service#1..."
npm run start

# Check the exit status of the last command
if [ $? -eq 0 ]; then
  # Command ran successfully
  echo "Service#1 Script ran successfully"
else
  # Command encountered an error
  echo "Service#1 Script encountered an error"
fi
) | sudo tee /var/log/done.txt