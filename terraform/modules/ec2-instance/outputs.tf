output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.jenkins_instance.id
}

output "instance_private_ip" {
  description = "Private IP address of the created EC2 instance"
  value       = aws_instance.jenkins_instance.private_ip
}
