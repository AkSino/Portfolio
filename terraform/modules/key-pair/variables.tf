variable "key_name" {
  description = "Name for the SSH key pair"
  type        = string
}

variable "public_key" {
  description = "Public key content for the SSH key pair"
  type        = string
}
