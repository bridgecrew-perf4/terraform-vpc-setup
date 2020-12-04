variable "build" {
	default = "1"
}
variable "aws_region" {
	default = "us-east-1"
}

variable "vpc_cidr" {
	default = "10.20.0.0/16"
}

variable "bastion_subnet_cidr" {
	type = string
	default = "10.20.0.0/24"
}

variable "ext_subnets_cidr" {
	type = list
	default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "int_subnets_cidr" {
	type = list
	default = ["10.20.3.0/24", "10.20.4.0/24"]
}

variable "db_subnets_cidr" {
	type = list
	default = ["10.20.5.0/24", "10.20.6.0/24"]
}

variable "azs" {
	type = list
	default = ["us-east-1a", "us-east-1b"]
}

variable "ec2_ami" {
	type = string
	description = "ami to be used for the ec2 instances"
	# at the time of writing, this was an ami available in us-east-1
	#default = "ami-0885b1f6bd170450c"
}

variable "keypair_public_key" {
	type = string
	description = "Location of the public key file to be used for the keypair"
}