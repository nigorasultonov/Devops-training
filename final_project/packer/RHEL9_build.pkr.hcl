packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "1.3.0"
    }
  }
}


source "amazon-ebs" "rhel_ami" {
  ami_name      = "my-rhel9-image"
  region        = var.aws_region
  ami_regions   = [var.ami_regions]
  ssh_username  = var.ssh_username
  instance_type = var.linux_build_instance_type

  source_ami_filter {
    filters = {
      "virtualization-type" = "hvm"
      "name"                = var.linux_base_ami_name
      "root-device-type"    = "ebs"
    }
    owners      = [var.linux_base_ami_owner]
    most_recent = true
  }

  launch_block_device_mappings {
    device_name           = "/dev/xvda"
    volume_size           = var.root_volume_size_Gi
    volume_type           = var.root_volume_type
    delete_on_termination = true
  }

  tags = {
    Name       = "rhel_9"
    OS_Version = "RHEL9"
    ENV        = "TuranCyberHub"
  }
}
build {
  name    = "my-first-build"
  sources = ["source.amazon-ebs.rhel_ami"]

  provisioner "shell" {
    script = "/home/ubuntu/final_project/install_packages.sh" # Execute shell script on the EC2 instance 
  }
}
