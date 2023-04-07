#!/bin/bash -xv
# shellcheck disable=SC2164

# re-run as ec2-user if logged in as root
if [ $UID -eq 0 ]; then
  chown ec2-user $0
  exec su ec2-user $0
fi

# everything should be run from the home directory
cd /home/ec2-user

# copy all sql files from S3
aws s3 sync s3://${bucket-name}/procedures/ ./procedures
aws s3 sync s3://${bucket-name}/tables/ ./tables

# create the database
mysqladmin create ${database-name}

# Create the tables
for fname in tables/*
do
  mysql ${database-name} < $fname
done

# Create the procedures
for fname in procedures/*
do
  mysql ${database-name} < $fname
done

# create a user
mysql ${database-name} -e  << 'EOF'
CREATE USER '${db-username}'@'localhost' IDENTIFIED BY '${db-password}';
CREATE USER '${db-username}'@'%' IDENTIFIED BY ''${db-password}';
GRANT ALL PRIVILEGES ON ${database-name}.* to ${db-username}@localhost IDENTIFIED BY '${db-password}' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON ${database-name}.* to ${db-username}@'%' IDENTIFIED BY '${db-password}' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF