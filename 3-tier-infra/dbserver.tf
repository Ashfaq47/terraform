data "aws_subnets" "db" {
  filter {
    name   = "tag:Name"
    values = var.db_subnet_names
  }
  depends_on = [aws_subnet.subnets]
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = var.db_subnet_group_name
  subnet_ids = data.aws_subnets.db.ids
  tags = {
    Name = "This is db subnet group"
  }
  depends_on = [data.aws_subnets.db, aws_subnet.subnets]
}

resource "aws_db_instance" "dbft" {
  allocated_storage    = var.db_instance.allocated_storage
  engine               = var.db_instance.engine
  engine_version       = var.db_instance.engine_version
  instance_class       = var.db_instance.instance_class
  username             = var.db_instance.username
  password             = var.db_password
  parameter_group_name = var.db_instance.parameter_group_name
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  skip_final_snapshot  = true
  identifier           = var.db_instance.identifier

  depends_on = [aws_db_subnet_group.db_subnet, data.aws_subnets.db]
}