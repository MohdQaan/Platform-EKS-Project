module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "dev-eks"
  kubernetes_version = "1.36"

  # Put the cluster in the network you built
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Lets kubectl on your laptop reach the cluster
  endpoint_public_access = true

  # Makes YOU (the IAM user running Terraform) a cluster admin
  enable_cluster_creator_admin_permissions = true

  # Core cluster components, kept up to date
  addons = {
    coredns    = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni    = { most_recent = true }
  }

  # The worker machines
  eks_managed_node_groups = {
    default = {
      instance_types = ["m7i-flex.large"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }
}
