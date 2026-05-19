data "aws_subnet" "app_subnet" {
  filter {
    name   = "tag:Name"
    values = ["app_subnet"]
  }
  depends_on = [aws_subnet.subnets]
}

resource "aws_instance" "appec2" {
  ami                         = data.aws_ami.latest_ubuntu.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.appsg.id]
  subnet_id                   = data.aws_subnet.app_subnet.id
  associate_public_ip_address = false

  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    delete_on_termination = true
  }

  tags = {
    Name = "app_ec2"
  }

  depends_on = [data.aws_subnet.app_subnet, aws_security_group.appsg, aws_key_pair.idrsa1]
}