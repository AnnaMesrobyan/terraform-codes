
#EC2 public
resource "aws_instance" "webword" {
  ami                         = "ami-04e601abe3e1a910f"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = ["${aws_security_group.websecurity.id}"]
  key_name                    = "Frank"
  availability_zone           = "eu-central-1a"
  user_data                   = file("user_data.sh")

  tags = {
    Name = "ansible_host1"
  }
}

resource "aws_instance" "web" {
  ami                         = "ami-04e601abe3e1a910f"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public1.id
  vpc_security_group_ids      = ["${aws_security_group.websecurity.id}"]
  key_name                    = "Frank"
  availability_zone           = "eu-central-1b"
  user_data                   = file("user_data.sh")

  tags = {
    Name = "ansible-host2"
  }
}

