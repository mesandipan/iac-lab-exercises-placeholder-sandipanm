data "aws_ami" "linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_autoscaling_group" "autoscaling_group" {
  name                = format("%s-%s-asg", var.prefix, random_pet.this.id)
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  desired_capacity    = var.asg_desired_capacity
  vpc_zone_identifier = [for key, subnet in aws_subnet.private_subnets : subnet.id]
  health_check_type   = "ELB"

  dynamic "launch_template" {
    for_each = var.asg_enable_spot_instances ? {} : { add = true }
    content {
      id      = aws_launch_template.launch_template[count.index].id
      version = aws_launch_template.launch_template[count.index].latest_version
    }
  }

  dynamic "mixed_instances_policy" {
    for_each = var.asg_enable_spot_instances ? { add = true } : {}
    content {
      instances_distribution {
        on_demand_percentage_above_base_capacity = 0
        spot_instance_pools                      = 1
      }
      launch_template {
        launch_template_specification {
          launch_template_id = aws_launch_template.launch_template.id
          version            = aws_launch_template.launch_template.latest_version
        }

        override {
          instance_type = var.instance_type
        }
      }
    }
  }

  tag {
    key                 = "Name"
    value               = format("%s-%s-asg", var.prefix, random_pet.this.id)
    propagate_at_launch = true
  }
}


resource "aws_launch_template" "launch_template" {
  name = format("%s-%s-lt", var.prefix, random_pet.this.id)
  iam_instance_profile {
    name = aws_iam_instance_profile.asg_instance_profile.name
  }
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.asg.id]
  }
  image_id                             = data.aws_ami.linux2.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.instance_type
  user_data                            = base64encode(templatefile("${path.module}/templates/userdata.tpl", {}))

  tags = {
    Name = format("%s-%s-lt", var.prefix, random_pet.this.id)
  }
}


resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.id
  lb_target_group_arn    = aws_alb_target_group.target_group.arn

  depends_on = [
    aws_alb_target_group.target_group,
    aws_autoscaling_group.autoscaling_group
  ]
}


resource "aws_security_group" "asg" {
  name = format("%s-%s-asg-sg", var.prefix, random_pet.this.id)

  ingress {
    description     = "Remote access for load balancer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = format("%s-%s-asg-sg", var.prefix, random_pet.this.id)
  }
}
