#------------------------------------------------------------
# backend.tf
#------------------------------------------------------------
terraform {
  cloud {
    organization = "singlekorn"

    workspaces {
      tags = ["project:ahi-updater"]
    }
  }
}
