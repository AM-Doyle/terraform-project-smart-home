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
customamis = [ "ami-022e3388404f71930",  "ami-0b2a2dd5fa1c618b4", "ami-0f186a5e46f0b806b", "ami-009cb50bba9849eba"]
ec2s_needed = false

# load_balancers
tg_protocol = "HTTP"
tg_port = "3000"
tg_protocol_version = "HTTP1"
lb_internal = false
load_balancer_type = "application"

# autoscaling
lt_instance_type = "t2.micro"
key_name = "tfIntroKey"
desired_instances = 1
max_instances = 2
min_instances = 1