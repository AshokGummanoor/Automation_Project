#!/bin/bash

s3bucket="upgrad-ashok"
name="ashok"

sudo apt update -y

#------Apache Installation Check-------
Required_PKG="apache2"
PKG_OK=$(dpkg-query -W --showformat='${status}\n' $Required_PKG | grep "install ok installed")
if [ "" = "$PKG_OK" ]
then
        echo "Apache is not available. Installing the Apache"
        sudo apt install apache2 -y
        echo "Apache Installed"
else
        echo "Apache is alreday installed"

fi
#--------------------------------------

#-------AWSCLI Installtion Check-------
AWSCLI_PKG="awscli"
PKG_Query=$(dpkg-query -W --showformat='${status}\n' $AWSCLI_PKG | grep "install ok installed")
if [ "" = "$PKG_Query" ]
then
        echo "AWS CLI is not installed. Installing AWSCLI"
        sudo apt-get install awscli -y
        echo "AWS CLI Installed"
else
        echo "AWS CLI is already installed"

fi
#---------------------------------------

#----Apache status Check--------
if [ `service apache2 status | grep running | wc -l` == 1 ]
then
        echo "Apache is running"
else
        sudo service apache2 start
        echo "Apache Started now"
fi
#--------------------------------

#-----Apache Enable Check-------
if [ `service apache2 status | grep enabled | wc -l` == 1 ]
then
        echo "Apache already enabled"
else
        sudo systemct1 enable apache2
        echo "Apache enabled"
fi
#--------------------------------------

timestamp=$(date '+%d%m%Y-%H%M%S')

#------------------Converting access logs to tar------
cd /var/log/apache2/
tar cvf /tmp/ashok-httpd-logs-${timestamp}.tar *.log
#--------------------------------------------------------

#------------------Copy to S3 Bucket---------
aws s3 cp /tmp/ashok-httpd-logs-${timestamp}.tar s3://upgrad-ashok/
#--------------------------------------------
