variable "aws_region" {
    type = string
    default = "us-east-1"
}
variable "ami_regions" {
    type = string
    default = "us-east-1"
}
variable "linux_build_instance_type" {
    type = string
    default = "t3.small"
}
variable "linux_base_ami_name" {
    type = string
    default = "RHEL-9.*_HVM-????????-x86_64-0-Hourly2-GP2"
}
variable "linux_base_ami_owner" {
    type = string
    default = "309956199498"
}
variable "root_volume_size_Gi" {
    type = string
    default = "8"
}
variable "root_volume_type" {
    type = string
    default = "gp2"
}
variable "ssh_username" {
    type = string
    default = "ec2-user"
}
