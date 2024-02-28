# ec2_module/main.tf

resource "aws_instance" "ec2_instance" {
  #vpc_security_group_ids = [aws_security_group.web-sg.id]
  vpc_id = aws_vpc.main.id
  count = length(var.instance_name)
  ami           = "ami-0fe630eb857a6ec83"     # Replace with appropriate ami-ID
  instance_type = lookup(var.instance_type, var.instance_name[count.index])
  key_name      = aws_key_pair.pub_key.key_name

  tags = merge(
    {
      Name        = var.instance_name[count.index]
      Team        = "TuranCyberHub"
      CreatedTime = "02.28.2024"
    },
    var.tags
  )
}
resource "aws_key_pair" "pub_key" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCPLQaupjQH8kWPBDtdmbtMYJiLNRh/aGCFpjnyaUF6jOvgst9AV6q6+ZEy9Tu0ERIQKR3pSdB7Ak1x1tb/zd83l8fB/PTpGaRWzTIqJbYjvVNzUFPCW/6hh5siuk5lt5GpKQ70ZItVsbt5qd/idZ7UXx7CWM2kGe978GFJcTU66J8NEttJbUXkW/wCyHDZfYHKynPO0A0xzO3la6WBR4U0/YTz6/Q0SGVmse63TyvOEqG8N3Sc9yRsnj8KoSu6iYLiPuCvQTtSbNNwjU5Akzpoor6i48Lo7jwQp0deSDmKSsutj1q8ORlL7JUMHyZdEhX1y4ntbbozHkDr9KWYtfn9"
}



