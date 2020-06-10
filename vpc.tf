# PVC
resource "aws_vpc" "PROJECT_VPC" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    tags = merge({
        "Name" = "${local.name_prefix}-VPC"
    },
     local.default_tags,
    )
}
# GateWAY
resource "aws_internet_gateway" "PROJECT_IGW"{
    vpc_id = aws_pvc.COURSE_VPC.id
    tags = merge({
        "Name" = "${local.name_prefix}-IGW"
    },
    local.default_tags,
    )
}
# Dos sub Redes Resilientes una publica y otra privada
# SUB RED Publica 
resource "aws_subnet" "PROJECT_PUBLIC_SUBNET" {
    map_public_ip_on_launch = true
    availability_zone = element(var.az_name, 0)
    vpc_id = aws_vpc.COURSE_VPC.id
    cidr_block = element(var.subnet_cidr_blocks, 0)
    tags = merge({
        "Name" = "${local.name_prefix}-SUBNET-AZ-A"
    },
    local.default_tags,
    )
}
# SUB RED Privada 
resource "aws_subnet" "PROJECT_PRIVATE_SUBNET" {
    map_public_ip_on_launch = false
    availability_zone = element(var.az_name, 1)
    vpc_id = aws_vpc.COURSE_VPC.id
    cidr_block = element(var.subnet_cidr_blocks, 1)
    tags = merge({
        "Name" = "${local.name_prefix}-SUBNET-AZ-B"
    },
    local.default_tags,
    )
}

# ELASTIC IP 
resource  "aws_eip" "APP_EIP" {

}

# NAT GATEWAY
resource  "aws_nat_gateway" "COURSE_NAT" {
    subnet_id = aws_subnet.COURSE_PUBLIC:SUBNET.id
    allocation_id = aws_eip.APP_EIP.vpc_id
    tags = merge({
        "Name" = "${local.name_prefix}-NGW"
    },
    local.default_tags,
    )
}





