resource "aws_glue_job" "dr_replicated_job" {
  name     = "dr-replicated-glue-job"
  role_arn = var.glue_role_arn

  command {
    name            = "glueetl"
    script_location = "s3://${var.script_bucket}/glue_script.py"
    python_version  = "3"
  }

  glue_version = "3.0"
  timeout      = 2880
  max_retries  = 0
}

variable "script_bucket" {}
variable "glue_role_arn" {}