resource "aws_ssm_parameter" "main_instance_id" {
  name        = "/${var.tenant}/${var.name}/${var.environment}/ec2/${var.ec2_name}/id"
  description = "Managed by yonetimacademy"
  type        = "SecureString"
  value       = aws_instance.main.id

  tags = {
    Name        = "${var.tenant}-${var.name}-${var.environment}-ec2-${var.ec2_name}-id"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}