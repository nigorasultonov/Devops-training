resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "SG_VPC"
  }
}
resource "aws_security_group" "web-sg" {
  name = "fproject-sg"
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name  = "devops_public"
    Owner = "Nigora"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name  = "devops_public_2"
    Owner = "Nigora"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name  = "devops_private"
    Owner = "Nigora"
  }
}

resource "aws_internet_gateway" "devops_ig" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name  = "devops_internet_gateway"
    Owner = "Nigora"
  }
}

# resource "aws_internet_gateway_attachment" "devops_ig_attachment" {
#  internet_gateway_id = aws_internet_gateway.devops_ig.id
#  vpc_id              = aws_vpc.main.id
#}

resource "aws_route_table" "devops_public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"            
    gateway_id = aws_internet_gateway.devops_ig.id
  }

  tags = {
    Name  = "devops_route_table"
    Owner = "Nigora"
  }
}

resource "aws_route_table_association" "devops_public_rt_1" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.devops_public_rt.id
}

resource "aws_route_table_association" "devops_public_rt_2" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.devops_public_rt.id
}
