provider "aws" {
  region = var.region
}

data "aws_key_pair" "deployer" {
  key_name           = var.key_name
  include_public_key = true
}

resource "aws_instance" "consul_server" {
  ami                    = var.ami # Replace with the latest Ubuntu AMI in your region
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_internal.id]
  tags = {
    Name = "ConsulServer"
  }
  key_name = data.aws_key_pair.deployer.key_name
}

resource "aws_instance" "backend_service" {
  ami                    = var.ami # Replace with the latest Ubuntu AMI in your region
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_internal.id]
  tags = {
    Name = "BackendService-1"
  }
  key_name = data.aws_key_pair.deployer.key_name
}

resource "aws_instance" "backend_service_2" {
  ami                    = var.ami # Replace with the latest Ubuntu AMI in your region
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_internal.id]
  tags = {
    Name = "BackendService-2"
  }
  key_name = data.aws_key_pair.deployer.key_name
}

resource "aws_instance" "nginx_load_balancer" {
  ami                    = var.ami # Replace with the latest Ubuntu AMI in your region
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_web.id, aws_security_group.allow_internal.id]
  tags = {
    Name = "NginxLoadBalancer"
  }
  key_name = data.aws_key_pair.deployer.key_name
}