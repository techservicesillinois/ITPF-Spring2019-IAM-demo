resource "aws_iam_role" "default" {
  name               = "testrole"
  description        = "Test role for ITPF demo"
  assume_role_policy = "${data.aws_iam_policy_document.saml.json}"
}

data "aws_iam_policy_document" "saml" {
  statement {
    actions = ["sts:AssumeRoleWithSAML"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::224588347132:saml-provider/shibboleth.illinois.edu"]
    }

    condition {
      test     = "StringEquals"
      variable = "SAML:aud"
      values   = ["https://signin.aws.amazon.com/saml"]
    }
  }
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "S3BucketAccess"
  roles      = ["${aws_iam_role.default.name}"]
  policy_arn = "arn:aws:iam::224588347132:policy/S3BucketAccess"
}
