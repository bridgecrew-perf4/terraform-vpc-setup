resource "aws_security_group" "internal-sg" {
  name        = "allow-internal-traffic"
  description = "allow-internal-traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = ""
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  tags = {
    Name = "allow_vpc"
    build = var.build
  }
}