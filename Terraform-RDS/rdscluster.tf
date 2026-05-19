resource "aws_db_subnet_group" "db_subnets" {
  name = var.db_subnet_group_name
  subnet_ids = [ aws_subnet.subnets[2].id, aws_subnet.subnets[3].id ]
  tags = {
    Name = var.db_subnet_group_name
  }
}

resource "aws_rds_cluster" "rds-cluster" {
  cluster_identifier = "rds-cluster-4321"
  engine = var.rds-cluster.engine
  availability_zones = [ "us-east-1c", "us-east-1d" ]
  database_name = var.rds-cluster.database_name
  master_username = var.rds-cluster.master_username
  master_password = var.rds-cluster.master_password
  skip_final_snapshot = true

  lifecycle {
    ignore_changes = [
      availability_zones,   # Ignore changes to availability_zones
      db_subnet_group_name, # Ignore subnet group changes
    ]
  }
}

resource "aws_rds_cluster_instance" "rds-cluster-instance" {
  count =var.rds-cluster-instances.no_of_instances
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.rds-cluster.id
  instance_class = var.rds-cluster-instances.instance_class
  engine = aws_rds_cluster.rds-cluster.engine

  depends_on = [ aws_rds_cluster.rds-cluster ]
}