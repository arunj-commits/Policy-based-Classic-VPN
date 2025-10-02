# Create the custom VPC network.
resource "google_compute_network" "custom_vpc" {
  name                    = var.network_name
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

# Create subnets using the subnets variable.
resource "google_compute_subnetwork" "custom_subnets" {
  for_each = { for subnet in var.subnets : subnet.subnet_name => subnet }

  name                     = each.value.subnet_name
  ip_cidr_range            = each.value.subnet_ip
  region                   = each.value.subnet_region
  network                  = google_compute_network.custom_vpc.self_link
  private_ip_google_access = lookup(each.value, "private_access", false)
}
