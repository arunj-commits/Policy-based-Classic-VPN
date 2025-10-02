# Reserve a static IP address for the VPN gateway
resource "google_compute_address" "vpn_ip" {
  name   = "classic-vpn-${var.name}"
  region = var.region
}

# Create the Classic VPN gateway
resource "google_compute_vpn_gateway" "classic_gateway" {
  name    = "classic-vpn-gateway-${var.name}"
  network = var.network
  region  = var.region
}


# Create static routes to direct traffic for the remote subnets through the tunnel
resource "google_compute_route" "remote_routes" {
  for_each             = toset(var.remote_subnets)
  name                 = "to-peer-${replace(each.key, "/\\.|\\//", "-")}-${var.name}"
  dest_range           = each.key
  next_hop_vpn_tunnel  = google_compute_vpn_tunnel.policy_based_tunnel.id
  network              = var.network
  priority             = 1000
}


# Add the three required forwarding rules
# 1. ESP protocol for the encrypted traffic
resource "google_compute_forwarding_rule" "fr_esp" {
  name                  = "fr-${var.name}-esp"
  region                = var.region
  ip_protocol           = "ESP"
  ip_address            = google_compute_address.vpn_ip.address
  target                = google_compute_vpn_gateway.classic_gateway.id
  load_balancing_scheme = "EXTERNAL"
}

# 2. UDP 500 for the IKE negotiation
resource "google_compute_forwarding_rule" "fr_udp500" {
  name                  = "fr-${var.name}-udp500"
  region                = var.region
  ip_protocol           = "UDP"
  port_range            = "500"
  ip_address            = google_compute_address.vpn_ip.address
  target                = google_compute_vpn_gateway.classic_gateway.id
  load_balancing_scheme = "EXTERNAL"
}

# 3. UDP 4500 for NAT-T traversal
resource "google_compute_forwarding_rule" "fr_udp4500" {
  name                  = "fr-${var.name}-udp4500"
  region                = var.region
  ip_protocol           = "UDP"
  port_range            = "4500"
  ip_address            = google_compute_address.vpn_ip.address
  target                = google_compute_vpn_gateway.classic_gateway.id
  load_balancing_scheme = "EXTERNAL"
}

# Create the VPN tunnel
resource "google_compute_vpn_tunnel" "policy_based_tunnel" {
  name                      = "policy-based-tunnel-${var.name}"
  region                    = var.region
  ike_version               = var.ike_version
  shared_secret             = var.shared_secret
  target_vpn_gateway        = google_compute_vpn_gateway.classic_gateway.id
  peer_ip                    = var.peer_ip_address
  local_traffic_selector    = var.gcp_subnets
  remote_traffic_selector   = var.remote_subnets
   depends_on = [
    google_compute_forwarding_rule.fr_esp,
    google_compute_forwarding_rule.fr_udp500,
    google_compute_forwarding_rule.fr_udp4500,
 ]
}
