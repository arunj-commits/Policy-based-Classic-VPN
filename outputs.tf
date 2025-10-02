
output "vpn_gateway_ips" {
  description = "The public IP address of the GCP Classic VPN gateways for each connection."
  value       = { for k, v in module.classic-vpn : k => v.gcp_vpn_ip }
}