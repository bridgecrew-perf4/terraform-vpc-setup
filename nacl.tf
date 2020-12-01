resource "aws_network_acl" "nacl-public" {
 vpc_id = aws_vpc.vpc.id
  tags = {
    Name: "web-nacl"
    build: var.build
   }
  egress = [
              {
                "action": "allow",
                "cidr_block": var.vpc_cidr,
                "from_port": 0,
                "icmp_code": 0,
                "icmp_type": 0,
                "ipv6_cidr_block": "",
                "protocol": "-1",
                "rule_no": 8000,
                "to_port": 0
              },
              {
                "action": "allow",
                "cidr_block": "0.0.0.0/0",
                "from_port": 443,
                "icmp_code": 0,
                "icmp_type": 0,
                "ipv6_cidr_block": "",
                "protocol": "6",
                "rule_no": 200,
                "to_port": 443
              },
              {
                "action": "allow",
                "cidr_block": "0.0.0.0/0",
                "from_port": 80,
                "icmp_code": 0,
                "icmp_type": 0,
                "ipv6_cidr_block": "",
                "protocol": "6",
                "rule_no": 100,
                "to_port": 80
              },
              # allow ephemeral ports
              {
              "action": "allow",
              "cidr_block": "0.0.0.0/0",
              "from_port": 1025,
              "icmp_code": 0,
              "icmp_type": 0,
              "ipv6_cidr_block": "",
              "protocol": "tcp",
              "rule_no": 9000,
              "to_port": 65535
              },
              {
              "action": "allow",
              "cidr_block": "0.0.0.0/0",
              "from_port": 1025,
              "icmp_code": 0,
              "icmp_type": 0,
              "ipv6_cidr_block": "",
              "protocol": "udp",
              "rule_no": 9100,
              "to_port": 65535
              }
            ]
  ingress = [
              {
                "action": "allow",
                "cidr_block": var.vpc_cidr,
                "from_port": 0,
                "icmp_code": 0,
                "icmp_type": 0,
                "ipv6_cidr_block": "",
                "protocol": "-1",
                "rule_no": 8000,
                "to_port": 0
              },
              {
              "action": "allow",
              "cidr_block": "0.0.0.0/0",
              "from_port": 22,
              "icmp_code": 0,
              "icmp_type": 0,
              "ipv6_cidr_block": "",
              "protocol": "6",
              "rule_no": 300,
              "to_port": 22
              },
              {
              "action": "allow",
              "cidr_block": "0.0.0.0/0",
              "from_port": 443,
              "icmp_code": 0,
              "icmp_type": 0,
              "ipv6_cidr_block": "",
              "protocol": "6",
              "rule_no": 200,
              "to_port": 443
              },
              {
              "action": "allow",
              "cidr_block": "0.0.0.0/0",
              "from_port": 80,
              "icmp_code": 0,
              "icmp_type": 0,
              "ipv6_cidr_block": "",
              "protocol": "6",
              "rule_no": 100,
              "to_port": 80
              },
              # allow epehmeral ports
              {
              "action": "allow",
              "cidr_block": "0.0.0.0/0",
              "from_port": 1025,
              "icmp_code": 0,
              "icmp_type": 0,
              "ipv6_cidr_block": "",
              "protocol": "tcp",
              "rule_no": 9000,
              "to_port": 65535
              },
              {
              "action": "allow",
              "cidr_block": "0.0.0.0/0",
              "from_port": 1025,
              "icmp_code": 0,
              "icmp_type": 0,
              "ipv6_cidr_block": "",
              "protocol": "udp",
              "rule_no": 9100,
              "to_port": 65535
              }
              ]
  subnet_ids =aws_subnet.public.*.id
}

resource "aws_network_acl" "nacl-private" {
 vpc_id = aws_vpc.vpc.id
  tags = {
    Name: "private-nacl"
    build: var.build
   }
  egress = [
              {
                "action": "allow",
                "cidr_block": var.vpc_cidr,
                "from_port": 0,
                "icmp_code": 0,
                "icmp_type": 0,
                "ipv6_cidr_block": "",
                "protocol": "-1",
                "rule_no": 8000,
                "to_port": 0
              },
              {
                "action": "allow",
                "cidr_block": "0.0.0.0/0",
                "from_port": 443,
                "icmp_code": 0,
                "icmp_type": 0,
                "ipv6_cidr_block": "",
                "protocol": "6",
                "rule_no": 200,
                "to_port": 443
              },
              {
                "action": "allow",
                "cidr_block": "0.0.0.0/0",
                "from_port": 80,
                "icmp_code": 0,
                "icmp_type": 0,
                "ipv6_cidr_block": "",
                "protocol": "6",
                "rule_no": 300,
                "to_port": 80
              },
              {
              "action": "allow",
              "cidr_block": "0.0.0.0/0",
              "from_port": 1025,
              "icmp_code": 0,
              "icmp_type": 0,
              "ipv6_cidr_block": "",
              "protocol": "tcp",
              "rule_no": 9000,
              "to_port": 65535
              },
              {
              "action": "allow",
              "cidr_block": "0.0.0.0/0",
              "from_port": 1025,
              "icmp_code": 0,
              "icmp_type": 0,
              "ipv6_cidr_block": "",
              "protocol": "udp",
              "rule_no": 9100,
              "to_port": 65535
              }
            ]
  ingress = [
              {
              "action": "allow",
              "cidr_block": var.vpc_cidr,
              "from_port": 0,
              "icmp_code": 0,
              "icmp_type": 0,
              "ipv6_cidr_block": "",
              "protocol": "-1",
              "rule_no": 8000,
              "to_port": 0
              },
              {
              "action": "allow",
              "cidr_block": "0.0.0.0/0",
              "from_port": 1025,
              "icmp_code": 0,
              "icmp_type": 0,
              "ipv6_cidr_block": "",
              "protocol": "tcp",
              "rule_no": 9000,
              "to_port": 65535
              },
              {
              "action": "allow",
              "cidr_block": "0.0.0.0/0",
              "from_port": 1025,
              "icmp_code": 0,
              "icmp_type": 0,
              "ipv6_cidr_block": "",
              "protocol": "udp",
              "rule_no": 9100,
              "to_port": 65535
              }
              ]
  subnet_ids =aws_subnet.private.*.id
}

