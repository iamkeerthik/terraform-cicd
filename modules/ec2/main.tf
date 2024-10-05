provider "aws" {
  region  = var.region
  profile = var.aws_profile
}


resource "aws_security_group" "this" {
  for_each = { for sg in var.security_groups : sg.name => sg }

  name        = each.value.name
  description = each.value.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = each.value.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      security_groups = ingress.value.sg_ids
    }
  }

  dynamic "egress" {
    for_each = each.value.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

resource "aws_instance" "this" {
  for_each = { for instance in var.instances : instance.name => instance }

  ami                    = var.ami_id
  instance_type         = var.instance_type
  key_name              = var.key_name
  subnet_id             = each.value.subnet_id
  availability_zone     = each.value.availability_zone
  vpc_security_group_ids = [for sg_name in each.value.security_groups : aws_security_group.this[sg_name].id]

  tags = {
    Name = each.value.name
  }
}

