resource "aws_lb_target_group" "cluster_01" {
  name     = format("%s-%s", var.project_name, "01")
  port     = 30080
  protocol = "HTTP"

  vpc_id = data.aws_ssm_parameter.vpc_id.value

  health_check {
    path    = "/"
    matcher = "200-404"
  }

  depends_on = [aws_lb.main]
}

resource "aws_lb_target_group" "cluster_02" {
  name     = format("%s-%s", var.project_name, "02")
  port     = 30080
  protocol = "HTTP"

  vpc_id = data.aws_ssm_parameter.vpc_id.value

  health_check {
    path    = "/"
    matcher = "200-404"
  }

  depends_on = [aws_lb.main]
}