module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "aws-tf-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1b"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.2.0/24"]

  # enable_nat_gateway = true
  # enable_vpn_gateway = true

  tags = {
    Name = "aws-tf"
  }
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "aws-tf-sg"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["rdp-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

resource "aws_network_interface" "aws-tf-ni" {
  subnet_id       = element(module.vpc.public_subnets, 1)
  private_ips     = ["10.0.2.100"]
  security_groups = [module.security_group.security_group_id]
  tags = {
    Name = "primary_network_interface"
  }
}


resource "aws_instance" "winscp" {
  ami           = "ami-0193dcf9aa4f5654e"
  instance_type = "t2.micro"
  key_name      = "aws-tf-server"

  network_interface {
    network_interface_id = aws_network_interface.aws-tf-ni.id
    device_index         = 0
  }
  
  tags = {
    Name = "aws_tf_app"
  }
}

resource "aws_transfer_server" "server" {
  domain        = var.ats_domain
  protocols     = var.ats_protocols
  endpoint_type = var.endpoint_type

  endpoint_details {
    vpc_id             = module.vpc.vpc_id
    subnet_ids         = module.vpc.private_subnets
    security_group_ids = [module.security_group.security_group_id]
  }

  identity_provider_type = var.identity_provider_type
  logging_role           = var.logging_role
  force_destroy          = var.force_destroy
  security_policy_name   = var.security_policy_name

  tags = {
    Name = "sftp-transfer-family"
  }
}
