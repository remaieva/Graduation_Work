provider "aws" {
  region = var.aws_region
  shared_credentials_file = var.cred_file
  profile = var.profile
}

resource "aws_instance" "jenkins_instance"{
  instance_type = "t2.micro" 
  tags = {
    Name = "Instance from TF"
  }
  ami = var.ami
}

resource "aws_vpc" "vpc_jenkins_instance" {
  assign_generated_ipv6_cidr_block = "false"
  cidr_block                       = "172.31.0.0/16"
  enable_classiclink               = "false"
  enable_classiclink_dns_support   = "false"
  enable_dns_hostnames             = "true"
  enable_dns_support               = "true"
  instance_tenancy                 = "default"
}
resource "aws_subnet" "subnet_jenkins_instance" {
  assign_ipv6_address_on_creation = "false"
  cidr_block                      = "172.31.0.0/20"
  map_public_ip_on_launch         = "true"
  vpc_id                          = var.vpc 
}
resource "aws_security_group" "SG_jenkins_instance" {
  description = "launch-wizard-2 created 2020-07-27T23:46:59.953+03:00"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
    from_port   = "80"
    protocol    = "tcp"
    self        = "false"
    to_port     = "80"
  }

  ingress {
    cidr_blocks = ["176.36.3.185/32"]
    description = "jenkins master"
    from_port   = "8081"
    protocol    = "tcp"
    self        = "false"
    to_port     = "8081"
  }

  ingress {
    cidr_blocks = ["176.36.3.185/32"]
    description = "ssh"
    from_port   = "22"
    protocol    = "tcp"
    self        = "false"
    to_port     = "22"
  }

  name   = "SGforGW"
  vpc_id = var.vpc
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = var.public_key_path
}