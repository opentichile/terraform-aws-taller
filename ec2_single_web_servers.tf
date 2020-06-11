# resource "aws_instance" "windows_web_server" {
#   associate_public_ip_address = false
#   disable_api_termination     = false
#   ami                         = data.aws_ami.Windows_2016.id
#   instance_type               = var.instance_type
#   #user_ data = ""
#   key_name               = aws_key_pair.generated_key.key_name
#   iam_instance_profile   = aws_iam_instance_profile.app_instance_profile.name
#   vpc_security_group_ids = [aws_security_group.APP_SG.id]
#   subnet_id              = aws_subnet.PROJECT_PRIVATE_SUBNET.id

#   tags = merge({
#     "Name" = "${local.name_prefix}-IIS-Server"
#     },
#     local.default_tags,
#   )
# }

resource "aws_instance" "ubuntu_web_server" {
  associate_public_ip_address = false
  disable_api_termination     = false
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  #user_ data = ""
  key_name               = aws_key_pair.generated_key.key_name
  iam_instance_profile   = aws_iam_instance_profile.app_instance_profile.name
  vpc_security_group_ids = [aws_security_group.APP_SG.id]
  subnet_id              = aws_subnet.PROJECT_PRIVATE_SUBNET.id

  tags = merge({
    "Name" = "${local.name_prefix}-Nginx-Server"
    },
    local.default_tags,
  )
}

resource "aws_s3_bucket" "backups_bucket" {
  bucket = "infra-course-backups007"
  acl    = "private"
}

