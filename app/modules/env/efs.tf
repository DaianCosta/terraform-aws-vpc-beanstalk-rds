##################################################
## AWS Elastic File System
##################################################
resource "aws_efs_file_system" "file_storage" {
  creation_token = format("%s-%s", lower(var.env_name), lower(var.application_name))
  
  tags = {
    Name = format("%s-%s", lower(var.env_name), lower(var.application_name))
  }

}

resource "aws_efs_mount_target" "file_storage_target" {
  for_each = toset(var.ec2_subnets)
  file_system_id  = "${aws_efs_file_system.file_storage.id}"
  subnet_id       = each.value
  security_groups = [aws_security_group.env_sg.id]
}