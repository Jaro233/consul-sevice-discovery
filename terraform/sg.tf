data "aws_vpc" "main" {
  id = "vpc-01707bb84c39d0cec" # Replace with your actual VPC ID
}

resource "aws_security_group" "allow_web" {
  name        = "service-discovery-sg"
  description = "service-discovery-sg"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["54.197.1.214/32"] # Caution: This allows SSH from any IP. For production, restrict to your IP.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_internal" {
  name        = "allow_internal_traffic"
  description = "Allow internal inbound traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "All Traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    description = "Allow 8300-8600"
    from_port   = 8300
    to_port     = 8600
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["54.197.1.214/32"] # Caution: This allows SSH from any IP. For production, restrict to your IP.
  }

  ingress {
    description = "SSH from my ip"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["91.189.139.56/32"] # Caution: This allows SSH from any IP. For production, restrict to your IP.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}