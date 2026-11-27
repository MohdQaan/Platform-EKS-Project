module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "dev-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.0.0/20", "10.0.16.0/20"]
  public_subnets  = ["10.0.200.0/24", "10.0.201.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true # ONE reception desk, cheaper for learning

  enable_dns_hostnames = true
  enable_dns_support   = true

  # Tells Kubernetes which subnets to use for which kind of load balancer
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}
