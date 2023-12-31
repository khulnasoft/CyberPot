variable "ec2_vpc_id" {}
variable "ec2_subnet_id" {}
variable "ec2_region" {}
variable "linux_password" {}
variable "web_password" {}
variable "cyberpot_name" {}

resource "aws_security_group" "cyberpot" {
  name        = "CyberPot"
  description = "CyberPot Honeypot"
  vpc_id      = var.ec2_vpc_id
  ingress {
    from_port   = 0
    to_port     = 64000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 64000
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 64294
    to_port     = 64294
    protocol    = "tcp"
    cidr_blocks = var.admin_ip
  }
  ingress {
    from_port   = 64295
    to_port     = 64295
    protocol    = "tcp"
    cidr_blocks = var.admin_ip
  }
  ingress {
    from_port   = 64297
    to_port     = 64297
    protocol    = "tcp"
    cidr_blocks = var.admin_ip
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "CyberPot"
  }
}

resource "aws_instance" "cyberpot" {
  ami           = var.ec2_ami[var.ec2_region]
  instance_type = var.ec2_instance_type
  key_name      = var.ec2_ssh_key_name
  subnet_id     = var.ec2_subnet_id
  tags = {
    Name = var.cyberpot_name
  }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }
  user_data                   = templatefile("../cloud-init.yaml", { timezone = var.timezone, password = var.linux_password, cyberpot_flavor = var.cyberpot_flavor, web_user = var.web_user, web_password = var.web_password })
  vpc_security_group_ids      = [aws_security_group.cyberpot.id]
  associate_public_ip_address = true
}
