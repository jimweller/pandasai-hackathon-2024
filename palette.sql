SELECT
	instance_id, 
	(block_device_mappings -> 0) #>> '{Ebs,VolumeId}' as volume_id_0,
	(block_device_mappings -> 1) #>> '{Ebs,VolumeId}' as volume_id_1,
	(block_device_mappings -> 2) #>> '{Ebs,VolumeId}' as volume_id_2,
	(block_device_mappings -> 3) #>> '{Ebs,VolumeId}' as volume_id_3,
	block_device_mappings
FROM lxk_sandbox.aws_ec2_instance;


select 
instance_id, 
jsonb_array_length(block_device_mappings) as len 
from hack.aws_ec2_instance 
order by len desc

select 
instance_id, 
jsonb_array_length(block_device_mappings) as len,
jsonb_array_elements(block_device_mappings) #>> '{Ebs,VolumeId}' as volume_id
from hack.aws_ec2_instance 


select 
unnest(array[instance_id]) as instance_id,
unnest(array[
	(block_device_mappings -> 0) #>> '{Ebs,VolumeId}', 
	(block_device_mappings -> 1) #>> '{Ebs,VolumeId}',
	(block_device_mappings -> 2) #>> '{Ebs,VolumeId}', 
	(block_device_mappings -> 3) #>> '{Ebs,VolumeId}',
	(block_device_mappings -> 4) #>> '{Ebs,VolumeId}', 
	(block_device_mappings -> 5) #>> '{Ebs,VolumeId}',
	(block_device_mappings -> 6) #>> '{Ebs,VolumeId}', 
	(block_device_mappings -> 7) #>> '{Ebs,VolumeId}',
	(block_device_mappings -> 8) #>> '{Ebs,VolumeId}', 
	(block_device_mappings -> 9) #>> '{Ebs,VolumeId}',
	(block_device_mappings -> 10) #>> '{Ebs,VolumeId}', 
	(block_device_mappings -> 11) #>> '{Ebs,VolumeId}',
	(block_device_mappings -> 12) #>> '{Ebs,VolumeId}', 
	(block_device_mappings -> 13) #>> '{Ebs,VolumeId}',
	(block_device_mappings -> 14) #>> '{Ebs,VolumeId}', 
	(block_device_mappings -> 15) #>> '{Ebs,VolumeId}'
	]) as volume_id
from lxk_sandbox.aws_ec2_instance



select 
instance_id,
(block_device_mappings -> 0) #>> '{Ebs,VolumeId}' as volume_id_0, 
(block_device_mappings -> 1) #>> '{Ebs,VolumeId}' as volume_id_1,
(block_device_mappings -> 2) #>> '{Ebs,VolumeId}' as volume_id_2, 
(block_device_mappings -> 3) #>> '{Ebs,VolumeId}' as volume_id_3,
(block_device_mappings -> 4) #>> '{Ebs,VolumeId}' as volume_id_4, 
(block_device_mappings -> 5) #>> '{Ebs,VolumeId}' as volume_id_5,
(block_device_mappings -> 6) #>> '{Ebs,VolumeId}' as volume_id_6, 
(block_device_mappings -> 7) #>> '{Ebs,VolumeId}' as volume_id_7,
(block_device_mappings -> 8) #>> '{Ebs,VolumeId}' as volume_id_8, 
(block_device_mappings -> 9) #>> '{Ebs,VolumeId}' as volume_id_9,
(block_device_mappings -> 10) #>> '{Ebs,VolumeId}' as volume_id_10, 
(block_device_mappings -> 11) #>> '{Ebs,VolumeId}' as volume_id_11,
(block_device_mappings -> 12) #>> '{Ebs,VolumeId}' as volume_id_12, 
(block_device_mappings -> 13) #>> '{Ebs,VolumeId}' as volume_id_13,
(block_device_mappings -> 14) #>> '{Ebs,VolumeId}' as volume_id_14, 
(block_device_mappings -> 15) #>> '{Ebs,VolumeId}' as volume_id_15
from lxk_sandbox.aws_ec2_instance
