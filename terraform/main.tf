provider "aws" {
  region = "us-east-1"
}

data "aws_key_pair" "deployer" {
  key_name   = "ec2_apache"
  include_public_key = true
}

resource "aws_instance" "consul_server" {
  ami           = "ami-0c7217cdde317cfec" # Replace with the latest Ubuntu AMI in your region
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_internal.id]
  tags = {
    Name = "ConsulServer"
  }
  key_name      = data.aws_key_pair.deployer.key_name
}

resource "aws_instance" "backend_service" {
  ami           = "ami-0c7217cdde317cfec" # Replace with the latest Ubuntu AMI in your region
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_internal.id]
  tags = {
    Name = "BackendService-1"
  }
  key_name      = data.aws_key_pair.deployer.key_name
}

resource "aws_instance" "backend_service_2" {
  ami           = "ami-0c7217cdde317cfec" # Replace with the latest Ubuntu AMI in your region
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_internal.id]
  tags = {
    Name = "backend_service-2"
  }
  key_name      = data.aws_key_pair.deployer.key_name
}

resource "aws_instance" "nginx_load_balancer" {
  ami           = "ami-0c7217cdde317cfec" # Replace with the latest Ubuntu AMI in your region
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_web.id, aws_security_group.allow_internal.id]
  tags = {
    Name = "NginxLoadBalancer"
  }
  key_name      = data.aws_key_pair.deployer.key_name
}


