# Automation_Project
Project Assignment of Upgrad

As Dogecoin company is growing very fast. Need to set up the web servers on the EC2 instance for hosting the website and has to ensure that the apache2 server is running and restarts automatically in case the EC2 instance reboots. Also, need to archive the log files to the s3 bucket to keep the servers running out of disk space and creating backup of these logs files for troubleshooting. As this is weekly/daily activity doing it manually takes a long time. 
For this, we have wrote this automation script with name automation.sh.
Step 1: It perform an update of the package details and the package list at the start of the script.
Step 2: Checks the Apache & AWS CLI installation first on the server and installs them it if they are not installed. 
Step 3: Checks the Apache Server is running or not
Step 4: Checks whether the Apache is enabled or not
Step 5: Creates the tar file of all the log files and stores them in the tmp folder
step 6: Copy the tar files from tmp folder to s3 bucket.

Made some changes in the automation script to get the metadata of the archived logs and a cron job file in /etc/cron.d/ with the name 'automation' that runs the script with root user daily.

Step 7 : Checks whether the inventory html file exists or not. If not it will be created along with the header "Log Type, Time Created, Type & Size".
Step 8 : whenever the script runs the metadata of the files will be included along with the newly created file metadata.
Step 9 : Checks whether a cron job is present or not. If not creates the cron job which will run daily once.
