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
