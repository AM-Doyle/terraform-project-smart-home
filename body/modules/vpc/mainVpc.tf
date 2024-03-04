resource "aws_vpc" "main" {
  cidr_block           = var.cidr_range
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

#Internet Gateway 

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.vpc_name}-igw"
    ManagedBy = "Terraform"
  }
}

#Subnets


resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name      = format("${var.vpc_name}-public-%s", element(var.availability_zones, count.index))
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name      = format("${var.vpc_name}-private-%s", element(var.availability_zones, count.index))
    ManagedBy = "Terraform"
  }
}

# route tables

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.vpc_name}-public"
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_internet_gateway" {

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "private" {
    count = length(var.private_subnets)

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-private-${count.index + 1}"
    ManagedBy = "terraform"
  }
}
resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private[count.index].id
}

# nat gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id

    tags = {
      Name = "gw_NAT"
    }
}

resource "aws_route" "private_nat_associations" {
    count = length(aws_route_table.private)
    route_table_id = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}

# security groups

data "http" "myipaddr" {
   url = "http://icanhazip.com"
}

resource "aws_security_group" "tp-sg" {
  name        = "tp-sg"
  description = "Security group for app servers"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group_rule" "allow_http_in" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.tp-sg.id
}
resource "aws_security_group_rule" "allow_http_out" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.tp-sg.id
}

resource "aws_security_group_rule" "allow_https_in" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.tp-sg.id
}
resource "aws_security_group_rule" "allow_https_out" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.tp-sg.id
}

resource "aws_security_group_rule" "allow_3000_in" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.tp-sg.id
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.tp-sg.id

  cidr_ipv4   = "${chomp(data.http.myipaddr.response_body)}/32"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "ssh_local" {
  security_group_id = aws_security_group.tp-sg.id

  cidr_ipv4   = var.cidr_range
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "outgoing_ipv6" {
  security_group_id = aws_security_group.tp-sg.id

  cidr_ipv6   = "::/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "outgoing_ipv4" {
  security_group_id = aws_security_group.tp-sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
