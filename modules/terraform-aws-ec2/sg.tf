resource "aws_security_group" "main" {
  name        = "${var.tenant}-${var.name}-ec2-${var.ec2_name}-sg-${var.environment}"
  description = "Managed by yonetimacademy"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress

    content {
      protocol    = ingress.value.protocol
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      description = lookup(ingress.value, "description", null)
      cidr_blocks = [ingress.value.cidr_blocks]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-ec2-${var.ec2_name}-sg-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}