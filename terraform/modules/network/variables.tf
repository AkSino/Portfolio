variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "jenkins_subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for the subnet"
  type        = string
}

variable "map_public_ip" {
  description = "Map public IP on launch for instances in the subnet"
  type        = bool
  default     = false
}

variable "allowed_cidr_ssh" {
  description = "CIDR block to allow SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Open to the world by default
}

variable "allowed_cidr_http" {
  description = "CIDR block to allow HTTP access"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Open to the world by default
}

variable "instance_id" {
  description = "ID of the EC2 instance"
  type        = string
}
