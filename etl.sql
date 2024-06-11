
-- ec2 instances
select account_id,region,arn,instance_id, image_id, instance_type, subnet_id, title, vpc_id
into aws_ec2_instance
from hack.aws_ec2_instance;
-- drop table aws_ec2_instance


-- ebs volumes
select account_id, arn, availability_zone, encrypted, region, size, snapshot_id, title, volume_id, volume_type
into aws_ebs_volume
from hack.aws_ebs_volume;
-- drop table aws_ebs_volume

-- ec2 instance to ebs volume mapping table
select 
instance_id, 
jsonb_array_elements(block_device_mappings) #>> '{Ebs,VolumeId}' as volume_id,
jsonb_array_length(block_device_mappings) as ebs_volume_count
into ec2_to_ebs
from hack.aws_ec2_instance 


-- snapshots
select account_id, arn, encrypted, region, snapshot_id, volume_id, volume_size
into aws_ebs_snapshot
from hack.aws_ebs_snapshot;
-- drop table aws_ebs_snapshot

-- cloudwatch 
select account_id, arn, data_protection, name, region, retention_in_days, title
into aws_cloudwatch_log_group
from hack.aws_cloudwatch_log_group
-- drop table aws_cloudwatch_log_group

-- aws_iam_user
select account_id, arn, mfa_enabled, name, password_last_used, region, user_id
into aws_iam_user
from hack.aws_iam_user
-- drop table aws_iam_user


-- lambda
select account_id, architectures, arn, description, handler, name, region, role, runtime, title, vpc_id, vpc_subnet_ids
into aws_lambda_function
from hack.aws_lambda_function
-- drop table aws_lambda_function



-- s3
select account_id, arn, block_public_acls, block_public_policy, bucket_policy_is_public, name, lifecycle_rules, object_lock_configuration, region, replication, versioning_enabled
into aws_s3_bucket
from hack.aws_s3_bucket
-- drop table aws_s3_bucket

-- vpc 
select account_id, arn, cidr_block, state, is_default, dhcp_options_id, title, region
into aws_vpc
from hack.aws_vpc
-- drop table aws_vpc

-- IGW
select account_id, attachments, internet_gateway_id, region, title
into aws_vpc_internet_gateway
from hack.aws_vpc_internet_gateway
-- drop table aws_vpc_internet_gateway


-- NAT Gateway
select account_id, arn, nat_gateway_addresses, nat_gateway_id, region, state, subnet_id, title, vpc_id, title
into aws_vpc_nat_gateway
from hack.aws_vpc_nat_gateway
-- drop table aws_vpc_nat_gateway


-- subnets
select account_id, availability_zone, availability_zone_id, available_ip_address_count, cidr_block, region, subnet_arn, subnet_id, title, vpc_id
into aws_vpc_subnet
from hack.aws_vpc_subnet
-- drop table aws_vpc_subnet

-- VPN
select account_id, arn, category, region, title, type
into aws_vpc_vpn_connection
from hack.aws_vpc_vpn_connection
-- drop table aws_vpc_vpn_connection













--- FOR LATER SSO userers and instances
select account_id, arn,*
--into aws_s3_bucket
from f_865406258841.aws_ssoadmin_instance
limit 100

-- d_640090909562
--"d-9a671dcf76"

-- f_865406258841
--"d-906701405f"

