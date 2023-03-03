#!/bin/bash -xv
aws s3 sync s3://${bucket-name}/procedures/ ./procedures
aws s3 sync s3://${bucket-name}/tables/ ./tables