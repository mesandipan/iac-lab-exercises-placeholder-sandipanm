region = "ap-south-1"
prefix = "tw-iac-demo"

// Network
vpc_cidr = "192.168.0.0/24"
subnets = [
  {
    az   = "a"
    cidr = "192.168.0.0/28"
  },
  {
    az   = "b"
    cidr = "192.168.0.16/28"
  },
  {
    az   = "a"
    cidr = "192.168.0.32/28"
  },
  {
    az   = "b"
    cidr = "192.168.0.48/28"
  },
  {
    az   = "a"
    cidr = "192.168.0.64/28"
  },
  {
    az   = "b"
    cidr = "192.168.0.80/28"
  }
]

// EC2
instance_type             = "t3.small"
asg_desired_capacity      = 2
asg_min_size              = 1
asg_max_size              = 3
asg_enable_spot_instances = true
cw_log_retention_in_days  = 7
