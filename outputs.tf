output "bastion_ip_addr" {
  value = aws_instance.bastion.public_ip
}

output "webserver_ip_addr" {
  value = aws_instance.web_server.public_ip
}