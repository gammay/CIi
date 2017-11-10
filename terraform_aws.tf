
variable "ami" {}

variable vpc_subnet {
  default = "10.0.0.0/24"
}

provider "aws" {
  access_key = "ACCESS_KEY"
  secret_key = "SECRET_KET"
  region     = "ap-southeast-1"
}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_subnet}"
}

resource "aws_subnet" "vpc_subnet" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.vpc_subnet}"
  map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_instance" "example" {
  count =2
  ami = "${var.ami}"
  instance_type = "t2.micro"
  key_name ="new1"
    tags {
     Name = "abc"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo wget https://PATH_TO_WAR"
      "sudo service tomcat start"
    ]
  }

  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
}

resource "aws_security_group" "instance" {
  name = "abc-instance1"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}

