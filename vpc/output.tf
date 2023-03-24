// export output region 
output "region" {
  value = var.region
}

// export environment
output "environment" {
  value = var.environment
}

// export project name
output "project_name" {
  value = var.project_name
}

 // export vpc output
output "vpc_id" {
  value = aws_vpc.elearning-vpc.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
}

// export the public subnet az2 id
output "public_subnet_az2_id" {
  value = aws_subnet.public_subnet_az2.id
}

// export the private app subnet az1 id
output "private_app_subnet_az1_id" {
  value = aws_subnet.private_app_subnet_az1.id
}

// export the private app subnet az2 id
output "private_app_subnet_az2_id" {
  value = aws_subnet.private_app_subnet_az2.id
}

// export the private data subnet az1 id
output "private_data_subnet_az1_id" {
  value = aws_subnet.private_data_subnet_az1.id
}

// export the private data subnet az2 id
output "private_data_subnet_az2_id" {
  value = aws_subnet.private_data_subnet_az2.id
}

// export the first availability zone
output "availability_zone_1" {
  value = data.aws_availability_zones.available_zones.names[0]
}

// export the second availability zone
output "availability_zone_2" {
  value = data.aws_availability_zones.available_zones.names[1]
}