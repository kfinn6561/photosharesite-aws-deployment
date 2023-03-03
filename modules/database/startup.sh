#!/bin/bash -xv
# shellcheck disable=SC2164
cd /home/ec2-user
aws s3 sync s3://${bucket-name}/procedures/ ./procedures
aws s3 sync s3://${bucket-name}/tables/ ./tables