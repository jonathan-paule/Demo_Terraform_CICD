variable "allocated_storage" {
    description = "value"
    type = number
    default = 5
}

variable "storage_type" {
    description = "value"
    type = string
    default = "gp2"
}

variable "db_name" {
    description = "value"
    type = string
}

variable "engine" {
    description = "value"
    type = string
    default = "mysql"
  
}

variable "engine_version" {
    description = "value"
    type = string
    default = "8.0"
  
}

variable "instance_class" {
    description = "value"
    type = string
    default = "db.t3.micro"
}

variable "username" {
    description = "value"
    type = string

}

variable "db_password" {
    description = "value"
    type = string
    sensitive = true
}

variable "parameter_group_name" {
    description = "value"
    type = string
    default = "default.mysql8.0"
}

variable "multi_az" {
    description = "value"
    type = bool
    default = false
}

variable "skip_final_snapshot" {

    description = "value"
    type = bool
    default = true
}

variable "backup_retention_period" {
  
    description = "value"
    type = number
    default = 0
}

variable "identifier" {
  
    description = "value"
    type = string

}



