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

#-----Checking and Creating inventory html----------
if [ -e /var/www/html/inventory.html ]
then
        echo "Inventory exists"
else
        touch /var/www/html/inventory.html
        echo -e "Log Type \t\t Time Created\t\t Type \t Size" >> /var/www/html/inventory.html
        echo "Inventory html file created"
fi

echo -e  "httpd-logs \t\t ${timestamp}\t tar \t `du -k`" | sed 's/.$//' >> /var/www/html/inventory.html
#-----------------------------------------------------

#--------Cron Job Set up----------------------
if [ -e /etc/cron.d/automation ]
then
        echo "Cron job exists"
else
        touch /etc/cron.d/automation
        echo "0 0 * * * root /root/Automation_Project/automation.sh" > /etc/cron.d/automation
        echo "Cron job added"
fi
#-----------------------------------------
