# vpc
availability_zones_euw = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
cidr_public = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
cidr_private = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
cidr_range = "10.0.0.0/20"
vpc_name = "tp-vpc"

#  dynamo
dynamo_table_names = ["lighting", "heating"]
dynamo_hash_keys = [ "id", "id" ]
dynamo_hash_key_type = ["N", "N"]

# servers
instance_type = "t2.micro"
public_ec2_names = [ "heating", "lighting", "status" ]
private_ec2_names = [ "auth" ]

# load_balancers
tg_protocol = "HTTP"
tg_port = "3000"
tg_protocol_version = "HTTP1"
lb_internal = false
load_balancer_type = "application"