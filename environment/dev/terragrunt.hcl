terraform {
  source = "../../modules/ec2"
}

inputs = {
  region         = "ap-south-1"
  aws_profile    = "keerthik"
  vpc_id         = "vpc-0e48b2d3d483444ec"
  ami_id         = "ami-0522ab6e1ddcc7055"
  instance_type  = "t3a.small"
  key_name       = "k8s"
  
  # Security Groups
  security_groups = [
    {
      name        = "master-sg"
      description = "k8s security group"
      ingress_rules = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          sg_ids      = []
        },
        {
          from_port   = 6443
          to_port     = 6443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          sg_ids      = []
        }
      ]
      egress_rules = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    },
    {
      name        = "worker-sg"
      description = "k8s worker security group"
      ingress_rules = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          sg_ids      = []
        }
      ]
      egress_rules = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]

  # EC2 Instances
  instances = [
    {
      name              = "master"
      security_groups   = ["master-sg"]
      subnet_id         = "subnet-0e750fa1ceed414c4"
      availability_zone = "ap-south-1a"
    },
    {
      name              = "worker"
      security_groups   = ["worker-sg"]
      subnet_id         = "subnet-015ae33f200b9057f"
      availability_zone = "ap-south-1b"
    }
  ]
}