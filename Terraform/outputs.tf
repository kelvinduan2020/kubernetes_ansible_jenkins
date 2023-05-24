# output "username" {
#   value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.current.secret_string))["username"]
# }
# output "password" {
#   value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.current.secret_string))["password"]
# }