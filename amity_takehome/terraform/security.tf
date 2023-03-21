# security groups for the services/NATS

resource "aws_security_group" "api" {
  name        = "api"
  description = "Allow traffic on API port"
  vpc_id      = aws_vpc.molecular_app.id

  ingress {
    description = "ingress to API port"
    from_port   = 3000
    to_port     = 3000
    protocol    = "HTTP"
    cidr_blocks = [aws_vpc.molecular_app.cidr_block]

  }

  egress {
    from_port        = 3000
    to_port          = 3000
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "api"
  }
}



resource "aws_security_group" "natssg" {
  name        = "natssg"
  description = "Allow traffic on NATS port"
  vpc_id      = aws_vpc.molecular_app.id

  ingress {
    description = "ingress to API port"
    from_port   = 4222
    to_port     = 4222
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.molecular_app.cidr_block]

  }

  egress {
    from_port        = 4222
    to_port          = 4222
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "natssg"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow inbound traffic to ALB"
  vpc_id      = aws_vpc.molecular_app.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

