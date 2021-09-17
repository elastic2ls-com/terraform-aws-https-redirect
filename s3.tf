resource "aws_s3_bucket" "this" {
  provider = aws.main
  bucket   = var.project_name
  policy   = data.aws_iam_policy_document.this.json

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
