# terraform-aws-taller

Objetivo: demostrar de forma práctica el conocimiento de automatización y configuración de infraestructura.
Herramientas a evaluar:
* Packer
* Ansible
* Terraform
* Terragrunt(opcional)
Utilizando una cuenta gratuita de AWS realizar la automatización del siguiente ejercicio
 Utilizando la VPC y redes por defecto de la cuenta realizar los scripts de automatización para los siguientes componentes:
* Application Load Balancer
* AMI (optional encryption)
* RDS (PostgreSQL)
* R53 alias
* R53 Hosted Zone
* EFS (optional)
 
Detalle : 
_______________
* VPC que va a contener 2 SUBNETS
* Subnets
* Security Groups > para restringir el acceso a los recursos
* Network ACL > para restringir el acceso a nuestra red
* Internet gateway > para el acceso a internet
+ Nat Gateway > para tener acceso a internet sin necesidad de tener un ip publico 
* Elastic IP > para localizar nuestra instancia desde internet
* VPC EndPoints > para acceder a los servicios www directamente 
* Availability Zones >  dos distintas para poder tener acceso a recursos de hardware separado.
* Route Tables > son los que van a definir la direccion de los paquetes cuando llegan a nuestra red.

