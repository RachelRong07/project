# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "ap-southeast-2"
}

# Group Names
variable "data_engineers_group_name" {
  description = "Name of the Data Engineers group"
  default     = "DataEngineers"
}

variable "full_stack_group_name" {
  description = "Name of the Full Stack group"
  default     = "FullStack"
}

variable "platform_engineers_group_name" {
  description = "Name of the Platform Engineers group"
  default     = "PlatformEngineers"
}

# Policy ARNs
variable "admin_policy_arn" {
  description = "ARN for AdministratorAccess policy"
  default     = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "s3_policy_arn" {
  description = "ARN for AmazonS3FullAccess policy"
  default     = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

variable "power_user_policy_arn" {
  description = "ARN for PowerUserAccess policy"
  default     = "arn:aws:iam::aws:policy/PowerUserAccess"
}

# User Names
variable "user_names" {
  description = "List of all IAM user names"
  default     = ["Henry", "Rachel", "Sherry", "Ray", "Anna", "Milly"]
}

# Group Memberships
variable "platform_engineer_users" {
  description = "Users belonging to the Platform Engineers group"
  default     = ["Henry", "Rachel"]
}

variable "data_engineer_users" {
  description = "Users belonging to the Data Engineers group"
  default     = ["Henry", "Rachel", "Sherry", "Anna"]
}

variable "full_stack_users" {
  description = "Users belonging to the Full Stack group"
  default     = ["Ray", "Milly", "Rachel"]
}

variable "billing_readonly_users" {
 description = "Users with billing read access"
 default = ["Henry", "Rachel", "Sherry", "Ray", "Anna", "Milly"] 
}

# Variables for Henry's specific permissions
variable "henry_additional_policies" {
  description = "Additional policies to attach directly to Henry"
  default     = [
    "arn:aws:iam::aws:policy/job-function/Billing",
    "arn:aws:iam::aws:policy/CloudWatchFullAccessV2",
    "arn:aws:iam::aws:policy/IAMUserChangePassword"
  ]
}


# variables.tf
variable "alert_emails" {
  type = list(string)
  default = [
    "oceancdy1989@gmail.com"
    
  ]
}