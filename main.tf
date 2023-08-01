terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "sg_ssh_access" {
  name = "ssh_access"
  description = "Allow ssh traffic into the ssh bastion instance"


  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 4369
    to_port   = 4369
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 9100
    to_port   = 9155
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5001
    to_port   = 6024
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh_access_group"
  }
}

resource "aws_instance" "app_server" {
  count         = 10
  ami           = "ami-024e6efaf93d85776"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name      = "personal_aws"

  security_groups = [
    aws_security_group.sg_ssh_access.name
  ]

  tags = {
    Name = "my-machine-${count.index}"
    Cluster = "elixir-cluster"
  }
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/templates/hosts.tpl",
    {
      nodes = aws_instance.app_server.*.public_ip
      private_nodes = aws_instance.app_server.*.private_ip
    }
  )
  filename = "./ansible/inventory/hosts.cfg"
}
