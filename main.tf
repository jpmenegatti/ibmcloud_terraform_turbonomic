resource "ibm_is_vpc" "turbonomic-vpc" {
  name = "dal-${var.client_name}-vpc"
  resource_group = "7091499c38984a33a077f69c422dfd1a"
  default_network_acl_name = "dal-${var.client_name}-vpc-default-acl"
  default_security_group_name = "dal-${var.client_name}-vpc-default-sg"
  default_routing_table_name = "dal-${var.client_name}-route"
}

resource "ibm_is_security_group" "turbonomic-sg" {
  name = "dal-${var.client_name}-vpc-turbonomic-sg"
  vpc  = ibm_is_vpc.turbonomic-vpc.id
  resource_group = "7091499c38984a33a077f69c422dfd1a"
}

resource "ibm_is_security_group_rule" "turbonomic-sg-tcp-22" {
  group     = ibm_is_security_group.turbonomic-sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "turbonomic-sg-tcp-443" {
  group     = ibm_is_security_group.turbonomic-sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 443
    port_max = 443
  }
}

resource "ibm_is_security_group_rule" "turbonomic-sg-egress" {
  group     = ibm_is_security_group.turbonomic-sg.id
  direction = "egress"
  remote    = "0.0.0.0/0"
  all {
  }
}

resource "ibm_is_subnet" "turbonomic-subnet" {
  name            = "turbonomic-subnet"
  vpc             = ibm_is_vpc.turbonomic-vpc.id
  zone            = "us-south-1"
  ipv4_cidr_block = "10.240.0.0/24"
  resource_group = "7091499c38984a33a077f69c422dfd1a"
}

resource "ibm_is_instance" "turbonomic" {
  name    = "${var.client_name}-turbonomic-instance"
  image   = var.turbonomic_image_id
  profile = "bx2-16x64"
  metadata_service_enabled  = false
  
  boot_volume {
    size = "210"
  }
  
  primary_network_interface {
    name = "eth0"
    subnet = ibm_is_subnet.turbonomic-subnet.id
	primary_ipv4_address = "10.240.0.6"
    allow_ip_spoofing = true
	security_groups = [ibm_is_security_group.turbonomic-sg.id]
  }

  vpc  = ibm_is_vpc.turbonomic-vpc.id
  zone = "us-south-1"
  keys = ["r006-1d3b8fca-3eda-4a63-9f3f-7a4dad8057dd"]
  resource_group = "7091499c38984a33a077f69c422dfd1a"

  //User can configure timeouts
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "ibm_is_floating_ip" "turbonomic-floating-ip" {
  name   = "turbonomic-floating-ip"
  target = ibm_is_instance.turbonomic.primary_network_interface[0].id
  resource_group = "7091499c38984a33a077f69c422dfd1a"
}

//resource "ibm_is_instance_volume_attachment" "turbonomic-data" {
//  instance = ibm_is_instance.turbonomic.id

//  name                               = "turbonomic-data"
//  profile                            = "general-purpose"
//  capacity                           = "20"
//  delete_volume_on_attachment_delete = true
//  delete_volume_on_instance_delete   = true
//  volume_name                        = "turbonomic-data"
  
//  //User can configure timeouts
//  timeouts {
//    create = "15m"
//    update = "15m"
//    delete = "15m"
//  }
//}