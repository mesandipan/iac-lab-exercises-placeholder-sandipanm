resource "aws_ssm_parameter" "agent_config_linux" {
  name  = "EC2-CloudWatch-Linux-Config"
  type  = "String"
  value = templatefile("${path.module}/templates/cwa-config-linux.tpl", tomap({}))
}

resource "aws_ssm_association" "cwagent_linux" {
  association_name = "AmazonCloudWatch-Linux-InstallAgent"
  name             = "AWSEC2-ApplicationInsightsCloudwatchAgentInstallAndConfigure"
  parameters = {
    parameterStoreName = "EC2-CloudWatch-Linux-Config"
  }
  targets {
    key    = "InstanceIds"
    values = data.aws_instances.instances_to_monitor.ids
  }
  depends_on = [aws_ssm_parameter.agent_config_linux]
}
