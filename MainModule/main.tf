# main_module/main.tf

provider "aws" {
  region = "us-east-1"
}

module "ec2_instances" {
  source = "./EC2_Module"

  number_of_instances = 3 # Default number of instances
}
