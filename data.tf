data "aws_ami" "ami" {
  owners = ["amazon"]
  name_regex = "al2023-ami-2023.1.20230912.0-kernel-6.1-x86_64"
}

data "aws_availability_zones" "available" {
  state = "available"
}

# EFS Policy JSON
/*data "aws_iam_policy_document" "policy" {
  statement {
    sid    = "Allow ssl to mount"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "elasticfilesystem:ClientRootAccess",
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite"      
    ]

    resources = [aws_efs_file_system.tokyo_efs.arn]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["true"]
    }
  }
}*/
data "template_file" "test" {
  template = "${file("${path.module}/efs_mount.sh")}" 
  vars = {
    EC2_REGION = "ap-northeast-1"
    EFS_FILE_SYSTEM_NAME = "${aws_efs_file_system.tokyo_efs.dns_name}"
    DIR_TGT = "/tmp/efs"
    EFS_FILE_SYSTEM_NAME = "${efs_hostname}"
    DIR_SRC = "${EFS_FILE_SYSTEM_ID}.efs.${EC2_REGION}.amazonaws.com"
    
  }
}
