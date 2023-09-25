provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "cluster-eks-lf"
  cluster_version = "1.27"

  vpc_id                          = data.aws_vpc.default.id
  subnet_ids                      = [for subnet in data.aws_subnet.public_subnet : subnet.id]
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  cluster_addons = {
    coredns = {
        most_recent = true
      //resolve_conflict = "OVERWRITE"
    }
    kube-proxy = {
        most_recent = true
      //resolve_conflict = "OVERWRITE"
    }
    vpc-cni = {
        most_recent = true
      //resolve_conflict = "OVERWRITE"
    }
  }

  manage_aws_auth_configmap = true

  eks_managed_node_groups = {
    node-group = {
      desired_size = 1
      min_size     = 1
      max_size     = 5
      instance_types = ["t2.micro"]
      disk_size = 20
      
    }
  }

tags = {
  Terraform = true
  Environment = "dev"
}

}