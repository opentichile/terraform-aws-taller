# PROYECTO TERRAFORM PACKER ANSIBLE

Objetivo: demostrar de forma práctica el conocimiento de automatización y configuración de infraestructura.
Herramientas a evaluar:

- Packer ( Aplicado )
- Ansible ( Aplicado )
- Terraform ( Aplicado )
- Terragrunt(opcional) Lo descarte

  (Cumplido)
  Utilizando una cuenta gratuita de AWS realizar la automatización del siguiente ejercicio

  Utilizando la VPC y redes por defecto de la cuenta realizar los scripts de automatización para los siguientes componentes:

- Application Load Balancer
- AMI (optional encryption) (Cumplido)
- RDS (PostgreSQL) ( Cumplido )
- R53 alias
- R53 Hosted Zone
- EFS (optional) Descarte por tiempo

Descripcion :

- VPC que contiene 2 SUBNETS
- Subnets
- Security Groups > para restringir el acceso a los recursos
- Network ACL > para restringir el acceso a nuestra red
- Internet gateway > para el acceso a internet

- Nat Gateway > para tener acceso a internet sin necesidad de tener un ip publico

- Elastic IP > para localizar nuestra instancia desde internet
- VPC EndPoints > para acceder a los servicios www directamente
- Availability Zones > dos distintas para poder tener acceso a recursos de hardware separado.
- Route Tables > son los que van a definir la direccion de los paquetes cuando llegan a nuestra red.

- \*\* Para Planificar terraform >\$ terraform plan -var-file="tfvars.json"

# COMPOSICION ARCHIVOS PROYECTO

```
.
├── README.md
├── imagen.png
├── load_balancer.tf
├── locals.tf
├── project-ubuntu.json
├── provider.tf
├── rds.tf
├── terraform.tfstate
├── tfvars.json
├── var.tf
├── verions.tf
└── vpc.tf



```

# ARQUITECTURA

