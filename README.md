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
├── README.md
├── ansible-webserver-playbook.yml
├── autoscaling_group.tf
├── ec2_jumbox.tf
├── ec2_single_web_servers.tf
├── imagen.png
├── load-balancer.tf
├── locals.tf
├── packer-ubuntu.json
├── provider.tf
├── rds.tf
├── roles.tf
├── route53.tf
├── scripts
│   └── install_software.sh
├── terraform.tfstate
├── terraform.tfstate.backup
├── tfvars.json
├── var.tf
├── versions.tf
└── vpc.tf

```

# ARQUITECTURA

![image](https://github.com/opentichile/terraform-aws-taller/blob/master/imagen.png)

Recursos Terraform
Terraform will perform the following actions:

 # aws_db_instance.Postgres_DB_Instance will be created
  + resource "aws_db_instance" "Postgres_DB_Instance" {
      + address                               = (known after apply)
      + allocated_storage                     = 20
      + apply_immediately                     = (known after apply)
      + arn                                   = (known after apply)
      + auto_minor_version_upgrade            = true
      + availability_zone                     = (known after apply)
      + backup_retention_period               = (known after apply)
      + backup_window                         = (known after apply)
      + ca_cert_identifier                    = (known after apply)
      + character_set_name                    = (known after apply)
      + copy_tags_to_snapshot                 = false
      + db_subnet_group_name                  = (known after apply)
      + delete_automated_backups              = true
      + endpoint                              = (known after apply)
      + engine                                = (known after apply)
      + engine_version                        = "10.6"
      + hosted_zone_id                        = (known after apply)
      + id                                    = (known after apply)
      + identifier                            = "taller-devops-sre-rds"
      + identifier_prefix                     = (known after apply)
      + instance_class                        = "db.12.small"
      + kms_key_id                            = (known after apply)
      + license_model                         = (known after apply)
      + maintenance_window                    = (known after apply)
      + monitoring_interval                   = 0
      + monitoring_role_arn                   = (known after apply)
      + multi_az                              = true
      + name                                  = "sample"
      + option_group_name                     = (known after apply)
      + parameter_group_name                  = (known after apply)
      + password                              = (sensitive value)
      + performance_insights_enabled          = false
      + performance_insights_kms_key_id       = (known after apply)
      + performance_insights_retention_period = (known after apply)
      + port                                  = (known after apply)
      + publicly_accessible                   = false
      + replicas                              = (known after apply)
      + resource_id                           = (known after apply)
      + skip_final_snapshot                   = true
      + status                                = (known after apply)
      + storage_encrypted                     = true
      + storage_type                          = "gp2"
      + tags                                  = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-RDS"
          + "Product"     = "WEBAPP"
        }
      + timezone                              = (known after apply)
      + username                              = "projectUser"
      + vpc_security_group_ids                = (known after apply)
    }

  # aws_db_subnet_group.Postgres_DB_Subnet_Group will be created
  + resource "aws_db_subnet_group" "Postgres_DB_Subnet_Group" {
      + arn         = (known after apply)
      + description = "Managed by Terraform"
      + id          = (known after apply)
      + name        = "taller-devops-sre_subnet_group"
      + name_prefix = (known after apply)
      + subnet_ids  = (known after apply)
      + tags        = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-SUBNET-GROUP"
          + "Product"     = "WEBAPP"
        }
    }

  # aws_eip.APP_EIP will be created
  + resource "aws_eip" "APP_EIP" {
      + allocation_id     = (known after apply)
      + association_id    = (known after apply)
      + customer_owned_ip = (known after apply)
      + domain            = (known after apply)
      + id                = (known after apply)
      + instance          = (known after apply)
      + network_interface = (known after apply)
      + private_dns       = (known after apply)
      + private_ip        = (known after apply)
      + public_dns        = (known after apply)
      + public_ip         = (known after apply)
      + public_ipv4_pool  = (known after apply)
      + vpc               = (known after apply)
    }

  # aws_internet_gateway.PROJECT_IGW will be created
  + resource "aws_internet_gateway" "PROJECT_IGW" {
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-IGW"
          + "Product"     = "WEBAPP"
        }
      + vpc_id   = (known after apply)
    }

  # aws_lb.app_alb will be created
  + resource "aws_lb" "app_alb" {
      + arn                        = (known after apply)
      + arn_suffix                 = (known after apply)
      + dns_name                   = (known after apply)
      + drop_invalid_header_fields = false
      + enable_deletion_protection = false
      + enable_http2               = true
      + id                         = (known after apply)
      + idle_timeout               = 600
      + internal                   = true
      + ip_address_type            = (known after apply)
      + load_balancer_type         = "application"
      + name                       = "TALLER-DEVOPS-SRE-app-ALB"
      + security_groups            = (known after apply)
      + subnets                    = (known after apply)
      + tags                       = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-app-ALB"
          + "Product"     = "WEBAPP"
        }
      + vpc_id                     = (known after apply)
      + zone_id                    = (known after apply)

      + subnet_mapping {
          + allocation_id = (known after apply)
          + subnet_id     = (known after apply)
        }
    }

  # aws_lb_listener.APP_http_listener will be created
  + resource "aws_lb_listener" "APP_http_listener" {
      + arn               = (known after apply)
      + id                = (known after apply)
      + load_balancer_arn = (known after apply)
      + port              = 80
      + protocol          = "HTTP"
      + ssl_policy        = (known after apply)

      + default_action {
          + order            = (known after apply)
          + target_group_arn = (known after apply)
          + type             = "forward"
        }
    }

  # aws_lb_target_group.APP_TG will be created
  + resource "aws_lb_target_group" "APP_TG" {
      + arn                                = (known after apply)
      + arn_suffix                         = (known after apply)
      + deregistration_delay               = 300
      + id                                 = (known after apply)
      + lambda_multi_value_headers_enabled = false
      + load_balancing_algorithm_type      = (known after apply)
      + name                               = "TALLER-DEVOPS-SRE-APP-TF"
      + port                               = 80
      + protocol                           = "HTTP"
      + proxy_protocol_v2                  = false
      + slow_start                         = 0
      + tags                               = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-app-LB-TG"
          + "Product"     = "WEBAPP"
        }
      + target_type                        = "instance"
      + vpc_id                             = (known after apply)

      + health_check {
          + enabled             = true
          + healthy_threshold   = 2
          + interval            = 30
          + matcher             = "200"
          + path                = (known after apply)
          + port                = "traffic-port"
          + protocol            = "HTTP"
          + timeout             = 5
          + unhealthy_threshold = 2
        }

      + stickiness {
          + cookie_duration = (known after apply)
          + enabled         = (known after apply)
          + type            = (known after apply)
        }
    }

  # aws_nat_gateway.PROJECT_NAT will be created
  + resource "aws_nat_gateway" "PROJECT_NAT" {
      + allocation_id        = (known after apply)
      + id                   = (known after apply)
      + network_interface_id = (known after apply)
      + private_ip           = (known after apply)
      + public_ip            = (known after apply)
      + subnet_id            = (known after apply)
      + tags                 = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-NGW"
          + "Product"     = "WEBAPP"
        }
    }

  # aws_network_acl.PROJECT_NACL will be created
  + resource "aws_network_acl" "PROJECT_NACL" {
      + egress     = [
          + {
              + action          = "allow"
              + cidr_block      = "0.0.0.0/0"
              + from_port       = 0
              + icmp_code       = null
              + icmp_type       = null
              + ipv6_cidr_block = ""
              + protocol        = "tcp"
              + rule_no         = 32766
              + to_port         = 0
            },
          + {
              + action          = "deny"
              + cidr_block      = "0.0.0.0/0"
              + from_port       = 23
              + icmp_code       = null
              + icmp_type       = null
              + ipv6_cidr_block = ""
              + protocol        = "tcp"
              + rule_no         = 110
              + to_port         = 23
            },
        ]
      + id         = (known after apply)
      + ingress    = [
          + {
              + action          = "allow"
              + cidr_block      = "0.0.0.0/0"
              + from_port       = 0
              + icmp_code       = null
              + icmp_type       = null
              + ipv6_cidr_block = ""
              + protocol        = "tcp"
              + rule_no         = 32766
              + to_port         = 0
            },
          + {
              + action          = "deny"
              + cidr_block      = "0.0.0.0/0"
              + from_port       = 23
              + icmp_code       = null
              + icmp_type       = null
              + ipv6_cidr_block = ""
              + protocol        = "tcp"
              + rule_no         = 110
              + to_port         = 23
            },
        ]
      + owner_id   = (known after apply)
      + subnet_ids = (known after apply)
      + tags       = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-NANCL"
          + "Product"     = "WEBAPP"
        }
      + vpc_id     = (known after apply)
    }

  # aws_route53_record.mail1-record will be created
  + resource "aws_route53_record" "mail1-record" {
      + allow_overwrite = (known after apply)
      + fqdn            = (known after apply)
      + id              = (known after apply)
      + name            = "newtech.academy"
      + records         = [
          + "1 aspmx.l.google.com.",
          + "10 aspmx2.googlemail.com.",
          + "10 aspmx3.googlemail.com.",
          + "5 alt1.aspmx.l.google.com.",
          + "5 alt2.aspmx.l.google.com.",
        ]
      + ttl             = 300
      + type            = "MX"
      + zone_id         = (known after apply)
    }

  # aws_route53_record.server1-record will be created
  + resource "aws_route53_record" "server1-record" {
      + allow_overwrite = (known after apply)
      + fqdn            = (known after apply)
      + id              = (known after apply)
      + name            = "server1.newtech.academy"
      + records         = [
          + "104.236.247.8",
        ]
      + ttl             = 300
      + type            = "A"
      + zone_id         = (known after apply)
    }

  # aws_route53_record.www-record will be created
  + resource "aws_route53_record" "www-record" {
      + allow_overwrite = (known after apply)
      + fqdn            = (known after apply)
      + id              = (known after apply)
      + name            = "www.newtech.academy"
      + records         = [
          + "104.236.247.8",
        ]
      + ttl             = 300
      + type            = "A"
      + zone_id         = (known after apply)
    }

  # aws_route53_zone.newtech-academy will be created
  + resource "aws_route53_zone" "newtech-academy" {
      + comment       = "Managed by Terraform"
      + force_destroy = false
      + id            = (known after apply)
      + name          = "newtech.academy"
      + name_servers  = (known after apply)
      + vpc_id        = (known after apply)
      + vpc_region    = (known after apply)
      + zone_id       = (known after apply)
    }

  # aws_route_table.PROJECT_PRIVATE_ROUTE will be created
  + resource "aws_route_table" "PROJECT_PRIVATE_ROUTE" {
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                = "0.0.0.0/0"
              + egress_only_gateway_id    = ""
              + gateway_id                = (known after apply)
              + instance_id               = ""
              + ipv6_cidr_block           = ""
              + nat_gateway_id            = ""
              + network_interface_id      = ""
              + transit_gateway_id        = ""
              + vpc_peering_connection_id = ""
            },
        ]
      + tags             = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-PRIVATE-RT"
          + "Product"     = "WEBAPP"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table.PROJECT_PUBLIC_ROUTE will be created
  + resource "aws_route_table" "PROJECT_PUBLIC_ROUTE" {
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                = "0.0.0.0/0"
              + egress_only_gateway_id    = ""
              + gateway_id                = (known after apply)
              + instance_id               = ""
              + ipv6_cidr_block           = ""
              + nat_gateway_id            = ""
              + network_interface_id      = ""
              + transit_gateway_id        = ""
              + vpc_peering_connection_id = ""
            },
        ]
      + tags             = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-PUBLIC-RT"
          + "Product"     = "WEBAPP"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.PRIVATE_ASSO will be created
  + resource "aws_route_table_association" "PRIVATE_ASSO" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.PUBLIC_ASSO will be created
  + resource "aws_route_table_association" "PUBLIC_ASSO" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.APP_ALB_SG will be created
  + resource "aws_security_group" "APP_ALB_SG" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = (known after apply)
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = []
              + description      = ""
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = (known after apply)
              + self             = false
              + to_port          = 443
            },
          + {
              + cidr_blocks      = []
              + description      = ""
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = (known after apply)
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "TALLER-DEVOPS-SRE-ALB-SG"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.APP_SG will be created
  + resource "aws_security_group" "APP_SG" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "10.12.0.0/24",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "10.12.0.0/24",
                ]
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "10.12.0.0/24",
                ]
              + description      = ""
              + from_port        = 3389
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 3389
            },
          + {
              + cidr_blocks      = [
                  + "10.12.0.0/24",
                ]
              + description      = ""
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "TALLER-DEVOPS-SRE-SG-APP"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-SG"
          + "Product"     = "WEBAPP"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.PROJECT_PRIVATE_SUBNET will be created
  + resource "aws_subnet" "PROJECT_PRIVATE_SUBNET" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-2b"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.12.0.128/25"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-SUBNET-AZ-B"
          + "Product"     = "WEBAPP"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.PROJECT_PUBLIC_SUBNET will be created
  + resource "aws_subnet" "PROJECT_PUBLIC_SUBNET" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "us-east-2a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "10.12.0.0/25"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = true
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-SUBNET-AZ-A"
          + "Product"     = "WEBAPP"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_vpc.PROJECT_VPC will be created
  + resource "aws_vpc" "PROJECT_VPC" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.12.0.0/24"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Environment" = "TALLER-DEVOPS-SRE"
          + "Name"        = "TALLER-DEVOPS-SRE-VPC"
          + "Product"     = "WEBAPP"
        }
    }

  # aws_vpc_endpoint.PROJECT_S3_ENDPOINT will be created
  + resource "aws_vpc_endpoint" "PROJECT_S3_ENDPOINT" {
      + cidr_blocks           = (known after apply)
      + dns_entry             = (known after apply)
      + id                    = (known after apply)
      + network_interface_ids = (known after apply)
      + owner_id              = (known after apply)
      + policy                = (known after apply)
      + prefix_list_id        = (known after apply)
      + private_dns_enabled   = false
      + requester_managed     = (known after apply)
      + route_table_ids       = (known after apply)
      + security_group_ids    = (known after apply)
      + service_name          = "com.amazonaws.us-east-2.s3"
      + state                 = (known after apply)
      + subnet_ids            = (known after apply)
      + vpc_endpoint_type     = "Gateway"
      + vpc_id                = (known after apply)
    }

Plan: 23 to add, 0 to change, 0 to destroy.

```

```
