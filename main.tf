#######
# VPC #
#######
resource "aws_vpc" "vpc_clc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "enio-iac-clc11"
  }
}

resource "aws_flow_log" "flow_log_clc" {
  log_destination      = "arn:aws:s3:::enio-clc11-tfstate"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.vpc_clc.id
}

resource "aws_default_security_group" "custom-sg" {
  vpc_id = aws_vpc.vpc_clc.id
  
  tags = {
    Name = "my-iac-sg"
  }
}

##################
# PUBLIC SUBNETS #
##################
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.vpc_clc.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "iac-public-subnet-1a"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id            = aws_vpc.vpc_clc.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "iac-public-subnet-1c"
  }
}

###################
# PRIVATE SUBNETS #
###################
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.vpc_clc.id
  cidr_block        = "10.0.100.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "iac-private-subnet-1a"
  }
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id            = aws_vpc.vpc_clc.id
  cidr_block        = "10.0.200.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "iac-private-subnet-1c"
  }
}

####################
# INTERNET GATEWAY #
####################
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_clc.id

  tags = {
    Name = "igw-clc11"
  }
}

######################
# PUBLIC ROUTE TABLE #
######################
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_clc.id

  route {
    cidr_block = var.anywhere_range
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-iac-rt"
  }
}

###################################
# PUBLIC ROUTE TABLE ASSOCIATIONS #
###################################
resource "aws_route_table_association" "public_association_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_association_c" {
  subnet_id      = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.public_route_table.id
}

#################
# NAT GATEWAY A #
#################
resource "aws_eip" "clc_ip_a" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natgateway_a" {
  allocation_id = aws_eip.clc_ip_a.id
  subnet_id     = aws_subnet.public_subnet_a.id

  tags = {
    Name = "iac-natgateway-a"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

#################
# NAT GATEWAY C #
#################
resource "aws_eip" "clc_ip_c" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natgateway_c" {
  allocation_id = aws_eip.clc_ip_c.id
  subnet_id     = aws_subnet.public_subnet_c.id

  tags = {
    Name = "iac-natgateway-c"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

#######################
# PRIVATE ROUTE TABLE #
#######################
resource "aws_route_table" "private_route_table_a" {
  vpc_id = aws_vpc.vpc_clc.id

  route {
    cidr_block     = var.anywhere_range
    nat_gateway_id = aws_nat_gateway.natgateway_a.id
  }

  tags = {
    Name = "private-iac-rt-a"
  }
}

resource "aws_route_table" "private_route_table_c" {
  vpc_id = aws_vpc.vpc_clc.id

  route {
    cidr_block     = var.anywhere_range
    nat_gateway_id = aws_nat_gateway.natgateway_c.id
  }

  tags = {
    Name = "private-iac-rt-c"
  }
}

####################################
# PRIVATE ROUTE TABLE ASSOCIATIONS #
####################################
resource "aws_route_table_association" "private_association_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table_a.id
}

resource "aws_route_table_association" "private_association_c" {
  subnet_id      = aws_subnet.private_subnet_c.id
  route_table_id = aws_route_table.private_route_table_c.id
}
