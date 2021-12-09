aws ec2 run-instances \
--image-id ami-01216a3493f3ae184 \
--security-group-ids sg-0e20b3038e5d6213f \
--instance-type t2.medium \
--key-name CaliforniaKeyPair \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Jenkins}]'

aws ec2 run-instances \
--image-id ami-01216a3493f3ae184 \
--security-group-ids sg-0e20b3038e5d6213f \
--instance-type t2.medium \
--key-name CaliforniaKeyPair \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=WebServer}]'

aws ec2 run-instances \
--image-id ami-0629230e074c580f2 \
--security-group-ids sg-02832c58304b8c2fd \
--instance-type t2.medium \
--key-name OhioKeyPair \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=JenkinsSlave}]'