
# -- Data Source ------------------------------
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}

# ── Fetch correct AMI ──────────────────────────────────────
data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

#-- EC2  -----------------------------------
resource "aws_instance" "this" {
    ami           = data.aws_ami.this.id
    instance_type = var.instance_type

    tags = {
        Name = var.name
        Region = data.aws_region.current.name
        AccountID = data.aws_caller_identity.current.id
    }
}