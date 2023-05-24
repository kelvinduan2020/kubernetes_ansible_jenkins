module "jenkins" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins"

  ami                         = data.aws_ami.latest-amazon-ubuntu-image.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.all_traffic.id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = file("scripts/jenkins.sh")

  tags = {
    Terraform   = "true"
    Environment = var.env_prefix
  }
}

# module "ansible" {
#   source = "terraform-aws-modules/ec2-instance/aws"

#   name = "ansible"

#   ami                         = data.aws_ami.latest-amazon-ubuntu-image.id
#   instance_type               = var.instance_type
#   key_name                    = var.key_name
#   vpc_security_group_ids      = [aws_security_group.ssh.id]
#   subnet_id                   = module.vpc.public_subnets[0]
#   associate_public_ip_address = true
#   user_data                   = file("scripts/ansible.sh")

#   tags = {
#     Terraform   = "true"
#     Environment = var.env_prefix
#   }
# }

data "aws_ami" "latest-amazon-ubuntu-image" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-*.*-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

