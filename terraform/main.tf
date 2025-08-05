module "medusa" {
  source            = "github.com/resizes/platform-terraform-module-github-oidc-aws-role?ref=main"
  name              = "github-oidc-medusa-starter"
  org_name          = "resizes"
  condition_test    = "StringLike"
  actions = [
    "ecr:BatchCheckLayerAvailability",
    "ecr:BatchGetImage",
    "ecr:GetAuthorizationToken",
    "ecr:InitiateLayerUpload",
    "ecr:UploadLayerPart",
    "ecr:CompleteLayerUpload",
    "ecr:PutImage",
  ]
  assume_role_policy_condition_values = [
    "repo:resizes/medusa-starter-default:ref:refs/heads/main",
    "repo:resizes/medusa-starter-default:ref:refs/heads/master",
    "repo:resizes/medusa-starter-default:ref:refs/tags/v*"
  ]
}

resource "aws_ecr_repository" "medusa" {
  name                 = "medusa"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_iam_policy_document" "medusa" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["192743882748", "471112548051"]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability"
    ]
  }
}

resource "aws_ecr_repository_policy" "medusa" {
  repository = aws_ecr_repository.medusa.name
  policy     = data.aws_iam_policy_document.medusa.json
}