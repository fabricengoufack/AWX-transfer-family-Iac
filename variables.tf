variable "ats_domain" {
  default     = "s3"
  type        = string
  description = "The domain of the storage system that is used for file transfers. Valid values are: S3 and EFS."
}

variable "ats_protocols" {
  default     = [
    "SFTP"
  ] 
  type        = list
  description = "Specifies the file transfer protocol or protocols over which your file transfer protocol client can connect to your server's endpoint."
}

variable "endpoint_type" {
  default     = "PUBLIC"
  type        = string
  description = "The type of endpoint that you want your SFTP server connect to. Valid values are: VPC, VPC_EDNPOINT, PUBLIC"
}

variable "vpc_id" {
  default     = ""
  type        = string
  description = "The VPC ID of the virtual private cloud in which the SFTP server's endpoint will be hosted. This property can only be used when endpoint_type is set to VPC."
}

variable "subnet_ids" {
  default     = []
  type        = list
  description = "A list of subnet IDs that are required to host your SFTP server endpoint in your VPC. This property can only be used when endpoint_type is set to VPC."    
}

variable "security_group_ids" {
  default     = []
  type        = list
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

variable "force_destroy " {
  default     = false
  type        = bool
  description = "A boolean that indicates all users associated with the server should be deleted so that the Server can be destroyed without error"
}

variable "security_policy_name" {
  default     = "TransferSecurityPolicy-2018-11"
  type        = string
  description = "Specifies the name of the security policy that is attached to the server. Possible values are TransferSecurityPolicy-2018-11, TransferSecurityPolicy-2020-06, and TransferSecurityPolicy-FIPS-2020-06."
}

