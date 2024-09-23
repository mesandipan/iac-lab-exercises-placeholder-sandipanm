data "aws_availability_zones" "available" {}

data "aws_instances" "instances_to_monitor" {
  filter {
    name   = "tag:Name"
    values = [format("%s-%s-asg", var.prefix, random_pet.this.id)]
  }

  instance_state_names = ["running"]

  depends_on = [
    aws_autoscaling_group.autoscaling_group,
    aws_launch_template.launch_template
  ]
}