![image](https://github.com/opentichile/terraform-aws-taller/blob/master/imagen.png)

Recursos Terraform
Terraform will perform the following actions:

# aws_db_instance.Postgres_DB_Instance will be created

- resource "aws_db_instance" "Postgres_DB_Instance" {
  - address = (known after apply)
  - allocated_storage = 20
  - apply_immediately = (known after apply)
  - arn = (known after apply)
  - auto_minor_version_upgrade = true
  - availability_zone = (known after apply)
  - backup_retention_period = (known after apply)
  - backup_window = (known after apply)
  - ca_cert_identifier = (known after apply)
  - character_set_name = (known after apply)
  - copy_tags_to_snapshot = false
  - db_subnet_group_name = (known after apply)
  - delete_automated_backups = true
  - endpoint = (known after apply)
  - engine = "postgres"
  - engine_version = "10.6"
  - hosted_zone_id = (known after apply)
  - id = (known after apply)
  - identifier = "tallerdevopssre-rds"
  - identifier_prefix = (known after apply)
  - instance_class = "db.12.small"
  - kms_key_id = (known after apply)
  - license_model = (known after apply)
  - maintenance_window = (known after apply)
  - monitoring_interval = 0
  - monitoring_role_arn = (known after apply)
  - multi_az = true
  - name = "sample"
  - option_group_name = (known after apply)
  - parameter_group_name = (known after apply)
  - password = (sensitive value)
  - performance_insights_enabled = false
  - performance_insights_kms_key_id = (known after apply)
  - performance_insights_retention_period = (known after apply)
  - port = (known after apply)
  - publicly_accessible = false
  - replicas = (known after apply)
  - resource_id = (known after apply)
  - skip_final_snapshot = true
  - status = (known after apply)
  - storage_encrypted = true
  - storage_type = "gp2"
  - tags = {
    - "Environment" = "TALLERDEVOPSSRE"
    - "Name" = "TALLERDEVOPSSRE-RDS"
    - "Product" = "WEBAPP"
      }
  - timezone = (known after apply)
  - username = "projectUser"
  - vpc_security_group_ids = [
    - "sg-0ab004aefd975db09",
      ]
      }

# aws_db_subnet_group.Postgres_DB_Subnet_Group will be created

- resource "aws_db_subnet_group" "Postgres_DB_Subnet_Group" {
  - arn = (known after apply)
  - description = "Managed by Terraform"
  - id = (known after apply)
  - name = "tallerdevopssre_subnet_group"
  - name_prefix = (known after apply)
  - subnet_ids = (known after apply)
  - tags = { + "Environment" = "TALLERDEVOPSSRE" + "Name" = "TALLERDEVOPSSRE-SUBNET-GROUP" + "Product" = "WEBAPP"
    }
    }

# aws_lb.app_alb will be created

- resource "aws_lb" "app_alb" {

  - arn = (known after apply)
  - arn_suffix = (known after apply)
  - dns_name = (known after apply)
  - drop_invalid_header_fields = false
  - enable_deletion_protection = false
  - enable_http2 = true
  - id = (known after apply)
  - idle_timeout = 600
  - internal = true
  - ip_address_type = (known after apply)
  - load_balancer_type = "application"
  - name = "TALLERDEVOPSSRE-app-ALB"
  - security_groups = [
    - "sg-09f6ca6804dd9cf9b",
      ]
  - subnets = (known after apply)
  - tags = {
    - "Environment" = "TALLERDEVOPSSRE"
    - "Name" = "TALLERDEVOPSSRE-app-ALB"
    - "Product" = "WEBAPP"
      }
  - vpc_id = (known after apply)
  - zone_id = (known after apply)

  - subnet_mapping { + allocation_id = (known after apply) + subnet_id = (known after apply)
    }
    }

# aws_lb_listener.APP_http_listener will be created

- resource "aws_lb_listener" "APP_http_listener" {

  - arn = (known after apply)
  - id = (known after apply)
  - load_balancer_arn = (known after apply)
  - port = 80
  - protocol = "HTTP"
  - ssl_policy = (known after apply)

  - default_action { + order = (known after apply) + target_group_arn = "arn:aws:elasticloadbalancing:us-east-2:351429232809:targetgroup/TALLERDEVOPSSRE-APP-TF/38f87fef92cfbd62" + type = "forward"
    }
    }

# aws_nat_gateway.PROJECT_NAT will be created

- resource "aws_nat_gateway" "PROJECT_NAT" {
  - allocation_id = "eipalloc-00a1892f450b2efc0"
  - id = (known after apply)
  - network_interface_id = (known after apply)
  - private_ip = (known after apply)
  - public_ip = (known after apply)
  - subnet_id = (known after apply)
  - tags = { + "Environment" = "TALLERDEVOPSSRE" + "Name" = "TALLERDEVOPSSRE-NGW" + "Product" = "WEBAPP"
    }
    }

# aws_network_acl.PROJECT_NACL will be created

- resource "aws_network_acl" "PROJECT_NACL" {
  - egress = [
    - {
      - action = "allow"
      - cidr_blocks = "0.0.0.0/0"
      - from_port = 0
      - icmp_code = null
      - icmp_type = null
      - ipv6_cidr_blocks = ""
      - protocol = "tcp"
      - rule_no = 32766
      - to_port = 0
        },
    - { + action = "deny" + cidr_blocks = "0.0.0.0/0" + from_port = 23 + icmp_code = null + icmp_type = null + ipv6_cidr_blocks = "" + protocol = "tcp" + rule_no = 110 + to_port = 23
      },
      ]
  - id = (known after apply)
  - ingress = [
    - {
      - action = "allow"
      - cidr_blocks = "0.0.0.0/0"
      - from_port = 0
      - icmp_code = null
      - icmp_type = null
      - ipv6_cidr_blocks = ""
      - protocol = "tcp"
      - rule_no = 32766
      - to_port = 0
        },
    - { + action = "deny" + cidr_blocks = "0.0.0.0/0" + from_port = 23 + icmp_code = null + icmp_type = null + ipv6_cidr_blocks = "" + protocol = "tcp" + rule_no = 110 + to_port = 23
      },
      ]
  - owner_id = (known after apply)
  - subnet_ids = (known after apply)
  - tags = {
    - "Environment" = "TALLERDEVOPSSRE"
    - "Name" = "TALLERDEVOPSSRE-NANCL"
    - "Product" = "WEBAPP"
      }
  - vpc_id = "vpc-0f9c098ab63c01e32"
    }

# aws_route_table.PROJECT_PRIVATE_ROUTE is tainted, so must be replaced

-/+ resource "aws_route_table" "PROJECT_PRIVATE_ROUTE" {
~ id = "rtb-0ff4ac6458a625e33" -> (known after apply)
~ owner_id = "351429232809" -> (known after apply)
~ propagating_vgws = [] -> (known after apply)
~ route = [

- {
- cidr_blocks = "0.0.0.0/0"
- egress_only_gateway_id = ""
- gateway_id = ""
- instance_id = ""
- ipv6_cidr_blocks = ""
- nat_gateway_id = "igw-034cf628d3a2c24ac"
- network_interface_id = ""
- transit_gateway_id = ""
- vpc_peering_connection_id = ""
  },
  ]
  tags = {
  "Environment" = "TALLERDEVOPSSRE"
  "Name" = "TALLERDEVOPSSRE-PRIVATE-RT"
  "Product" = "WEBAPP"
  }
  vpc_id = "vpc-0f9c098ab63c01e32"
  }

# aws_route_table_association.PRIVATE_ASSO will be created

- resource "aws_route_table_association" "PRIVATE_ASSO" {
  - id = (known after apply)
  - route_table_id = (known after apply)
  - subnet_id = (known after apply)
    }

# aws_route_table_association.PUBLIC_ASSO will be created

- resource "aws_route_table_association" "PUBLIC_ASSO" {
  - id = (known after apply)
  - route_table_id = "rtb-06c4ef0d4f6e14d58"
  - subnet_id = (known after apply)
    }

# aws_subnet.PROJECT_PRIVATE_SUBNET will be created

- resource "aws_subnet" "PROJECT_PRIVATE_SUBNET" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-east-2b"
  - availability_zone_id = (known after apply)
  - id = (known after apply)
  - ipv6_cidr_blocks = (known after apply)
  - ipv6_cidr_blocks_association_id = (known after apply)
  - map_public_ip_on_launch = false
  - owner_id = (known after apply)
  - tags = {
    - "Environment" = "TALLERDEVOPSSRE"
    - "Name" = "TALLERDEVOPSSRE-SUBNET-AZ-B"
    - "Product" = "WEBAPP"
      }
  - vpc_id = "vpc-0f9c098ab63c01e32"
    }

