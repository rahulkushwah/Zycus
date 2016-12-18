#!/bin/bash

#This script is written for password-less connectivity and i have used key pair file to ssh in machine.
# I have executed this file in AWS environment with 2 EC2 instance.
#That is the reason i have used ec2-user and testgroup.pem file in ssh command.

#For comma separated hostname we are using IFS(Internal Field Separator) special variable.
#which will separate the n number of host name by checking "," as delimiter.
# And we are storing original argument which is passed in command in oIFS variable.

oIFS="$IFS"
IFS=,
set -- $1
IFS="$oIFS"
# Give a single prompt to the user to enter the command in diffrent servers.
echo "Please enter your Command: "
read input_variable
# Removing the file so that for each run we get fresh log
rm -f error.txt
rm -f output.txt
# for loop for all the servers and the input command is passed in ssh command for execution
# The success log will be written in output.txt and error logs in error.txt
for i in "$@"
 do
  echo "###### $i ######" >> output.txt
  echo "###### $i ######" >> error.txt
  ssh ec2-user@$i -i testgroup.pem "$input_variable" >> output.txt 2>>error.txt
done
clear
echo "=================================="
echo Total server: $#
echo "=================================="
echo "=============OUTPUT==============="
cat output.txt
echo "=============ERROR================"
cat error.txt
echo "==============END================="
