locals {

  endpoint_details = {
    vpc_id             = var.vpc_id
    subnet_id          = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
}

resource "aws_transfer_server" "main" {
  domain                 = var.ats_domain
  protocols              = var.ats_protocols
  endpoint_type          = var.endpoint_type
  endpoint_details       = var.endpoint_type == "VPC" ? local.endpoint_details : {}
  identity_provider_type = var.identity_provider_type
  logging_role           = var.logging_role
  force_destroy          = var.force_destroy
  security_policy_name   = var.security_policy_name

  tags = {
    Name = "sftp-transfer-family"
  }
}
