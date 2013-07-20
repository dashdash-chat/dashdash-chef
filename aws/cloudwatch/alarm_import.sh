mon-cmd mon-put-metric-alarm --alarm-name AWS-EBS-prod_ejabberd-High_Queue_Length     --dimensions VolumeId=vol-6a795832 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EBS --metric-name VolumeQueueLength                     --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 2.5
mon-cmd mon-put-metric-alarm --alarm-name AWS-EBS-prod_ejabberd-High_Total_Write_Time --dimensions VolumeId=vol-6a795832 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EBS --metric-name VolumeTotalWriteTime                  --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 0.5
mon-cmd mon-put-metric-alarm --alarm-name AWS-EBS-prod_leaves-High_Queue_Length       --dimensions VolumeId=vol-cef4d496 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EBS --metric-name VolumeQueueLength                     --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 2.5
mon-cmd mon-put-metric-alarm --alarm-name AWS-EBS-prod_leaves-High_Total_Write_Time   --dimensions VolumeId=vol-cef4d496 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EBS --metric-name VolumeTotalWriteTime                  --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 0.5
mon-cmd mon-put-metric-alarm --alarm-name AWS-EBS-prod_web-High_Queue_Length          --dimensions VolumeId=vol-afb898f7 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EBS --metric-name VolumeQueueLength                     --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 2.5
mon-cmd mon-put-metric-alarm --alarm-name AWS-EBS-prod_web-High_Total_Write_Time      --dimensions VolumeId=vol-afb898f7 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EBS --metric-name VolumeTotalWriteTime                  --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 0.5
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_ejabberd-High_CPU_Utilization         --dimensions InstanceId=i-29d8564b --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name CPUUtilization                        --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 85.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_ejabberd-High_Disk_Read_Operations    --dimensions InstanceId=i-29d8564b --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name DiskReadOps                           --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 500.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_ejabberd-High_Disk_Reads              --dimensions InstanceId=i-29d8564b --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name DiskReadBytes                         --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 250000.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_ejabberd-High_Disk_Write_Operations   --dimensions InstanceId=i-29d8564b --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name DiskWriteOps                          --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 75.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_ejabberd-High_Disk_Writes             --dimensions InstanceId=i-29d8564b --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name DiskWriteBytes                        --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 500000.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_ejabberd-High_Network_In              --dimensions InstanceId=i-29d8564b --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name NetworkIn                             --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 8000000.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_ejabberd-High_Network_Out             --dimensions InstanceId=i-29d8564b --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name NetworkOut                            --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 8000000.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_ejabberd-High_Status_Check_Failed_Any --dimensions InstanceId=i-29d8564b --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_failure         --namespace AWS/EC2 --metric-name StatusCheckFailed                     --period 300 --statistic Maximum --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 1.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_leaves-High_CPU_Utilization           --dimensions InstanceId=i-59d36c39 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name CPUUtilization                        --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 85.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_leaves-High_Disk_Read_Operations      --dimensions InstanceId=i-59d36c39 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name DiskReadOps                           --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 500.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_leaves-High_Disk_Reads                --dimensions InstanceId=i-59d36c39 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name DiskReadBytes                         --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 250000.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_leaves-High_Disk_Write_Operations     --dimensions InstanceId=i-59d36c39 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name DiskWriteOps                          --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 75.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_leaves-High_Disk_Writes               --dimensions InstanceId=i-59d36c39 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name DiskWriteBytes                        --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 500000.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_leaves-High_Network_In                --dimensions InstanceId=i-59d36c39 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name NetworkIn                             --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 2.4E7
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_leaves-High_Network_Out               --dimensions InstanceId=i-59d36c39 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name NetworkOut                            --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 1.2E7
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_leaves-High_Status_Check_Failed_Any   --dimensions InstanceId=i-59d36c39 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_failure         --namespace AWS/EC2 --metric-name StatusCheckFailed                     --period 300 --statistic Maximum --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 1.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_web-High_CPU_Utilization              --dimensions InstanceId=i-b828aadb --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name CPUUtilization                        --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 85.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_web-High_Disk_Read_Operations         --dimensions InstanceId=i-b828aadb --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name DiskReadOps                           --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 500.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_web-High_Disk_Reads                   --dimensions InstanceId=i-b828aadb --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name DiskReadBytes                         --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 250000.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_web-High_Disk_Write_Operations        --dimensions InstanceId=i-b828aadb --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name DiskWriteOps                          --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 75.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_web-High_Disk_Writes                  --dimensions InstanceId=i-b828aadb --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name DiskWriteBytes                        --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 500000.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_web-High_Network_In                   --dimensions InstanceId=i-b828aadb --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name NetworkIn                             --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 8000000.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_web-High_Network_Out                  --dimensions InstanceId=i-b828aadb --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/EC2 --metric-name NetworkOut                            --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 8000000.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-prod_web-High_Status_Check_Failed_Any      --dimensions InstanceId=i-b828aadb --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_failure         --namespace AWS/EC2 --metric-name StatusCheckFailed                     --period 300 --statistic Maximum --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 1.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-EC2-stage_all-High_Status_Check_Failed_Any     --dimensions InstanceId=i-b810d8d6 --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_failure         --namespace AWS/EC2 --metric-name StatusCheckFailed                     --period 300 --statistic Maximum --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 1.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-RDS-prod_mysql-High_CPUUtilization             --dimensions DBInstanceIdentifier=dashdash --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/RDS --metric-name CPUUtilization                --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 90.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-RDS-prod_mysql-High_DatabaseConnections        --dimensions DBInstanceIdentifier=dashdash --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/RDS --metric-name DatabaseConnections           --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 40.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-RDS-prod_mysql-High_FreeStorageSpace           --dimensions DBInstanceIdentifier=dashdash --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/RDS --metric-name FreeStorageSpace              --period 300 --statistic Average --evaluation-periods 1 --comparison-operator LessThanOrEqualToThreshold    --threshold 2000.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-RDS-prod_mysql-High_FreeableMemory             --dimensions DBInstanceIdentifier=dashdash --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/RDS --metric-name FreeableMemory                --period 300 --statistic Average --evaluation-periods 1 --comparison-operator LessThanOrEqualToThreshold    --threshold 1.0E8
mon-cmd mon-put-metric-alarm --alarm-name AWS-RDS-prod_mysql-High_ReadLatency                --dimensions DBInstanceIdentifier=dashdash --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/RDS --metric-name ReadLatency                   --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 0.25
mon-cmd mon-put-metric-alarm --alarm-name AWS-RDS-prod_mysql-High_WriteLatency               --dimensions DBInstanceIdentifier=dashdash --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/RDS --metric-name WriteLatency                  --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 0.25
mon-cmd mon-put-metric-alarm --alarm-name AWS-SQS-prod_celery-High_ApproximateNumberOfMessagesNotVisible --dimensions QueueName=prod-celery                         --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/SQS --metric-name ApproximateNumberOfMessagesNotVisible --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 50.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-SQS-prod_celery-High_ApproximateNumberOfMessagesVisible    --dimensions QueueName=prod-celery                         --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/SQS --metric-name ApproximateNumberOfMessagesVisible    --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 5.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-SQS-prod_celery-High_NumberOfEmptyReceives                 --dimensions QueueName=prod-celery                         --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/SQS --metric-name NumberOfEmptyReceives                 --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 5.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-SQS-prod_celery-High_NumberOfMessagesDeleted               --dimensions QueueName=prod-celery                         --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/SQS --metric-name NumberOfMessagesDeleted               --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 5.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-SQS-prod_celery-High_NumberOfMessagesReceived              --dimensions QueueName=prod-celery                         --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/SQS --metric-name NumberOfMessagesReceived              --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 5.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-SQS-prod_celery-High_NumberOfMessagesSent                  --dimensions QueueName=prod-celery                         --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/SQS --metric-name NumberOfMessagesSent                  --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 5.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-SQS-prod_celery-High_SentMessageSize                       --dimensions QueueName=prod-celery                         --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/SQS --metric-name SentMessageSize                       --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 2000.0
mon-cmd mon-put-metric-alarm --alarm-name AWS-SQS-prod_celery_pidbox-High_NumberOfEmptyReceives          --dimensions QueueName=prod-ip-10-147-216-14-celery-pidbox --alarm-actions arn:aws:sns:us-east-1:473320115542:dashdash_resources_maxed --namespace AWS/SQS --metric-name NumberOfEmptyReceives                 --period 300 --statistic Average --evaluation-periods 1 --comparison-operator GreaterThanOrEqualToThreshold --threshold 5.0
