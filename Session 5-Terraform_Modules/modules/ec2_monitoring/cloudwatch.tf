resource "aws_cloudwatch_log_group" "cwmetric_group" {
  name              = format("/aws/ec2/monitor/cwagent-metrics-%s", var.instance_id)
  retention_in_days = var.cw_log_retention_in_days
}

resource "aws_cloudwatch_metric_alarm" "memory" {
  alarm_name                = format("${var.prefix}-memory-alarm-%s", var.instance_id)
  metric_name               = "mem_used_percent"
  namespace                 = "CWAgent"
  period                    = 10
  statistic                 = "Average"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 5
  threshold                 = 90
  alarm_description         = format("This metric monitors commited memory for %s server", var.instance_id)
  insufficient_data_actions = []
  actions_enabled           = "true"
  alarm_actions             = []
  dimensions = {
    InstanceId = var.instance_id
  }

  lifecycle {
    ignore_changes = [
      metric_query,
      datapoints_to_alarm,
      evaluation_periods,
      dimensions,
      threshold
    ]
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name                = format("${var.prefix}-cpu-alarm-%s", var.instance_id)
  metric_name               = "cpu_usage_active"
  namespace                 = "CWAgent"
  period                    = 60
  statistic                 = "Average"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  threshold                 = 90
  alarm_description         = format("This metric monitors commited CPU utilization for %s server", var.instance_id)
  insufficient_data_actions = []
  actions_enabled           = "true"
  alarm_actions             = []
  dimensions = {
    InstanceId = var.instance_id
  }
  lifecycle {
    ignore_changes = [
      metric_query,
      datapoints_to_alarm,
      evaluation_periods,
      dimensions,
      threshold
    ]
  }
}

resource "aws_cloudwatch_metric_alarm" "disk" {
  alarm_name                = format("${var.prefix}-disk-alarm-%s", var.instance_id)
  metric_name               = "disk_used_percent"
  namespace                 = "CWAgent"
  period                    = 180
  statistic                 = "Maximum"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  threshold                 = 90
  alarm_description         = format("This metric monitors commited disk usage for %s server", var.instance_id)
  insufficient_data_actions = []
  actions_enabled           = "true"
  alarm_actions             = []
  dimensions = {
    InstanceId = var.instance_id
    fstype     = "xfs"
    path       = "/"
  }
  lifecycle {
    ignore_changes = [
      metric_query,
      datapoints_to_alarm,
      evaluation_periods,
      dimensions,
      threshold
    ]
  }
}
