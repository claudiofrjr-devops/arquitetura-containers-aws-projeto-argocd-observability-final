resource "aws_security_group" "efs" {
  name   = format("%s-efs", var.project_name)
  vpc_id = data.aws_ssm_parameter.vpc_id.value

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["100.64.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}