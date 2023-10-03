output "ec2_instance_ip" {
  description = "Public IP address of the Jenkins instance"
  value = module.ec2_instance.instance_private_ip
}
