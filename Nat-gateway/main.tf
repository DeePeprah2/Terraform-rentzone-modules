# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet az1 
resource "aws_eip" "eip1" {
  vpc = true

  tags = {
    Name = "${var.project_name}-${var.environment}-eip1"
  }
}

// allocate elastic ip. this eip will be used for the nat-gateway in the public subnet az2
resource "aws_eip" "eip2" {
  vpc = true

  tags = {
    Name = "${var.project_name}-${var.environment}-eip2"
  }
}

// create nat gateway in public subnet az1
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = aws_eip.eip1.id 
  subnet_id     = var.public_subnet_az1.id

  tags = {
    Name = "${var.project_name}-${var.environment}-ng-az1"
  }

  // it is recommended to add internet gatway to enables communication
  // between private instances in your VPC and the internet
  depends_on = [var.internet_gateway]
}

// create nat gateway in public subnet az2
resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = aws_eip.eip2.id
  subnet_id     = var.public_subnet_az2.id 

  tags = {
    Name = "${var.project_name}-${var.environment}-ng-az2"
  }

  // it is recommended to add internet gatway to enables communication
  // between private instances in your VPC and the internet
  depends_on = [var.internet_gateway]
}


// create private route table az1 and add route through nat gateway az1
resource "aws_route_table" "private_route_table_az1" {
  vpc_id = var.elearning-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-private-rt-az1"
  }
}

// associate private app subnet az1 with private route table az1
resource "aws_route_table_association" "private_app_subnet_az1_rt_az1_association" {
  subnet_id      =  var.private_app_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1.id
}

// associate private data subnet az1 with private route table az1
resource "aws_route_table_association" "private_data_subnet_az1_rt_az1_association" {
  subnet_id      = var.private_data_subnet_az1.id
  route_table_id = aws_route_table.private_route_table_az1
}



// create private route table az2 and add route through nat gateway az2
resource "aws_route_table" "private_route_table_az2" {
  vpc_id = var.elearning-vpc.id 

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-private-rt-az2"
  }
}

// associate private app subnet az2 with private route table az2
resource "aws_route_table_association" "private_app_subnet_az2_rt_az2_association" {
  subnet_id      = var.private_app_subnet_az2_id
  route_table_id = aws_route_table.private_route_table_az2.id
}

// associate private data subnet az2 with private route table az2
resource "aws_route_table_association" "private_data_subnet_az2_rt_az2_association" {
  subnet_id      = var.private_data_subnet_az2_id
  route_table_id = aws_route_table.private_route_table_az2.id
}
