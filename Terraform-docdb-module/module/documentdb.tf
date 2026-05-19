data "aws_subnets" "db_subnets" {
  filter {
    name   = "tag:Name"
    values = var.subnet_names
  }

  depends_on = [aws_subnet.aws_subnets]
}

resource "aws_docdb_subnet_group" "docdb_subnet_group" {
  name       = var.docdb_subnet_name
  subnet_ids = data.aws_subnets.db_subnets.ids

  tags = {
    Name = var.docdb_subnet_group_name
  }

  depends_on = [aws_subnet.aws_subnets, data.aws_subnets.db_subnets]
}

resource "aws_docdb_cluster" "docdb_cluster" {
  cluster_identifier     = var.docdb_cluster.cluster_identifier
  engine                 = var.docdb_cluster.engine
  master_username        = var.docdb_cluster.master_username
  master_password        = data.aws_secretsmanager_random_password.docdb_password.random_password
  db_subnet_group_name   = aws_docdb_subnet_group.docdb_subnet_group.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.docdb_sg.id]
  tags = {
    Name = var.docdb_cluster_name
  }

  depends_on = [aws_docdb_subnet_group.docdb_subnet_group, aws_security_group.docdb_sg]
}

resource "aws_docdb_cluster_instance" "docdb_instances" {
  count              = 2
  identifier         = "docdb-test-instance-${count.index}"
  cluster_identifier = var.docdb_cluster.cluster_identifier
  instance_class     = var.instance_class
  availability_zone  = var.availability_zone[count.index]

  depends_on = [aws_docdb_cluster.docdb_cluster]

}