resource "aws_s3_bucket" "glue_scripts" {
  bucket        = "dr-glue-scripts-bucket"
  force_destroy = true
}

resource "aws_s3_bucket" "mwaa_dags" {
  bucket        = "dr-mwaa-dags-bucket"
  force_destroy = true
}

output "glue_script_bucket" {
  value = aws_s3_bucket.glue_scripts.bucket
}

output "dags_bucket" {
  value = aws_s3_bucket.mwaa_dags.bucket
}