Download tools from:
    http://aws.amazon.com/developertools/2534?_encoding=UTF8&jiveRedirect=1
Instructions on:
    http://docs.aws.amazon.com/AmazonCloudWatch/latest/GettingStartedGuide/SetupCLI.html

```
export AWS_CLOUDWATCH_HOME=/Users/lehrblogger/Desktop/CloudWatch-1.0.13.4
export JAVA_HOME=/usr
chmod 600  /Users/lehrblogger/Desktop/CloudWatch-1.0.13.4/credential-file-path.template
export AWS_CREDENTIAL_FILE=/Users/lehrblogger/Desktop/CloudWatch-1.0.13.4/credential-file-path.template
/Users/lehrblogger/Desktop/CloudWatch-1.0.13.4/bin/mon-cmd mon-describe-alarms > alarms.txt
```
