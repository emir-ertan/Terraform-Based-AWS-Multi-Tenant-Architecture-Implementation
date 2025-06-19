module "core_vpc" {

  source      = "../../../modules/terraform-aws-vpc"
  tenant      = var.tenant
  name        = var.name
  environment = var.environment

  # VPC Configuration
  cidr_block    = "10.10.0.0/16"
  single_az_nat = true # testden sonra false yalp
  pbl_sub_count = [
    { cidr = "10.10.1.0/24", zone = "a", eip = "" }

  ]
  pvt_sub_count = [
    { cidr = "10.10.2.0/24", zone = "a" }
  ]
  eks_sub_count = []
  db_sub_count = [
    { cidr = "10.10.3.0/24", zone = "a" }
  ]
  lambda_sub_count = []
}