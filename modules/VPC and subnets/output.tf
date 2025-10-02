# Output the VPC network's self-link.
output "network_self_link" {
  description = "The URI of the VPC network."
  value       = google_compute_network.custom_vpc.self_link
}

# Output the created subnets.
output "subnets" {
  description = "The list of subnets created."
  value       = google_compute_subnetwork.custom_subnets
}