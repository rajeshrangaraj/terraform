
# -- Data Source ------------------------------
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}
data "aws_secretsmanager_secret" "db_credentials" {
  name = "prod/ec2/db-credentials"
}


data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = data.aws_secretsmanager_secret.db_credentials.id
}

locals {
  db_credentials = jsondecode(
    data.aws_secretsmanager_secret_version.db_credentials.secret_string
  )
}


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
  ami                  = data.aws_ami.this.id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
    #!/bin/bash
    echo "DB_USERNAME=${local.db_credentials["username"]}"
    echo "DB_PASSWORD=${local.db_credentials["password"]}"
  EOF

  tags = {
    Name      = var.name
    Region    = data.aws_region.current.name
    AccountID = data.aws_caller_identity.current.id
  }
}

resource "aws_db_instance" "this" {
  identifier        = "app-database"
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "appdb"
  username = local.db_credentials["username"]
  password = local.db_credentials["password"]

  skip_final_snapshot = true

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}