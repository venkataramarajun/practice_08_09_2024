#variable to define the user names 
variable "user_names" {
  type    = list(string)
  default = ["user_venkat", "user_rama", "user_raju"]
}

#variable to define the user names 
variable "group_names" {
  type    = list(string)
  default = ["EC2-Support", "EC2-Admin", "S3-Support"]
}

#variable to map users to the groups
variable "user_group_map" {
  type = map(string)
  default = {
    "user_venkat" = "S3-Support"
    "user_rama"   = "EC2-Support"
    "user_raju"   = "EC2-Admin"
    #"*"           = "Default-users"
  }
}

#variables to map groups to the policies
variable "group_policy_map" {
  type = map(string)
  default = {
    "S3-Support"  = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    "EC2-Support" = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
    "EC2-Admin"   = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  }
}

#variable to give the EC2  value
variable "ami_value" {
  type    = string
  default = "ami-04a81a99f5ec58529"
}

variable "instance_type_value" {
  type    = string
  default = "t2.micro"
}

#Variables to define S3 Bucket
variable "bucket_name" {
  type = string
  default = "my-example-s3-bucket-storage"
}