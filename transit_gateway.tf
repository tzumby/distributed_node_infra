locals {
    enis = { for val in aws_network_interface.eni : "${val.id}" => "224.0.0.10" }
}

#variable "multicast_group_members" {
#    default = { for val in aws_network_interface.eni : "${val.id}" => "224.0.0.10" }
#}

module "txgw-multicast" {
  source = "git::https://github.com/fstuck37/terraform-aws-txgw-multicast.git"
  region                          = "us-east-1"
  auto_accept_shared_attachments  = "disable"
  description                     = "Multicast TXGW"
  vpc_id                          = "${aws_vpc.main.id}"
  subnet_ids                      = ["${aws_subnet.private.id}"]
  auto_accept_shared_associations = "disable"
  static_sources_support          = "disable"
  multicast_group_members         = local.enis
}
