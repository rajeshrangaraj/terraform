# output "instance_id" {
#     value = module.app_server.instance_id
# }

output "debug_info" {
  value = {
    region        = module.app_server.aws_region
    account_id    = module.app_server.aws_caller_identity
    aws_partition = module.app_server.aws_partition
    instance_id   = module.app_server.instance_id
  }
}

output "db_username" {
  description = "Database username"
  value       = module.app_server.db_username
  sensitive   = true
}

output "db_password" {
  description = "Database password"
  value       = module.app_server.db_password
  sensitive   = true
}