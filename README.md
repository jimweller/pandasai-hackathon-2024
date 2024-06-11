# PandasAI Hackathon 2024

## Questions to ask

These are some insightful questions to ask

### SQL

_baseline, total VMs in these accounts_
how many ec2

_policy, all data to be encrypted at rest_
how may ebs group by encryption
  
_expense, stale snapshots_
what is the total size of snapshots older than 90 days, show size, show size multiplied by .025 multiplied by .025 formatted as dollars, show size multiplied by .08 formatted as dollars

_expense, orphan snapshots_
how many aws_ebs_snapshots do not have a volume_id in aws_ebs_volume per account, exclude snapshot volume_id vol-ffffffff, show size, show size multiplied by .025 formatted as dollars, show size multiplied by .08 formatted as dollars


### PandasAI

_baseline, total vms_
how many ec2 instances

_aggregation and graphics, vms per region_
histogram of ec2 per region

_policy, encryption at rest_
count of snapshot grouped by encryption, as table

_expense, log lifecycle policies_
how many cloudwatch log groups and how many have null retention




### Other Cool Queries

How many cloudwatch logs are growing infinitely?

`how many cloudwatch group by retention`

`how many cloudwatch group with no retention by account by region order by account and region`

Storage?

`how many ebs`

`total size of ebs`

`how many snapshots`

`total size of snapshots`

`how many snapshots per volume, order by count`

`total size of ebs per account per region, order by size`

`how many aws_ebs_snapshots do not have a volume_id in aws_ebs_volume`

`how many aws_ebs_snapshots do not have a volume_id in aws_ebs_volume per account, exclude snapshot volume_id vol-ffffffff, show size, show size multiplied by .025 formatted as dollars, show size multiplied by .08 formatted as dollars`

Jim Hull a PM sent a corporate announcment about only two copies of data in COLO
`SELECT account_id, COUNT(DISTINCT volume_id) AS volume_count FROM aws_ebs_snapshot GROUP BY account_id HAVING COUNT(snapshot_id) > 2 `

`how many snapshots are older than 90 days`

`what is the total size of snapshots older than 90 days, show size, show size multiplied by .025 formatted as dollars, show size multiplied by .08 formatted as dollars`

`how many aws_ebs_snapshots do not have a volume_id in aws_ebs_volume per account, exclude snapshot volume_id vol-ffffffff`

`how may ebs group by encryption`

`how many s3`

`how many s3 per account per region order by count`

`how many s3 group by bucket_policy_is_public`



### Chainlit

`how many ec2`

`histogram of ec2 per region`

`ec2 per account as pie chart`

`ec2 per account per region as stacked bar chart`

`cloudwatch_log_group retention_in_days as pie chart, include retention_in_days is empty`

`Generate me 100 synthetic ec2 rows with columns account_id, region, instance_id based on provided examples using Faker library`

`plot regions us-east-1, us-east-2, us-west-2 on a world map using geopandas library`

`what is the total volume_size of aws_ebs_volume multiplied by .08 formatted as dollars`


### Cost
About 30 words per input and 180 per response.