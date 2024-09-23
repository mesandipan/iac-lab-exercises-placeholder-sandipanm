module "ec2_monitoring" {
  source = "./modules/ec2_monitoring"

  count = local.number_of_instances

  prefix                   = var.prefix
  instance_id              = data.aws_instances.instances_to_monitor.ids[count.index]
  cw_log_retention_in_days = var.cw_log_retention_in_days

  depends_on = [
    aws_autoscaling_group.autoscaling_group,
    aws_launch_template.launch_template
  ]

}