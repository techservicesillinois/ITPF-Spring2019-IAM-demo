data "aws_iam_policy_document" "default" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = ["arn:aws:s3:::itpro-demo"]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetObject",
    ]

    resources = ["arn:aws:s3:::itpro-demo/*"]
  }

  # Minimum permissions needed to access the S3 console
  statement {
    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = ["arn:aws:s3:::*"]
  }
}

resource "aws_iam_policy" "default" {
  name = "S3BucketAccess"

  path = "/"

  description = "Policy that allows access to S3 bucket"

  policy = "${data.aws_iam_policy_document.default.json}"
}
