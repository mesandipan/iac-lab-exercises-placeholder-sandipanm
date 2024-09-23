resource "random_pet" "this" {
  length = 1
}

resource "aws_iam_role" "asg_instance_role" {
  name               = format("%s-asg-instance-role", random_pet.this.id)
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.asg_instance_policy.json
  description        = "Role used by EC2 instances to interact with SSM and CloudWatch"

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}

data "aws_iam_policy_document" "asg_instance_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_instance_profile" "asg_instance_profile" {
  name = format("%s-asg-instance-profile", random_pet.this.id)
  path = "/"
  role = aws_iam_role.asg_instance_role.name
}
