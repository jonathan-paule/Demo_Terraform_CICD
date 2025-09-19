variable "function_name" {
    description = "name of lambda funtion"
     type = string
}

variable "handler" {
    description = "lambda handler"
    type = string
  
}

variable "runtime" {
    description = "lambda runtime"
    type = string
  
}

variable "filename" {
    description = "lambda filename(zip file)"
    type = string
  
}

variable "memory_size" {
    description = "amount of memory in MB for in lambda function"
    type = number
    default = 128
  
}

variable "timeout" {
    description = "lambda timout in seconds"
    type = number
    default = 10
  
}
variable "route_key" {
    description = "API gateway route key (like GET /path)"
    type = string
  
}
