Project: Molecular JS application deployment

Prerequisites:
1. AWS cli
2. Terraform

Installation and setup:
1. Configure your AWS cli to use your AWS account's access key and secret access key. This is     what terraform will use to authenticate with AWS by default. 
2. Create an S3 bucket for storing your tf state. Change the name and filepath for the AWS backend in providers.tf to match the new bucket.
3. Change the Github URLs in the user data scripts to the URL of the molecular services you would like to deploy

Configuration: Region and availability zone may be changed in the providers.tf file

Usage: Run the command "terraform init" inside the terraform folder. Assuming your AWS cli is configured correctly and your account has the appropriate permissions to deploy/manage AWS infrastructure in your selected region, you can then run the command "terraform apply" to deploy the infrastructure. Enter "yes" when prompted. 
If you encounter errors, you can see the detailed logs by changing the TF_LOG environment variable. Enter the following command: "export TF_LOG="debug". When you run terraform apply again you will see more detailed logs that may explain why your deployment is not working. 

Testing: Use SSM connect and type "systemctl status (service name)". You can also run the following command using the aws cli to port-forward the service to your local machine:

aws ssm start-session --target <instance-id> --document-name AWS-StartPortForwardingSession --parameters "portNumber=<remote-port>,localPortNumber=<local-port>"

If successful, you should be able to access the application on your local machine at localhost:serviceport 

