
#EC2 public
resource "aws_instance" "ansible_host1" {
  ami                         = "ami-04e601abe3e1a910f"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = ["${aws_security_group.websecurity.id}"]
  key_name                    = "frankfurt"
  availability_zone           = "eu-central-1a"
  user_data                   = file("user_data_1.sh")

  tags = {
    Name = "ansible-host1"
  }
}

resource "aws_instance" "ansible_host2" {
  ami                         = "ami-04e601abe3e1a910f"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public1.id
  vpc_security_group_ids      = ["${aws_security_group.websecurity.id}"]
  key_name                    = "frankfurt"
  availability_zone           = "eu-central-1b"
  user_data                   = file("user_data.sh")

  tags = {
    Name = "ansible_host2"
  }
}

#private and DB
resource "aws_instance" "Ansible_master" {
  ami                    = "ami-04e601abe3e1a910f"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = ["${aws_security_group.mydbsecurity.id}"]
  key_name               = "frankfurt"
  availability_zone      = "eu-central-1a"
  user_data              = file("user_data.sh")


  tags = {
    Name = "Ansible_master"
  }
}

resource "aws_instance" "Web1" {
  ami                    = "ami-04e601abe3e1a910f"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private1.id
  vpc_security_group_ids = ["${aws_security_group.mydbsecurity.id}"]
  key_name               = "frankfurt"
  availability_zone      = "eu-central-1b"
  user_data              = file("user_data.sh")


  tags = {
    Name = "Web1"
  }
}

resource "aws_instance" "Web_DB" {
  ami                    = "ami-04e601abe3e1a910f"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_DB.id
  vpc_security_group_ids = ["${aws_security_group.mydbsecurity.id}"]
  key_name               = "frankfurt"
  availability_zone      = "eu-central-1a"



  tags = {
    Name = "Web_DB"
  }
}

resource "aws_instance" "Web_DB1" {
  ami                    = "ami-04e601abe3e1a910f"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_DB1.id
  vpc_security_group_ids = ["${aws_security_group.mydbsecurity.id}"]
  key_name               = "frankfurt"
  availability_zone      = "eu-central-1b"



  tags = {
    Name = "Web_DB1"
  }
}

# resource "null_resource" "run_playbook" {
#   provisioner "local-exec" {
#     command = "sudo ansible-playbook  /root/Ansible_ws/mainplaybook.yaml"
#   }
# }
