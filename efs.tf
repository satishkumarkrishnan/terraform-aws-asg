module "vpc" {
  source ="git@github.com:satishkumarkrishnan/terraform-aws-vpc.git?ref=main"
}

module "kms" {
  source="git@github.com:satishkumarkrishnan/Terraform-KMS.git?ref=main"   
}

#Adding lifecycle Policy
resource "aws_efs_file_system" "tokyo_efs" {
 creation_token  = "tokyo_token"
  encrypted      = true
  kms_key_id     = module.kms.kms_arn 
  depends_on     = [module.vpc]  

  lifecycle_policy {
    transition_to_ia = "AFTER_7_DAYS"    
  }
  tags = {
    Name = "Tokyo-EFS"
  }
}

#EFS Mount Target in FE SG
resource "aws_efs_mount_target" "tokyo_EFS_mount_fe" {
  file_system_id  = aws_efs_file_system.tokyo_efs.id
  subnet_id       = module.vpc.vpc_fe_subnet.id
  security_groups = [module.vpc.vpc_fe_sg]  
}

#EFS Mount Target in BE SG
resource "aws_efs_mount_target" "tokyo_EFS_mount_be" {
  file_system_id  = aws_efs_file_system.tokyo_efs.id
  subnet_id       = module.vpc.vpc_be_subnet.id
  security_groups = [module.vpc.vpc_be_sg]  
}

#EFS Access Point
resource "aws_efs_access_point" "tokyo_EFS_accesspoint" {
  file_system_id = aws_efs_file_system.tokyo_efs.id
  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = 0777
    }
  }
  tags = {
    Name = "Tokyo-EFS-Accesspoint"
  }
}
/*resource "aws_efs_file_system_policy" "policy" {
  file_system_id = aws_efs_file_system.tokyo_efs.id
  policy         = data.aws_iam_policy_document.policy.json
  }*/