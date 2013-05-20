Download tools from:
    http://aws.amazon.com/developertools/2534?_encoding=UTF8&jiveRedirect=1

Instructions on:
    http://docs.aws.amazon.com/AmazonCloudWatch/latest/GettingStartedGuide/SetupCLI.html

Dimension and Metric documentation:
    http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CW_Support_For_AWS.html#rds-metricscollected

```
export AWS_CLOUDWATCH_HOME=/Users/lehrblogger/Desktop/CloudWatch-1.0.13.4
export JAVA_HOME=/usr
chmod 600  /Users/lehrblogger/Desktop/CloudWatch-1.0.13.4/credential-file-path.template
export AWS_CREDENTIAL_FILE=/Users/lehrblogger/Desktop/CloudWatch-1.0.13.4/credential-file-path.template
export PATH=$PATH:/Users/lehrblogger/Desktop/CloudWatch-1.0.13.4/bin
mon-cmd mon-describe-alarms > alarms.txt
sh alarm_import.sh
```

Notes:
  + I'm not sure how to make the `Unable to find a $JAVA_HOME at "/usr", continuing with system-provided Java...` warnings go away, but it's not worth investigating.
  + If you paste the mon-put-metric-alarm commands into the terminal, it seems to jumble the alarm names a bit. Better to run as a shell script so they execute one at a time.
