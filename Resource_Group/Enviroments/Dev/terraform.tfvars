# Resource Groups

rg_name = {
  rg1 = {
    name       = "dev_rg_01"
    location   = "westus"
    managed_by = "Terraform"
    tags = {
      project    = "tech-007"
      env        = "dev"
      team       = "dev-007"
      created_by = "Dinesh"
    }
  }

  rg2 = {
    name     = "dev_rg_02"
    location = "eastus"
  }
}






