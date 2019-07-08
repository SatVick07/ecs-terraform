variable "alb_name" {
  description = "Name of ALB"
  default     = "default"
}
variable "project_name_prefix" {
  
}

variable "alb_internet_accessbility" {
  description = "Internet accessibility to the application load balancer "
  default     = "false"
}

variable "deletion_protection" {
  description = "Enable deletion protection on the ALB, default is false"
  default     = "false"
}

variable "alb_load_balancer_type" {
  description = "Type of load balancer to be created, possible values are application and network"
  default     = "application"
}

variable "vpc_id" {
  description = "VPC ID"
}
variable "alb_sg_id" {
  description = "ALB Securuity Group"
}

variable "custom-subnets" {
  default = []
}

variable "source_cidr" {
  description = "Source CIDR Block for ALB"
}

variable "common_tags" {
  description = "Custom Tags "
  default     = {}
}


# variable "ssl_policy" {
#     description = "SSL Policy"
#     default = "ELBSecurityPolicy-2015-05"
# }

# variable "certificate_arn" {
#     description = "SSL Certificate"
#     default = ""
# }
