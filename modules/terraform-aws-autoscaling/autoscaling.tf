resource "aws_launch_template" "web_template" {
  name_prefix   = "web-template-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.security_grpup_id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "autoscaling-web"
    }
  }
}

resource "aws_autoscaling_group" "example_autoscaling" {
  name                      = "autoscaling-terraform-test"
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true

  availability_zones = var.azs

  launch_template {
    id      = aws_launch_template.web_template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "asp" {
  name                   = "asp-terraform-test"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.example_autoscaling.name
}

resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm" {
  alarm_name          = "terraform-test-cloudwatch"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  alarm_description   = "This metric monitors ec2 cpu utilization"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.example_autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.asp.arn]

}

resource "aws_sns_topic" "user_updates" {
  name         = "user-updates-topic"
  display_name = "example auto scaling"
}

resource "aws_autoscaling_notification" "example_notifications" {
  group_names = [aws_autoscaling_group.example_autoscaling.name]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.user_updates.arn
}
