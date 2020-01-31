resource "aws_subnet" "public_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "${var.environment}-${var.region}-Public-Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "${var.environment}-${var.region}-Private-Subnet"
  }
}
