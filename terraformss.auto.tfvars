project_id = "*******" replace it with you project id

vpn_tunnels = {
  "myfirstproject" = {
    vpn_network_name    = "my-dev-vpc"
    peer_ip_address = "x.x.x.x" replace it with VPN peer IP address
    gcp_region      = "us-east1"
    shared_secret   = "OfficeAStrongSecret"
    gcp_subnets     = ["10.2.1.0/24"]
    remote_subnets  = ["192.168.1.0/24"]
  },
}

