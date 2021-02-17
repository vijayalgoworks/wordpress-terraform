variable "aws_region" {
  description = "Region for the VPC"
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  default     = "10.0.2.0/24"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default     = "ami-08e0ca9924195beba"
}

variable "key_path" {
  description = "SSH Public Key path"
  default     = "public_key"
}

variable "username" {
  description = "DB username"
}

variable "password" {
  description = "DB password"
}

variable "dbname" {
  description = "db name"
}
# #RDS-VARIABLES
# variable "environment" {}
# variable "db_name" {}
# variable "db_version" {}
# variable "instance_count" {}
# variable "rds_instance_name" {}
# variable "db_instance_class" {}
# variable "db_username" {}
# variable "db_password" {}
# variable "db_storage" {}
