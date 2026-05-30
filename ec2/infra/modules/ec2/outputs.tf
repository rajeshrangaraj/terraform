output "instance_id" {
    value = data.aws_ami.this.id 
}

output "aws_region" {
    value = data.aws_region.current.name
}

output "aws_caller_identity" {
    value = data.aws_caller_identity.current.id
}

output "aws_partition" {
    value = data.aws_partition.current.partition
}