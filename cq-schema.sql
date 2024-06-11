DROP TABLE public.aws_vpc_vpn_connection;
DROP TABLE public.aws_vpc_subnet;
DROP TABLE public.aws_vpc_nat_gateway;
DROP TABLE public.aws_vpc_internet_gateway;
DROP TABLE public.aws_vpc;
DROP TABLE public.aws_s3_bucket;
DROP TABLE public.aws_lambda_function;
DROP TABLE public.aws_iam_user;
DROP TABLE public.aws_ec2_instance;
DROP TABLE public.aws_ebs_volume;
DROP TABLE public.aws_ebs_snapshot;
DROP TABLE public.aws_cloudwatch_log_group;
DROP TABLE public.ec2_to_ebs;



CREATE TABLE public.aws_cloudwatch_log_group (
    account_id text,
    arn text,
    data_protection jsonb,
    name text,
    region text,
    retention_in_days bigint,
    title text
);


CREATE TABLE IF NOT EXISTS public.aws_ebs_snapshot (
    account_id text,
    arn text,
    encrypted boolean,
    region text,
    snapshot_id text,
    volume_id text,
    volume_size bigint,
    start_time timestamp with time zone,
    age_days bigint
);


CREATE TABLE public.aws_ebs_volume (
    account_id text,
    arn text,
    availability_zone text,
    encrypted boolean,
    region text,
    size bigint,
    snapshot_id text,
    title text,
    volume_id text,
    volume_type text
);


CREATE TABLE IF NOT EXISTS public.ec2_to_ebs(
    instance_id text,
    volume_id text
);


CREATE TABLE public.aws_ec2_instance (
    account_id text,
    region text,
    arn text,
    instance_id text,
    image_id text,
    instance_type text,
    subnet_id text,
    title text,
    vpc_id text,
    volume_count bigint
);



CREATE TABLE public.aws_iam_user (
    account_id text,
    arn text,
    mfa_enabled boolean,
    name text,
    password_last_used timestamp with time zone,
    region text,
    user_id text
);



CREATE TABLE public.aws_lambda_function (
    account_id text,
    architectures jsonb,
    arn text,
    description text,
    handler text,
    name text,
    region text,
    role text,
    runtime text,
    title text,
    vpc_id text,
    vpc_subnet_ids jsonb
);



CREATE TABLE public.aws_s3_bucket (
    account_id text,
    arn text,
    block_public_acls boolean,
    block_public_policy boolean,
    bucket_policy_is_public boolean,
    name text,
    lifecycle_rules jsonb,
    object_lock_configuration jsonb,
    region text,
    replication jsonb,
    versioning_enabled boolean
);



CREATE TABLE public.aws_vpc (
    account_id text,
    arn text,
    cidr_block cidr,
    state text,
    is_default boolean,
    dhcp_options_id text,
    title text,
    region text
);



CREATE TABLE public.aws_vpc_internet_gateway (
    account_id text,
    attachments jsonb,
    internet_gateway_id text,
    region text,
    title text
);



CREATE TABLE public.aws_vpc_nat_gateway (
    account_id text,
    arn text,
    nat_gateway_addresses jsonb,
    nat_gateway_id text,
    region text,
    state text,
    subnet_id text,
    title text,
    vpc_id text
);



CREATE TABLE public.aws_vpc_subnet (
    account_id text,
    availability_zone text,
    availability_zone_id text,
    available_ip_address_count bigint,
    cidr_block cidr,
    region text,
    subnet_arn text,
    subnet_id text,
    title text,
    vpc_id text
);



CREATE TABLE public.aws_vpc_vpn_connection (
    account_id text,
    arn text,
    category text,
    region text,
    title text,
    type text
);



