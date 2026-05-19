data "aws_secretsmanager_random_password" "docdb_password" {
  password_length = 50
  exclude_numbers = false
  exclude_punctuation = true

}

resource "aws_secretsmanager_secret" "generated_password" {
  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "name" {
  secret_id = aws_secretsmanager_secret.generated_password.id
  secret_string = data.aws_secretsmanager_random_password.docdb_password.random_password

  depends_on = [ aws_secretsmanager_secret.generated_password ]
}

output "generated_password" {
  value = data.aws_secretsmanager_random_password.docdb_password.random_password
}