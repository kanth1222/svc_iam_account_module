output "access_key_id" {
  value       = "${aws_iam_access_key.petco-iam-accesskey.id}"
  description = "The access key ID."
}

output "secret_access_key" {
  value       = "${aws_iam_access_key.petco-iam-accesskey.secret}"
  description = "The secret access key."
}
