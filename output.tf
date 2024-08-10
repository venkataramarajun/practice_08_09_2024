#Display passwords that was created for each user
output "user_passwords" {
  value = {
    for user_name, profile in aws_iam_user_login_profile.user_names :
    user_name => profile.password
  }
}

#Display the users and their respective group names
output "user_group" {
  value = {
    for user_name, group_name in var.user_group_map :
    user_name => group_name
  }
}
