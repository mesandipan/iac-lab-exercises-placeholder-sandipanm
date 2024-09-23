resource "aws_alb" "load_balancer" {
  name            = format("tf-infra-%s-lb", random_pet.this.id)
  security_groups = [aws_security_group.alb.id]
  subnets         = [for key, subnet in aws_subnet.public_subnets : subnet.id]

  tags = {
    Name = format("%s-%s-lb", var.prefix, random_pet.this.id)
  }
}


resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.target_group.arn
    type             = "forward"
  }
}

resource "aws_alb_target_group" "target_group" {
  name     = format("tf-infra-%s-tg", random_pet.this.id)
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "5"
    interval            = "60"
    matcher             = "200,302"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }

  tags = {
    Name = format("%s-%s-tg", var.prefix, random_pet.this.id)
  }
}


resource "aws_security_group" "alb" {
  name   = format("%s-%s-alb-sg", var.prefix, random_pet.this.id)
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "Access to the website on port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${format("%s/32", var.my_public_ip_address)}"]
  }

  egress {
    description      = "Allow outgoing traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = format("%s-%s-lb-sg", var.prefix, random_pet.this.id)
  }
}
