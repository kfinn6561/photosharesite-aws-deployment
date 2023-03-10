#!/bin/bash -xv
# shellcheck disable=SC2164

# run script as ec2-user from home
su - ec2-user
cd /home/ec2-user

# copy all sql files from S3
aws s3 sync s3://"${bucket-name}"/procedures/ ./procedures
aws s3 sync s3://"${bucket-name}"/tables/ ./tables

# create the database
mysqladmin create "${database-name}"

# Create the tables
for fname in tables/*
do
  mysql "${database-name}" > "$fname"
done

# Create the procedures
for fname in procedures/*
do
  mysql "${database-name}" > "$fname"
done