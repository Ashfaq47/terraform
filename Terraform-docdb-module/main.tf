module "documentdb_1" {
  source = "./module"

  cidr_block = "10.10.0.0/16"
  vpc_name   = "docdb_vpc"
  docdb_sg = {
    name        = "docdb_sg"
    description = "This is documentdb sg"
    rules = [{
      type       = "ingress"
      from_port  = 27017
      to_port    = 27017
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
      }, {
      type       = "egress"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }]
  }

  docdb_subnet_name = "docdb_subnets"

  docdb_cluster = {
    cluster_identifier = "my-docdb-cluster4321"
    engine             = "docdb"
    master_username    = "docdbashfaq"


  }

  instance_class          = "db.t3.medium"
  docdb_subnet_group_name = "My-Docdb-subnet-group"
  docdb_cluster_name      = "ft-docdb-cluster-4321"
  secret_name             = "ft-aws-secret-docDDB"

  


}