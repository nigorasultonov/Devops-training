
variable "number_of_instances" {
  description = "The number of EC2 instances to launch"
}
variable "tags" {
  type = map(any)
  default = {
    Owner     = "Nigora"
    CreatedBy = "Nigora"
    Project   = "final_project"
    Purpose   = "development"
  }
}

variable "instance_type" {
  type = map(any)
  default = {
    ansible    = "t2.micro"
    jenkins = "t2.small"
    kubernetes  = "t3a.medium"
  }
}

variable "instance_name" {
  type    = list(any)
  default = ["ansible", "jenkins", "kubernetes"]
}

variable "ingress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = [
    {
      description = "allow ssh traffic"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "allow TCP"
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
      ]
}
