provider "google" {
  project = "*****" # Replace with your GCP Project ID
  region  = "us-east1"        # Specify your desired default region
  credentials = file("*****") Replace with you service account key
  zone    = "us-east1-c"      # Specify your desired default zone (optional)
}

module "classic-vpn" {
  source = "./modules/classic-vpn"
  for_each = var.vpn_tunnels

  name            = each.key
  network         = each.value.vpn_network_name
  peer_ip_address = each.value.peer_ip_address
  region          = each.value.gcp_region
  shared_secret   = each.value.shared_secret
  gcp_subnets     = each.value.gcp_subnets
  remote_subnets  = each.value.remote_subnets
}
