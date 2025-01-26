
# IAM Groups
resource "aws_iam_group" "data_engineers" {
  name = var.data_engineers_group_name
}

resource "aws_iam_group" "full_stack" {
  name = var.full_stack_group_name
}

resource "aws_iam_group" "platform_engineers" {
  name = var.platform_engineers_group_name
}

resource "aws_iam_group" "billing_readonly" {
 name = "billing-readonly"
}

# Attach AWS-Managed Policies to Groups
resource "aws_iam_group_policy_attachment" "platform_engineers_admin" {
  group      = aws_iam_group.platform_engineers.name
  policy_arn = var.admin_policy_arn
}

resource "aws_iam_group_policy_attachment" "platform_engineers_cloudwatch" {
  group      = aws_iam_group.platform_engineers.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccessV2"
}

resource "aws_iam_group_policy_attachment" "platform_engineers_sns" {
 group      = aws_iam_group.platform_engineers.name
 policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}

resource "aws_iam_group_policy_attachment" "data_engineers_s3" {
  group      = aws_iam_group.data_engineers.name
  policy_arn = var.s3_policy_arn
}

resource "aws_iam_group_policy_attachment" "full_stack_power_user" {
  group      = aws_iam_group.full_stack.name
  policy_arn = var.power_user_policy_arn
}

resource "aws_iam_group_policy_attachment" "billing_readonly_policy" {
 group      = aws_iam_group.billing_readonly.name
 policy_arn = "arn:aws:iam::aws:policy/AWSBillingReadOnlyAccess"
}


# IAM Users
resource "aws_iam_user" "users" {
  for_each = toset(var.user_names)
  name     = each.value
}

# Assign Users to Groups
resource "aws_iam_group_membership" "platform_engineers" {
  name   = "platform_engineers_group"
  group  = aws_iam_group.platform_engineers.name
  users  = [for user in var.platform_engineer_users : aws_iam_user.users[user].name]
}

resource "aws_iam_group_membership" "data_engineers" {
  name   = "data_engineers_group"
  group  = aws_iam_group.data_engineers.name
  users  = [for user in var.data_engineer_users : aws_iam_user.users[user].name]
}

resource "aws_iam_group_membership" "full_stack" {
  name   = "full_stack_group"
  group  = aws_iam_group.full_stack.name
  users  = [for user in var.full_stack_users : aws_iam_user.users[user].name]
}

resource "aws_iam_group_membership" "billing_readonly" {
 name  = "billing-readonly-membership"
 group = aws_iam_group.billing_readonly.name
 users = [for user in var.billing_readonly_users : aws_iam_user.users[user].name]
}


# Attach additional policies directly to Henry
resource "aws_iam_user_policy_attachment" "henry_additional_policies" {
  for_each = toset(var.henry_additional_policies)

  user       = aws_iam_user.users["Henry"].name
  policy_arn = each.value
}

