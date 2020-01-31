resource "aws_launch_configuration" "main-lc" {
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair

  lifecycle {
    create_before_destroy = true
  }

  associate_public_ip_address = true

}

resource "aws_autoscaling_group" "main-asg" {
  name                 = "${var.environment}-${var.region}-asg"
  max_size             = 3
  min_size             = 1
  launch_configuration = aws_launch_configuration.main-lc.name
  vpc_zone_identifier  = [var.public_subnet_id]
}

resource "aws_autoscaling_schedule" "main-asg-stop" {
  scheduled_action_name  = "${var.environment}-${var.region}-asg-stop"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = var.asg_stop
  autoscaling_group_name = aws_autoscaling_group.main-asg.name
}

resource "aws_autoscaling_schedule" "main-asg-start" {
  scheduled_action_name  = "${var.environment}-${var.region}-asg-start"
  min_size               = 1
  max_size               = 3
  desired_capacity       = 1
  recurrence             = var.asg_start
  autoscaling_group_name = aws_autoscaling_group.main-asg.name
}
