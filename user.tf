data "aws_iam_policy_document" "assume-role-policy" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "aws-tf-role-policy" {
  version = "2012-10-17"
  statement {
    actions   = var.actionsofpolicy
    resources = var.resourceforpolicy

  }
}


resource "aws_transfer_ssh_key" "ssh-key-for-user" {
  server_id = aws_transfer_server.server.id
  user_name = aws_transfer_user.admin.user_name
  body      = var.ssh-key-for-user
}

resource "aws_iam_role" "awstfrole" {
  name               = var.rolename
  assume_role_policy = data.aws_iam_policy_document.assume-role-policy.json
}

resource "aws_iam_policy" "awstfrolepolicy" {
  name   = var.policyname
  policy = data.aws_iam_policy_document.aws-tf-role-policy.json
}

resource "aws_iam_role_policy_attachment" "attaching-policy" {
  role       = aws_iam_role.awstfrole.name
  policy_arn = aws_iam_policy.awstfrolepolicy.arn
}

resource "aws_transfer_user" "admin" {
  server_id           = aws_transfer_server.server.id
  user_name           = var.username
  role                = aws_iam_role.awstfrole.arn
  home_directory      = var.homedirectorypath
  home_directory_type = var.homedirectorytype
}

resource "aws_s3_bucket" "s3-storage-for-tf" {
  bucket = "s3-storage-for-tf"
}
