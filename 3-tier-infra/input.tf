variable "CIDR" {
  type = string
}

variable "vpcname" {
  type = string
}

variable "subnet_names" {
  type    = list(string)
  default = ["web_subnet", "app_subnet", "db_subnet1", "db_subnet2"]
}

variable "subnet_azs" {
  type = list(string)
}

variable "igw_name" {
  type = string
}

variable "db_subnet_names" {
  type    = list(string)
  default = ["db_subnet1", "db_subnet2"]
}

variable "appsg" {
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

variable "websg" {
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

variable "dbsg" {
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

variable "public_key" {
  type      = string
  sensitive = true
}

variable "key_name" {
  type = string
  default = "idrsa1"
}

variable "root_volume_type"{
  type = string
  default = "gp3"
}

variable "root_volume_size" {
  type = number
  default = 20
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "root_block_device" {
  description = "Configuration for the root block device of the EC2 instance"
  type = object({
    volume_type = string
    volume_size = number
  })
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_subnet_group_name" {
  type = string
}

variable "db_instance" {
  type = object({
    allocated_storage    = number
    engine               = string
    engine_version       = string
    instance_class       = string
    username             = string
    parameter_group_name = string
    identifier           = string
  })
}