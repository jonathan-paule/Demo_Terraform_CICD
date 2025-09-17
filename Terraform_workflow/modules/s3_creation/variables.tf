variable "bucket_name" {

type = string
description = "bucket name"  
}

variable "versioning" {
    type = bool
    description = "enable bucket versioning"
    default = false

  
}
