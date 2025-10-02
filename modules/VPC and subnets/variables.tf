# Define the variables for the single VPC module.
variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network."
  type        = string
}

variable "subnets" {
  description = "A list of subnets to create within the VPC."
  type = list(object({
    subnet_name    = string
    subnet_ip      = string
    subnet_region  = string
    private_access = optional(bool, false)
  }))
}