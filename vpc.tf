resource "aws_vpc" "project_vpc" {
  cidr_block = "10.100.0.0/16"

  tags = {
    Name = "VPC"
  }
}

#public
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = "10.100.20.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "Public"
  }
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = "10.100.22.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "Public_B1"
  }
}

#private
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = "10.100.30.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "Privite"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = "10.100.32.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "Privite_1"
  }
}

#private DB
resource "aws_subnet" "private_DB" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = "10.100.31.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "Private_DB"
  }
}

resource "aws_subnet" "private_DB1" {
  vpc_id            = aws_vpc.project_vpc.id
  cidr_block        = "10.100.33.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "Private_DB1"
  }
}
