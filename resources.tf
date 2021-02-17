
# Define webserver inside the public subnet
resource "aws_instance" "wb" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  key_name                    = "wordpress"
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.sgweb.id]
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = file("userdata.sh")
  # network_interface {
  #   device_index         = 0
  #   network_interface_id = aws_network_interface.web-nic.id
  # }

  tags = {
    Name = "webserver"
  }
}

# Define database inside the private subnet
# resource "aws_instance" "db" {
#   ami                    = var.ami
#   instance_type          = "t1.micro"
#   key_name               = "wordpress"
#   subnet_id              = aws_subnet.private-subnet.id
#   vpc_security_group_ids = [aws_security_group.sgdb.id]
#   source_dest_check      = false
#   network_interface {
#     device_index         = 0
#     network_interface_id = aws_network_interface.db-nic.id
#   }
#
#   tags = {
#     Name = "database"
#   }
# }
data "template_file" "phpconfig" {
  template = file("conf.wp-config.php")

  vars = {
    db_port = aws_db_instance.mysql.port
    db_host = aws_db_instance.mysql.address
    db_user = var.username
    db_pass = var.password
    db_name = var.dbname
  }
}
resource "aws_db_instance" "mysql" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = var.dbname
  username               = var.username
  password               = var.password
  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.sgdb.id]
  #db_subnet_group_name   = aws_db_subnet_group.mysql1.name
  skip_final_snapshot = true
}
