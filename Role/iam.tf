provider "aws" {
  region = var.region
}

## State Backend
terraform {
  backend "s3" {
    bucket = "rx-nonprod-state-file"
    region = "us-east-1"
    key    = "Dev/Lambda-excution-role/terraform.tfstate"
  }
}


resource "aws_iam_role" "role" {
  name               = var.role_name
  description        = var.description
  assume_role_policy = file("assume_role_policy.json")

  tags = merge(var.tags, {
    Name = "var.role_name"
  })
}

resource "aws_iam_policy" "policy" {
  name        = var.policy_name
  description = var.description
  policy      = file("policy.json")
}

resource "aws_iam_role_policy_attachment" "policy_attach" {
  depends_on = [
    aws_iam_role.role,
    aws_iam_policy.policy
  ]

  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}
