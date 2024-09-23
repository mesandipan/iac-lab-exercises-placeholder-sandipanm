{
  "agent": {
    "metrics_collection_interval": 60,
    "run_as_user": "root"
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/amazon/ssm/amazon-ssm-agent.log",
            "log_group_name": "/aws/ec2/monitor/cwagent-metrics",
            "log_stream_name": "$${aws:InstanceId}"
          }
        ]
      }
    }
  },
  "metrics": {
    "metrics_collected": {
			"disk": {
        "measurement": ["disk_used_percent"],
        "ignore_file_system_types": ["sysfs", "devtmpfs"],
        "metrics_collection_interval": 60,
        "resources": ["/", "/tmp"]
			},    
      "mem": {
        "measurement": [
          "mem_used_percent"
        ],
        "metrics_collection_interval": 60
      },
      "cpu": {
        "measurement": [
          "cpu_usage_active"
        ],
        "metrics_collection_interval": 60
      }
    },
    "append_dimensions": {
      "ImageId": "$${aws:ImageId}",
      "InstanceId": "$${aws:InstanceId}",
      "InstanceType": "$${aws:InstanceType}"
    },
    "aggregation_dimensions": [
      [
        "InstanceId"
      ],
      ["InstanceId","fstype","path"]
    ],
    "force_flush_interval": 30
  }
}