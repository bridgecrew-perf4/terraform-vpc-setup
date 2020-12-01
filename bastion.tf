# create bastion
resource "aws_instance" "bastion" {
  ami           = var.ec2_ami
  instance_type = "t2.small"
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id = aws_subnet.bastion.id
  key_name = aws_key_pair.bastion_key_pair.key_name
  associate_public_ip_address=true
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  tags = {
    Name = "Bastion"
    build = var.build
  }

  user_data = file("bastion_userdata.txt")

}

resource "aws_security_group" "bastion_sg" {
  name        = "allow_SSH"
  description = "Allow SSH"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "bastion-security-group"
    build = var.build
  }
}
