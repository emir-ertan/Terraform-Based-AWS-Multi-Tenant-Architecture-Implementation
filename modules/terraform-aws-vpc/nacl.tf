##### Create Public Access Control List
resource "aws_network_acl" "main_pbl" {
  vpc_id       = aws_vpc.main.id
  subnet_ids   = aws_subnet.main_pbl.*.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-pbl-acl-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}

##### Create Private Access Control List
resource "aws_network_acl" "main_pvt" {
  count        = length(var.pvt_sub_count) > 0 ? 1 : 0
  vpc_id       = aws_vpc.main.id
  subnet_ids   = aws_subnet.main_pvt.*.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-pvt-acl-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}

##### Create EKS Access Control List
resource "aws_network_acl" "main_eks" {
  count        = length(var.eks_sub_count) > 0 ? 1 : 0
  vpc_id       = aws_vpc.main.id
  subnet_ids   = aws_subnet.main_eks.*.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-eks-acl-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}

##### Create DB Access Control List
resource "aws_network_acl" "main_db" {
  count        = length(var.db_sub_count) > 0 ? 1 : 0
  vpc_id       = aws_vpc.main.id
  subnet_ids   = aws_subnet.main_db.*.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-db-acl-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}

##### Create Lambda Access Control List
resource "aws_network_acl" "main_lambda" {
  count        = length(var.lambda_sub_count) > 0 ? 1 : 0
  vpc_id       = aws_vpc.main.id
  subnet_ids   = aws_subnet.main_lambda.*.id
  
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

    ingress {
    protocol   = -1
    rule_no    = 300
    action     = "allow"
    cidr_block = "10.0.0.0/8"
    from_port  = 0
    to_port    = 0
  }

    ingress {
    protocol   = -1
    rule_no    = 400
    action     = "allow"
    cidr_block = "172.31.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-lambda-acl-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "yonetimacademy"
    Terraform   = "yes"
  }
}