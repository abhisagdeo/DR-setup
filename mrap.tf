resource "aws_s3control_multi_region_access_point" "mrap" {
  name       = "primary-mrap"
  account_id = var.account_id

  details {
    name = "primary-mrap"
    regions {
      bucket = var.primary_bucket_name
      region = "us-east-1"
    }
  }
}

variable "primary_bucket_name" {}
variable "account_id" {}