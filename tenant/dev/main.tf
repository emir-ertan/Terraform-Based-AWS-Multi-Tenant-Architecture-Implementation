##### Parameters to forward for Core deployment
module "core" {
  source      = "./core"
  tenant      = "bootcamp"
  name        = "my-project"
  environment = "dev"
}