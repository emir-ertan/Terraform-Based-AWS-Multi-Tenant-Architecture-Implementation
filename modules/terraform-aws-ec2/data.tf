data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "random_shuffle" "zone" {
  input        = var.subnet_ids
  result_count = 1
}