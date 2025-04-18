output "glue_script_bucket" {
  value = module.s3.glue_script_bucket
}

output "mwaa_dags_bucket" {
  value = module.s3.dags_bucket
}