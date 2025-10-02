output "gcp_vpn_ip" {
  description = "The external IP address of the GCP VPN gateway."
  value       = google_compute_address.vpn_ip.address
}