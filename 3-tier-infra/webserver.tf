data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_key_pair" "idrsa1" {
  key_name   = var.key_name
  public_key = var.public_key
}

data "aws_subnet" "web" {
  filter {
    name   = "tag:Name"
    values = ["web_subnet"]
  }

  depends_on = [aws_subnet.subnets]
}

resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.latest_ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.idrsa1.key_name
  vpc_security_group_ids      = [aws_security_group.websg.id]
  associate_public_ip_address = true
  subnet_id                   = data.aws_subnet.web.id

  root_block_device {
    volume_type           = var.root_block_device.volume_type
    volume_size           = var.root_block_device.volume_size
    delete_on_termination = true
  }

  tags = {
    Name = "ec2ft"
  }

  depends_on = [aws_key_pair.idrsa1, data.aws_subnet.web, data.aws_ami.latest_ubuntu]
}