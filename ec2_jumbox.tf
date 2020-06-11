# data "aws_ami" "Windows_2016" {
#   filter {
#     name   = "is-public"
#     values = ["false"]
#   }
#   filter {
#     name   = "name"
#     values = [" "]
#   }
#   most_recent = true
#   owners      = ["amazon", "microsoft"]
# }


# resource "aws_instance" "jumpbox" {
#   associate_public_ip_address = true
#   disable_api_termination     = false
#   ami                         = data.aws_ami.Windows_2016.id
#   instance_type               = var.instance_type
#   #user_ data = ""
#   key_name               = aws_key_pair.generated_key.key_name
#   iam_instance_profile   = aws_iam_instance_profile.app_instance_profile.name
#   vpc_security_group_ids = [aws_security_group.APP_SG.id]
#   subnet_id              = aws_subnet.PROJECT_PUBLIC_SUBNET.id

#   tags = merge({
#     "Name" = "${local.name_prefix}-Jum  pBox"
#     },
#     local.default_tags,
#   )



# }
