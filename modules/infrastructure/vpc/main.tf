resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "${var.region}-${var.environment}-vpc"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.region}-${var.environment}-ig"
  }

}

resource "aws_route_table" "main_public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.open_internet
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "Route Table for public subnet in main VPC"
  }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.main_public_rt.id
}
