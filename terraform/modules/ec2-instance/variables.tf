variable "ami_id" {
  description = "ID of the AMI to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the EC2 instance will be deployed"
  type        = string
}

variable "security_group_id" {
  description = "ID of the main security group"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair to associate with the EC2 instance"
  type        = string
}

variable "user_data" {
  description = "User data script for instance initialization (optional)"
  type        = string
  default     = <<-EOF
    #!/bin/bash
    echo "START - install jenkins"

    # Update and Install packages
    yum update -y
    yum install -y git ansible

    # Installation de Java et de Jenkins
    wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    yum upgrade
    dnf install java-17-amazon-corretto -y
    yum install jenkins -y
    systemctl enable jenkins
    systemctl start jenkins

    EOF
}
