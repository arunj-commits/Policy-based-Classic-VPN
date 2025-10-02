variable "name" {
  description = "A unique name for the VPN connection."
  type        = string
}

variable "region" {
  description = "The GCP region to create the VPN gateway in."
  type        = string
}

variable "network" {
  description = "The self-link of the VPC network to attach the VPN gateway to."
  type        = string
}

variable "peer_ip_address" {
  description = "The public IP address of the on-premises or peer VPN gateway."
  type        = string
}

variable "shared_secret" {
  description = "The pre-shared key for the VPN tunnel. It should be cryptographically strong."
  type        = string
  sensitive   = true
}

variable "gcp_subnets" {
  description = "A list of CIDR ranges of the GCP subnets that will use the VPN tunnel."
  type        = list(string)
}

variable "remote_subnets" {
  description = "A list of CIDR ranges for the remote/on-premises subnets."
  type        = list(string)
}

variable "ike_version" {
  description = "The IKE version to use for the tunnel (1 or 2)."
  type        = number
  default     = 2
}