resource "aws_lb" "alb" {
  name = "load-balancer"
  load_balancer_type = "application"
  security_groups = [var.alb_sg_id]
  subnets = var.public_subnets
}


resource "aws_lb_target_group" "target_alb" {
  protocol = "HTTP"
  port = "80"
  vpc_id = var.vpc_id
  target_type = "instance"

  # Healthcheck
  health_check {
    path = "/"
    interval = "60" # In seconds
    timeout = "5"
  }
}

resource "aws_lb_target_group_attachment" "tg_attach" {

  count = length(var.private_instances_ids)

  target_group_arn = aws_lb_target_group.target_alb.arn
  target_id = var.private_instances_ids[count.index]
  port = 80


  depends_on = [
    aws_lb_target_group.target_alb
  ]
}

resource "aws_lb_listener" "listener_alb" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_alb.arn
  }
}
