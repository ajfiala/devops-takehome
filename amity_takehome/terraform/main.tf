# ec2 instances 
# 4 instances in total.
# api, service1, service2, NATS transporter

resource "aws_instance" "api" {
  security_groups      = ["natssg", "api"]
  ami                  = "ami-06d993bf69edae76b"
  instance_type        = "a1.medium"
  subnet_id            = aws_subnet.ap_private_1.id
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name
  user_data            = file("./user_data_scripts/install_software_api.sh")
  depends_on = [
    aws_internet_gateway.molecular_app_gw
  ]
}

resource "aws_instance" "service1" {
  security_groups      = ["natssg"]
  ami                  = "ami-06d993bf69edae76b"
  instance_type        = "a1.medium"
  subnet_id            = aws_subnet.ap_private_1.id
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name
  user_data            = file("./user_data_scripts/install_software_service1.sh")
  depends_on = [
    aws_internet_gateway.molecular_app_gw
  ]
}

resource "aws_instance" "service2" {
  security_groups      = ["natssg"]
  ami                  = "ami-06d993bf69edae76b"
  instance_type        = "a1.medium"
  subnet_id            = aws_subnet.ap_private_1.id
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name
  user_data            = file("./user_data_scripts/install_software_service2.sh")
  depends_on = [
    aws_internet_gateway.molecular_app_gw
  ]
}

# 
resource "aws_network_interface" "natinterface" {
  subnet_id  = aws_subnet.ap_private_1.id
  private_ip = "10.0.2.102"
  attachment {
    instance     = aws_instance.NATS.id
    device_index = 1
  }

}

resource "aws_instance" "NATS" {

  ami                  = "ami-06d993bf69edae76b"
  security_groups      = ["natssg"]
  instance_type        = "a1.medium"
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name


  subnet_id = aws_subnet.ap_private_1.id
  user_data = file("./user_data_scripts/install_software_nats.sh")
  depends_on = [
    aws_internet_gateway.molecular_app_gw
  ]
}
