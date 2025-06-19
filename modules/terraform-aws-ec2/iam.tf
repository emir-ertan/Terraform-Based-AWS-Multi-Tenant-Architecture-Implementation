#### Create IAM Role
resource "aws_iam_role" "main" {
  name = "${var.tenant}-${var.name}-${var.ec2_name}-ec2-iam-role-${var.environment}"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.ec2_name}-ec2-iam-role-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}

resource "aws_iam_role_policy_attachment" "main" {
  count      = length(var.instance_profile) == 0 ? 0 : length(var.instance_profile)
  policy_arn = "arn:aws:iam::aws:policy/${var.instance_profile[count.index]}"
  role       = aws_iam_role.main.name
}