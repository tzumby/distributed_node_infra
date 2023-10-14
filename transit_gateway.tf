variable "multicast_group_members" {
  default = {
    eni-048adeb21130010b8  = "224.0.0.10"
    eni-0b6e0b540348bbc53  = "224.0.0.10"
    #eni-01fa27c13406241bd = "224.0.0.10"
    #eni-099d183b14d6e9273 = "224.0.0.10"
  }
}

module "txgw-multicast" {
  source = "git::https://github.com/fstuck37/terraform-aws-txgw-multicast.git"
  region                          = "us-east-1"
  auto_accept_shared_attachments  = "disable"
  description                     = "Multicast TXGW"
  vpc_id                          = "${aws_vpc.main.id}"
  subnet_ids                      = ["${aws_subnet.private.id}"]
  auto_accept_shared_associations = "disable"
  static_sources_support          = "disable"
  multicast_group_members         = var.multicast_group_members
}
