output "website_url" {
  description = "The website URL."
  value       = format("http://%s", aws_alb.load_balancer.dns_name)
}

output "load_balancer_name" {
  description = "The loab balancer name."
  value       = aws_alb.load_balancer.name
}

output "cloudwatch_log_group_arns" {
  description = "The ARNs for the cloudwatch log groups."
  value       = [for cw in module.ec2_monitoring : cw.cloudwatch_log_group_arn]
}
