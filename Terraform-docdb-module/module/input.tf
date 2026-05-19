variable "cidr_block" {
  type    = string
  default = "192.168.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "vpc_db"
}

variable "subnet_names" {
  type    = list(string)
  default = ["public_subnet", "private_subnet"]
}

variable "availability_zone" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "docdb_sg" {
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

}

variable "docdb_subnet_name" {
  type = string
}

variable "docdb_cluster" {
  type = object({
    cluster_identifier = string
    engine             = string
    master_username    = string
    #master_password    = string

  })
}

variable "instance_class" {
  type = string
}

variable "docdb_subnet_group_name" {
  type = string
}

variable "docdb_cluster_name" {
  type = string
}

variable "secret_name" {
  type = string
}