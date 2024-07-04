provider "aws" {
  region     = "us-east-1"

}

resource "aws_security_group" "deployment_sg" {
  name        = "deployment_sg"
  description = "Security group for deployment server"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

variable "aws_access_key" {
  description = "The AWS access key"
  type        = string
}

variable "aws_secret_key" {
  description = "The AWS secret key"
  type        = string
}


  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "deployment" {
  ami           = "ami-04a81a99f5ec58529" # Ubuntu Server 20.04 LTS AMI ID for us-east-1 (N. Virginia)
  instance_type = "t2.micro"
  security_groups = [aws_security_group.deployment_sg.name]

  tags = {
    Name = "deployment"
  }
}

data "aws_vpc" "default" {
  default = true
}

