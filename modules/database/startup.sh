#!/bin/bash -xv
# shellcheck disable=SC2164
cd /home/ubuntu

# update apt-get
apt-get -y update

# install aws cli
apt-get -y install awscli

# copy all sql files from S3
aws s3 sync s3://"${bucket-name}"/procedures/ ./procedures
aws s3 sync s3://"${bucket-name}"/tables/ ./tables

# install mysql
apt-get -y install mysql-server
apt-get -y install mysql

# create the database
mysqladmin create "${database-name}"

# Create the tables
for fname in tables/*
do
  mysql "${database-name}" < "$fname"
done

# Create the procedures
for fname in procedures/*
do
  mysql "${database-name}" < "$fname"
done