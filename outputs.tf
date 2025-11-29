# VPC
output "vpc_name" {
  value = module.vpc.vpc_name
}

output "public_subnet" {
  value = module.vpc.public_subnet_self_link
}

output "private_subnet" {
  value = module.vpc.private_subnet_self_link
}

# NAT
output "nat_name" {
  value = module.nat.nat_name
}

# BASTION
output "bastion_name" {
  value = module.bastion.bastion_name
}

# SQL
output "sql_private_ip" {
  value = module.sql.private_ip
}

output "sql_instance" {
  value = module.sql.mysql_instance_name
}

# COMPUTE
output "instance_group" {
  value = module.compute.instance_group_name
}

# LOAD BALANCER
output "forwarding_rule" {
  value = module.lb.forwarding_rule
}
