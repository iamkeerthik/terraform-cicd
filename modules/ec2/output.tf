output "security_group_ids" {
  value = { for name, sg in aws_security_group.this : name => sg.id }
}

output "instance_ids" {
  value = { for name, instance in aws_instance.this : name => instance.id }
}

output "instance_public_ips" {
  value = { for name, instance in aws_instance.this : name => instance.public_ip }
}