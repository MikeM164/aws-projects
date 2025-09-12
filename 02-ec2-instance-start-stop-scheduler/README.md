EC2 instance Start and Stop scheduler

## OVERVIEW
This project provisions a secure AWS VPC, deploys a WordPress application on EC2, and connects it to an RDS MySQL database in private subnets.

## ARCHITECTURE
- Amazon EventsBridge Scheduler - two schedulers that trigger the Lambda functions
- Lambda - two functions that start and stop EC2 instances respectively
- IAM Role - to enable schedulers to trigger Lambda functions, and the one to allow Lambda to  start/stop EC2 instances
- Cloudwatch logs - Show Lambda execution process

## DEPLOYMENT
- Provisioned using Cloudformation


## LEARNING OUTCOMES
- Designed a highly available, secure VPC  
- Automated EC2 + RDS provisioning  
- Configured WordPress with RDS backend
