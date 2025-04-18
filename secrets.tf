resource "aws_secretsmanager_secret" "active_region" {
  name = "primary-or-dr-secret"
}

resource "aws_secretsmanager_secret_version" "active_value" {
  secret_id     = aws_secretsmanager_secret.active_region.id
  secret_string = jsonencode({ active = "primary" })
}