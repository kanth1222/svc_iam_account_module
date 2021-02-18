variable "region" {
  default = "us-east-1"
}

variable "description" {
  default = ""
}


variable "role_name" {
  default = ""
}

variable "policy_name" {
  default = ""
}


############################
##########tagging###########
############################


variable "tags" {
  type = map(any)
  default = {
    "org"          = ""
    "contactemail" = ""
    "aws_org"      = ""
    "owner"        = ""
  }
}
