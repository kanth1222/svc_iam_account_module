provider "aws" {
  region = var.region
}


terraform {
  backend "s3" {
    bucket   = "rx-nonprod-state-file"
    region   = "us-east-1"
    key      = "svc_git_iam_user/terraform.tfstate"
  }
}

# RESOURCES
data "aws_caller_identity" "current" {}

resource "aws_iam_user" "petco-iam-user" {
  name          = var.aws_iam_user
  path          = "/"
  force_destroy = "true"

  tags = merge(var.tags, {
    Name = var.aws_iam_user
  })
}


resource "aws_iam_group" "group" {
  name = var.iam_group
}

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 25
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
  max_password_age               = 365
}
resource "aws_iam_user_group_membership" "groups" {
  user = aws_iam_user.petco-iam-user.name

  groups = [
    aws_iam_group.group.name

  ]
}

resource "aws_iam_access_key" "petco-iam-accesskey" {
  user = aws_iam_user.petco-iam-user.name
}

resource "aws_iam_policy" "petco-iam-policy" {
  name   = var.execute_policy_name
  policy = file("policy.json")
}

resource "aws_iam_policy_attachment" "policy-attach" {
  name       = var.execute_policy_name
  users      = ["${aws_iam_user.petco-iam-user.name}"]
  policy_arn = aws_iam_policy.petco-iam-policy.arn
}