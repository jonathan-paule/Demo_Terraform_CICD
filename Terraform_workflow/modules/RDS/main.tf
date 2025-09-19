resource "aws_db_instance" "default" {
 allocated_storage    = var.allocated_storage 
 storage_type         = var.storage_type
 db_name              = var.db_name
 engine               = var.engine
 engine_version       = var.engine_version
 instance_class       = var.instance_class
 identifier           = var.identifier
 username             = var.username
 password             = var.db_password
 parameter_group_name = var.parameter_group_name
 multi_az             = var.multi_az 
 skip_final_snapshot  = var.skip_final_snapshot
 backup_retention_period =var.backup_retention_period 


}
