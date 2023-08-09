provider "aws" {
  alias  = "certificate_region"
  region = var.certificate_region
}

provider "aws" {
  alias  = "main"
  region = var.main_region
}