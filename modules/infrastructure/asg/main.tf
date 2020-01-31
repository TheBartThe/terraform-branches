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
