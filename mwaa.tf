resource "aws_mwaa_environment" "dr_env" {
  name                = "dr-mwaa-environment"
  airflow_version     = "2.6.3"
  environment_class   = "mw1.small"
  execution_role_arn  = var.execution_role_arn
  source_bucket_arn   = "arn:aws:s3:::${var.dags_bucket}"
  dag_s3_path         = "dags"
  requirements_s3_path = "requirements.txt"

  network_configuration {
    security_group_ids = []
    subnet_ids         = []
  }

  airflow_configuration_options = {
    "core.dag_concurrency" = "16"
  }
}

variable "dags_bucket" {}
variable "execution_role_arn" {}