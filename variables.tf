variable "ats_domain" {
  default     = "S3"
  type        = string
  description = "The domain of the storage system that is used for file transfers. Valid values are: S3 and EFS."
}

variable "ats_protocols" {
  default = [
    "SFTP"
  ]
  type        = list(any)
  description = "Specifies the file transfer protocol or protocols over which your file transfer protocol client can connect to your server's endpoint."
}

variable "endpoint_type" {
  default     = "VPC"
  type        = string
  description = "The type of endpoint that you want your SFTP server connect to. Valid values are: VPC, VPC_EDNPOINT, PUBLIC"
}

variable "vpc_id" {
  default     = "aws_vpc.aws-tf-server-vpc.id"
  type        = string
  description = "The VPC ID of the virtual private cloud in which the SFTP server's endpoint will be hosted. This property can only be used when endpoint_type is set to VPC."
}

variable "subnet_ids" {
  default     = ["aws_subnet.aws-tf-server-subnet.id"]
  type        = list(any)
  description = "A list of subnet IDs that are required to host your SFTP server endpoint in your VPC. This property can only be used when endpoint_type is set to VPC."
}

variable "security_group_ids" {
  default     = ["aws_security_group.aws-tf-server-sg.id"]
  type        = list(any)
  description = "A list of security groups IDs that are available to attach to your server's endpoint. If no security groups are specified, the VPC's default security groups are automatically assigned to your endpoint. This property can only be used when endpoint_type is set to VPC."
}

variable "identity_provider_type" {
  default     = "SERVICE_MANAGED"
  type        = string
  description = "The mode of authentication enabled for this service"
}

variable "logging_role" {
  default     = null
  type        = string
  description = "Amazon Resource Name (ARN) of an IAM role that allows the service to write your SFTP users’ activity to your Amazon CloudWatch logs for monitoring and auditing purposes"
}

variable "force_destroy" {
  default     = false
  type        = bool
  description = "A boolean that indicates all users associated with the server should be deleted so that the Server can be destroyed without error"
}

variable "security_policy_name" {
  default     = "TransferSecurityPolicy-2018-11"
  type        = string
  description = "Specifies the name of the security policy that is attached to the server. Possible values are TransferSecurityPolicy-2018-11, TransferSecurityPolicy-2020-06, and TransferSecurityPolicy-FIPS-2020-06."
}

variable "rolename" {
  default     = "awstfrole"
  type        = string
  description = "aws transfer family role name this role is creating for communication between stores and aws transfer family server"
}

variable "policyname" {
  default     = "aws-tf-role-policy"
  type        = string
  description = "this policy give permission to aws transfer family server for accessing storage"
}

variable "actionsofpolicy" {
  default = [
    "s3:*"
  ]
  type        = list(any)
  description = "action for permission for aws tf role"
}

variable "resourceforpolicy" {
  default = [
    "*"
  ]
  type        = list(any)
  description = "in resource you can give ARN of your buckets or storage"
}


variable "username" {
  default     = "admin"
  type        = string
  description = "user name of transfer family user (for logging for uploading and downloading data)"
}

variable "ssh-key-for-user" {
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDA6Czhd2TZNyte8ZCLLVH/40YsaXm0NXlxztO180McEcXH3wYbe+oUyJR6El4r8AMl0dzH94PHBGeX/wVU1tIKOdgvInhvTEwVa3apt1nkWw1zzpyXleJpG/12oEWKe4mFY9VIrH29fvMZkr1xGUKCzNbgm7wUcifk64Wn/tHf9I91odvAun4FSvJ1Ls09GHjXslu0pTNCxzN12xg30jq4XTAdvPyBUl6Tr04+5XZ3kfxL7VPnleFl+pwFwgmKTYwU8RRZn9cnGNbGIH5ApWO90DXIZx9RFYGiL6mrYKo6LOXKLnj5ftseW0FVqDWWp8B2cDvXwjdGMRosCR+VKPeL3WMGjpyLveLd5keEvxrxMDmatkGUPWtot76MwBDz5g5eaTF/StXKpUnEmQUNdxTBaT7xGsLxYCqz/t3o+GxZYBzKB1LRZkLYZFsbpUJsXVTq+YrecZ6TmE5Mbn6tpzLPOU9lYmJeVe1RpCqZSly9LbP4C0xjxTA160uLLMxJyyU= 17422@OM-C02FL3TYMD6R"
  type        = string
  description = "ssh-key for user who logging to the transfer family"
}

variable "homedirectorypath" {
  default     = "/"
  type        = string
  description = "The landing directory (folder) for a user when they log in to the server using their SFTP client. It should begin with a /."
}

variable "homedirectorytype" {
  default     = "PATH"
  type        = string
  description = "The type of landing directory (folder) you mapped for your users' home directory. Valid values are PATH and LOGICAL."
}
