terraform {
  backend "s3" {
    bucket = "devops-learning-kelvin"
    region = "us-east-1"
    key    = "jenkins-ansible/terraform.tfstate"
  }
}