resource "aws_instance" "jenkins_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  security_groups = [var.security_group_id]
  tags = {
    Name = "Jenkins Server"
  }
  # User data script for instance initialization (optional)
  user_data = var.user_data
}
