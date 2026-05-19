variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "rds_vpc"
}

variable "subnet_names" {
  type    = list(string)
  default = ["public_subnet1", "public_subnet2", "db_subnet1", "db_subnet2"]
}

variable "db_subnets" {
  type = list(string)
  default = [ "db_subnet1", "db_subnet2" ]
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1a", "us-east-1b"]
}

variable "igw" {
  type    = string
  default = "new_igw"
}

variable "NAT_name" {
  type    = string
  default = "NAT_Gateway"
}

variable "rdssg" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type       = string
      from_port  = number
      to_port    = number
      protocol   = string
      cidr_block = string
    }))
  })

  default = {
    name        = "rdssg"
    description = "This is rds security group"
    rules = [{
      type       = "ingress"
      from_port  = 3306
      to_port    = 3306
      protocol   = "tcp"
      cidr_block = "10.10.0.0/16"
      }, {
      type       = "egress"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }]

  }
}

variable "db_subnet_group_name" {
  type = string
  default = "db_subnet_group"
}

variable "rds-cluster" {
  type = object({
    cluster_identifier = string
    engine = string
    database_name = string
    master_username = string
    master_password = string

  })

  default = {
    cluster_identifier = "rds-cluster4321"
    engine = "aurora-postgresql"
    database_name = "rdsnewcluster"
    master_username = "ashfaq"
    master_password = "ashfaq123"
    
  }
}

variable "rds-cluster-instances" {
  type = object({
  no_of_instances = number
  instance_class = string
  })
  default = {
    no_of_instances = 2
    instance_class = "db.r5.large"
  }

}