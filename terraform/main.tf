module "network" {
  source         = "./modules/network"
  vpc_cidr       = "10.0.0.0/16"
  jenkins_subnet_cidr    = "10.0.0.0/24"
  availability_zone = "eu-west-3a"
  map_public_ip  = true
  allowed_cidr_ssh = ["0.0.0.0/0"]
  allowed_cidr_http = ["0.0.0.0/0"]
  instance_id = module.ec2_instance.instance_id

}

module "key_pair" {
  source     = "./modules/key-pair"
  key_name   = "id_rsa_aws"
  public_key = file("~/.ssh/id_rsa_aws.pub")
}

module "ec2_instance" {
  source         = "./modules/ec2-instance"
  ami_id         = "ami-0fc067f03ad87bb64"
  instance_type  = "t2.micro"
  subnet_id      = module.network.subnet_id
  key_name       = module.key_pair.key_name
  security_group_id = module.network.security_group_id
}

module "bucket" {
  source = "./modules/bucket"
}
