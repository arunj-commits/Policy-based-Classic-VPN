variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}


variable "vpn_tunnels" {
  description = "A map of VPN tunnel configurations."
  type = map(object({
    vpn_network_name    = string
    peer_ip_address = string
    gcp_region      = string
    shared_secret   = string
    gcp_subnets     = list(string)
    remote_subnets  = list(string)
  }))
}