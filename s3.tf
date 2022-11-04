resource "aws_s3_bucket" "this" {
  provider = aws.main
  bucket   = var.project_name
  policy   = data.aws_iam_policy_document.this.json

  block_public_acls       = true
  
  website {
    redirect_all_requests_to = "https://${var.target_domain}"
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.project_name
    },
  )
}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "Redirect ${var.project_name}"
    effect = "Allow"

    principals {
      identifiers = [
        "*",
      ]
      type = "AWS"
    }

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${var.project_name}",
      "arn:aws:s3:::${var.project_name}/*"
    ]
  }

  version = "2012-10-17"
}

resource "aws_kms_key" "this" {
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.this.arn
      sse_algorithm     = "aws:kms"
    }
  }
}


resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "log_bucket"
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.log_bucket.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "this" {
  bucket = aws_s3_bucket.this.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}
