output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main_vpc.id
}

output "subnet_id" {
  description = "ID of the created subnet"
  value       = aws_subnet.jenkins_subnet.id
}

output "security_group_id" {
  description = "ID of the created security group"
  value       = aws_security_group.main_security_group.id
}
