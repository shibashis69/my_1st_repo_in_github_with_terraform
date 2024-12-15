# Create a VPC
resource "aws_vpc" "s24Vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "s24-vpc1"
  }
}

# Create a subnet in the VPC
resource "aws_subnet" "s24SubnetManagement" {
  vpc_id     = aws_vpc.s24Vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "s24ManagementSubnet"
  }
}


# Create a subnet in the VPC
resource "aws_subnet" "s24SubnetWan" {
  vpc_id     = aws_vpc.s24Vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "s24WanSubnet"
  }
}

resource "aws_route_table" "ManagementRouteTable"
  vpc_id     = aws_vpc.s24Vpc.id
  route {
    cidr_block = aws_subnet.s24SubnetManagement.cidr_block
}

resource "aws_route_table" "WanRouteTable"
  vpc_id     = aws_vpc.s24Vpc.id
  route {
    cidr_block = aws_subnet.s24SubnetWan.cidr_block
}


# Create Network Interface for Management Subnet
resource "aws_network_interface" "management_interface" {
  subnet_id = aws_subnet.s24SubnetManagement.id

  tags = {
    Name = "ManagementInterface"
  }
}

# Create Network Interface for WAN Subnet
resource "aws_network_interface" "wan_interface" {
  subnet_id = aws_subnet.s24SubnetWan.id

  tags = {
    Name = "WanInterface"
  }
}


# Create an EC2 instance
resource "aws_instance" "my_ubuntu_instance" {
  ami           = "ami-02c0a7e636abe4d52"
  instance_type = var.instance_type
  
  network_interface {
  network_interface_id = aws_network_interface.management_interface.id
  device_index         = 0
  }

  network_interface {
  network_interface_id = aws_network_interface.wan_interface.id
  device_index         = 1
  }

  tags = {
    Name = "s24_win22server_aws"
  }
}
