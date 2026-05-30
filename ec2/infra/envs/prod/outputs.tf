outputs "instance_id" {
    value = module.app_server.instance_id
}

output "debug_info" {
    value = {
        region = data.aws_region.current.name
    }
}