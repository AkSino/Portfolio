# Generate an SSH key pair
resource "aws_key_pair" "my_key_pair" {
  key_name   = var.key_name
  public_key = var.public_key
}
