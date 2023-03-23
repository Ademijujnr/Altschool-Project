variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type = map(any)
  default = {
    "public-1" = {
      name       = "public-1"
      az         = "us-east-1a"
      cidr_block = "10.0.1.0/24"
      key        = "public-1"
    },

    "public-2" = {
      name       = "public-2"
      az         = "us-east-1b"
      cidr_block = "10.0.2.0/24"
      key        = "public-2"
    }
  }
}
variable "private_subnets" {
  type = map(any)
  default = {
    "private-1" = {
      name       = "private-1"
      az         = "us-east-1a"
      cidr_block = "10.0.3.0/24"
      key        = "private-1"
    },

    "private-2" = {
      name       = "private-2"
      az         = "us-east-1b"
      cidr_block = "10.0.4.0/24"
      key        = "private-2"
    }
  }
}

variable "sg" {
  type = map(any)
  default = {
    name           = "sg"
    description    = "security group for eks cluster"
    from_port  = 0
    to_port    = 65535
  }
}

variable "cluster_name" {
  default = "altschool-exam-cluster"
}

variable "cidr_block" {
  default = ["0.0.0.0/0"]
}

variable "domain" {
  type = map(any)
  default = {
    domain    = "ademiju.live"
    record = "*.ademiju.live"
    type      = "CNAME"
  }
}

variable "namedotcom_username" {
  default = "Ademiju"
}

variable "namedotcom_token" {
  default = "002f32ad7e90cd0a43eb81e02756975013dae7f9"
}

variable "tags" {
  type = map(any)
  default = {
    vpc              = "vpc"
    internet_gateway = "igw"
    nat_gateway      = "nat-gw"
    publicRT         = "publicRT"
    privateRT        = "privateRT"
    elastic_ip       = "eip"
    sg               = "sg"
  }
}
