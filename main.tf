provider "aws" {
  region = "us-east-1"
}

# Create the IAM user first
resource "aws_iam_user" "user_names" {
  for_each = toset(var.user_names)
  name     = each.value
  path     = "/"
}

# Create a login profile for the user with a password
resource "aws_iam_user_login_profile" "user_names" {
  for_each = aws_iam_user.user_names
  user     = each.value.name
  #password = "Midh123456."
  password_length = 10
  #encrypted_password      = "Midh123456"
  password_reset_required = false
}

#create groups in the IAM
resource "aws_iam_group" "group_names" {
  for_each = toset(var.group_names)
  name     = each.value
  path     = "/"
}

# Create IAM group memberships based on user-to-group mapping
resource "aws_iam_group_membership" "user_group" {
  for_each = var.user_group_map

  name  = "${each.key}-membership" # Create a unique name for each group membership
  group = aws_iam_group.group_names[each.value].name
  users = [aws_iam_user.user_names[each.key].name]
}

#Attach default policies to the groups
resource "aws_iam_policy_attachment" "group_policies" {
  for_each   = var.group_policy_map
  name       = "${each.key}-policy-attachment"
  policy_arn = each.value
  groups     = [aws_iam_group.group_names[each.key].name]
}

#Create an EC2 instance
resource "aws_instance" "my_EC2_instance" {
  ami           = var.ami_value
  instance_type = var.instance_type_value

  tags = {
    name = "my_EC2_machine"
  }
}

#Create an S3 Bucket
resource "aws_s3_bucket" "my_S3Bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "My S3 bucket"
  }
}

