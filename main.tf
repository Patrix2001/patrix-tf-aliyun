locals {
  names = [
    "balancetrans",
    "ifclimitcenter",
    "timeoutcenter",
    "isdchecklite",
    "ifcriskmatrix",
    "ifccfpcenter",
    "ifccfmng",
    "ifcprodmng",
    "ifcprocess",
    "ifccomparacenter",
    "ifcbuservice",
    "ifcaccenter",
    "ifcriskcentermng",
    "ifcrecon",
    "ifcinnertrans",
    "approdcenter",
    "ifcdebittrans",
    "ifcamlmatrix",
    "ifcamlcloud",
    "ifctscenter",
    "ifcdart",
    "cardissuancecenter",
    "ifcfeecharge",
    "datacenter",
    "apintegrationprod",
    "bizcenter",
    "apmobileappng",
    "rppconnector",
    "msgcenter",
    "merchantcenter",
    "lmacis",
    "fincenter",
    "ifcdatabus",
    "ifcvouchercore",
    "ifcriskcloud",
    "apacquirecenter",
    "ifcassetflux",
    "ifcgotone",
    "ifccustmng",
    "ifccustcenter",
    "ifccardcenter",
    "ifcsupergw",
    "apmobilewallet",
    "ifcfluxnet",
    "apbizprod",
    "apcashier",
    "ifcfluxbatch",
    "apfundprod",
    "apfundcenter",
    "appaymentmng",
    "ifcfluxworks",
    "ifcfluxconf",
    "appromotion",
    "appromocore",
    "apmobileprod",
    "apsettlement",
    "appromomng"
  ]
  types = [
    "ecs.t6-c1m1.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large",
    "ecs.t6-c1m2.large"
  ]

}

data "alicloud_vswitches" "default" {
  vpc_id                     = "vpc-8psvygid5d9s946rhsb24"
  zone_id                    = "ap-southeast-3a"
}

resource "alicloud_instance" "instance" {
  count                      = length(local.names)
  availability_zone          = "ap-southeast-3a"
  security_groups            = ["sg-8ps6bxs3pjtaysyphgfg"]
  vpc_id                     = "vpc-8psvygid5d9s946rhsb24"
  vswitch_id                 = data.alicloud_vswitches.default.vswitches.0.id 
  image_id                   = "m-8pscspjr75ey9xvrga4s"

  instance_type              = local.types[count.index]
  instance_name              = "dev3-${local.names[count.index]}-A-1"
  system_disk_name           = "dev3-${local.names[count.index]}-disk"
  host_name                  = "dev3-${local.names[count.index]}-A-1"

  system_disk_size           = 100
  instance_charge_type       = "PrePaid"
  renewal_status             = "AutoRenewal"
  period                     = 1
  resource_group_id          = "rg-aek3v75abaspmzi"

  volume_tags = {
      "costcenter" = "cto",
      "owner"  = "devops",
      "environment" = "dev3",
      "appname" = local.names[count.index]
  }
  tags = {
      "costcenter" = "cto",
      "owner"  = "devops",
      "environment" = "dev3",
      "appname" = local.names[count.index]
  }
}


output "ecs" {
  value = alicloud_instance.instance.*.id
}
