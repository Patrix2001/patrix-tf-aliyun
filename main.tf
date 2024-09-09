locals {
 ports = ["80/80", "443/443", "22/22", "3389/3389"]
}



resource "alicloud_vpc" "default" {
    vpc_name    = "vpc-${var.name}"
    cidr_block  = "192.168.0.0/16"
}

data "alicloud_zones" "default" {

}

resource "alicloud_vswitch" "default" {
  vpc_id        = alicloud_vpc.default.id
  cidr_block    = "192.168.0.0/24"
  zone_id       = data.alicloud_zones.default.zones.1.id
  vswitch_name  = "vsw-${var.name}-a"
}

resource "alicloud_security_group" "default" {
  name          = "sg-${var.name}"
  vpc_id        = alicloud_vpc.default.id
}

resource "alicloud_security_group_rule" "allow_http_tcp" {
  count             = length(local.ports)
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = local.ports[count.index]
  priority          = 1
  security_group_id = alicloud_security_group.default.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_eip" "default" {
  bandwidth            = "10"
  internet_charge_type = "PayByTraffic"
}

output "vpc" {
  value = alicloud_vpc.default.id
}
