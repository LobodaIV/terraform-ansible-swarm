resource "aws_s3_bucket" "ddtnet" {
  bucket = "${var.aws_networking_bucket}"
  acl    = "private"
  force_destroy = true

  versioning {
    enabled = true
  }
}

#resource "terraform_remote_state" "remote_state" {
#    depends_on = ["aws_s3_bucket.ddtnet"]
#    backend = "s3"
#    config {
#        bucket = "${aws_s3_bucket.ddtnet.id}"
#        key = "networking.state"
#    }
#}

terraform {
  depends_on  = ["aws_s3_bucket.ddtnet"]
  backend "s3" {
    key = "networking.state"
    region = "eu-central-1"
  }
}