# aws_subnet.PROJECT_PUBLIC_SUBNET will be created

- resource "aws_subnet" "PROJECT_PUBLIC_SUBNET" {
  - arn = (known after apply)
  - assign_ipv6_address_on_creation = false
  - availability_zone = "us-east-2a"
  - availability_zone_id = (known after apply)
  - id = (known after apply)
  - ipv6_cidr_blocks = (known after apply)
  - ipv6_cidr_blocks_association_id = (known after apply)
  - map_public_ip_on_launch = true
  - owner_id = (known after apply)
  - tags = {
    - "Environment" = "TALLERDEVOPSSRE"
    - "Name" = "TALLERDEVOPSSRE-SUBNET-AZ-A"
    - "Product" = "WEBAPP"
      }
  - vpc_id = "vpc-0f9c098ab63c01e32"
    }

# aws_vpc_endpoint.PROJECT_S3_ENDPOINT will be created

- resource "aws_vpc_endpoint" "PROJECT_S3_ENDPOINT" {
  - cidr_blocks = (known after apply)
  - dns_entry = (known after apply)
  - id = (known after apply)
  - network_interface_ids = (known after apply)
  - owner_id = (known after apply)
  - policy = (known after apply)
  - prefix_list_id = (known after apply)
  - private_dns_enabled = false
  - requester_managed = (known after apply)
  - route_table_ids = (known after apply)
  - security_group_ids = (known after apply)
  - service_name = "com.amazonaws.us-east-2.s3"
  - state = (known after apply)
  - subnet_ids = (known after apply)
  - vpc_endpoint_type = "Gateway"
  - vpc_id = "vpc-0f9c098ab63c01e32"
    }

```

```
