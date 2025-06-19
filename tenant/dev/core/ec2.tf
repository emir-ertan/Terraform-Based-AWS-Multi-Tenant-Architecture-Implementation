module "ec2-instance-bootcamp" {
  source      = "../../../modules/terraform-aws-ec2"
  tenant      = var.tenant
  name        = var.name
  environment = var.environment
  vpc_id      = module.core_vpc.vpc_id //core-core_vpc
  cidr_block  = module.core_vpc.cidr_block
  subnet_ids  = module.core_vpc.pbl_subnet_ids

  ##### EC2 Configuration
  ec2_name                    = var.name
  ami_id                      = "ami-0554aa6767e249943" # amazon linux-2 ami us-east-1
  instance_type               = "t2.medium"
  associate_public_ip_address = true
  create_eip                  = false # you must have an internet gateway attached | otherwise, boom!//?
  detailed_monitoring         = false
  stop_protection             = false
  termination_protection      = false
  source_dest_check           = true
  instance_profile            = [] # "IAM role" varsa "Permissions policies" Poicy name liste olarak girilecek yoksa [],
  key_name                    = "keypair_name"                       # can be null
  user_data                   = file("${path.module}/userdata.sh")    # can be false

  ##### EBS Configuration
  encryption                    = true
  kms_key_id                    = null
  delete_volumes_on_termination = true

  # Root Volume Configuration
  root_volume_type = "gp2" # can be null
  root_volume_size = 8     # can be null
  root_throughput  = null  # can be null
  root_iops        = null  # can be null

  # Additional Volume Configuration (only one)
  ebs_device_name = "xvda"
  ebs_volume_type = null # can be null
  ebs_volume_size = null # can be null
  ebs_throughput  = null # can be null
  ebs_iops        = null # can be null

  # Security Group Configuration
  ingress = [
    {
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      description = "Listen ssh from home"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      protocol    = "tcp"
      from_port   = 8080
      to_port     = 8080
      description = "Custom TCP"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}