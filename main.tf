provider "aws" {
  region = "eu-central-1"
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    Name = "IGW_vpc"
  }
}


resource "aws_route_table" "my_route_table1" {
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    Name = "Route1_vpc"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
}

resource "aws_route_table_association" "route_table_association1" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.my_route_table1.id
}

resource "aws_route_table_association" "route_table_association2" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.my_route_table1.id
}

resource "aws_route_table" "my_route_table2" {
  vpc_id     = aws_vpc.project_vpc.id
  depends_on = [aws_nat_gateway.mynatgw]

  tags = {
    Name = "Rout2_vpc"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.mynatgw.id
  }
}

resource "aws_route_table_association" "route_table_association3" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.my_route_table2.id
}

resource "aws_route_table_association" "route_table_association4" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.my_route_table2.id
}

resource "aws_route_table_association" "route_table_association5" {
  subnet_id      = aws_subnet.private_DB.id
  route_table_id = aws_route_table.my_route_table2.id
}

resource "aws_route_table_association" "route_table_association6" {
  subnet_id      = aws_subnet.private_DB1.id
  route_table_id = aws_route_table.my_route_table2.id
}

resource "aws_eip" "nat" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.myigw]

  tags = {
    Name = "EIP_vpc"
  }
}

resource "aws_nat_gateway" "mynatgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  depends_on    = [aws_internet_gateway.myigw]

}

data "aws_availability_zones" "available" {}
resource "aws_lb" "my_elb" {
  name                             = "my-elb"
  internal                         = false
  load_balancer_type               = "application"
  enable_deletion_protection       = false
  subnets                          = [aws_subnet.public1.id, aws_subnet.public.id]
  enable_http2                     = true
  security_groups                  = [aws_security_group.mydbsecurity.id]
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "my_elb_listener" {
  load_balancer_arn = aws_lb.my_elb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
    }
  }
}

resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.project_vpc.id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 4
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "my_listener_rule" {
  listener_arn = aws_lb_listener.my_elb_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}
