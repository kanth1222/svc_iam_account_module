variable "region" {
  default = "us-east-1"
}

#iam user
variable "iam_group" {
  default = "svc_git_cicd"
}

variable "execute_policy_name" {
  default = "svc_git_cicd_nonprod_policy"
}

variable "description" {
  default = "git cicd role for iso-nonprod for deply aws services"
}
variable "aws_iam_user" {
  default = "svc_git_cicd_nonprod"
}

variable "Name" {
  default = "svc_git_cicd_nonprod"
}





############################
##########tagging###########
############################


variable "tags" {
  type = map
  default = {
    "value"        = "git cicd role for iso_nonprod for deply aws services"
    "org"          = ""
    "contactemail" = ""
    "aws_org"      = ""
    "squad-email"  = ""
    "env"          = ""

  }
}