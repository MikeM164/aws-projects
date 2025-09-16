# EC2 Instance Start and Stop Scheduler

## Overview
This project demonstrates cost optimization in AWS by automating the start/stop of EC2 instances using serverless event-driven architecture
- **Morning** → Start the EC2 instance  
- **End of business day** → Stop the EC2 instance

This ensures that development resources only run when needed, reducing unnecessary compute costs.


## AWS Services used
- **Amazon EC2** - compute resource managed by the scheduler
- **Amazon EventBridge Scheduler** - defines when the start/stop events run
- **AWS Lambda** - serverless functions for start/stop logic
- **AWS Identity and Access Management (IAM)** - roles and policies for least-priviledge access
- **Amazon Cloudwatch** - monitoring and logs of Lambda execution
- **AWS Cloudformation** - infrastructure as code to provision resources 


## Architecture
- **Amazon EventBridge Scheduler** – Two schedules configured to invoke Lambda functions.
- **AWS Lambda** – One function to start the EC2 instance, another to stop it.
- **IAM Roles** –
    - Scheduler role: Grants permissions to invoke Lambda functions.
    - Lambda role: Grants permissions to start/stop EC2 instances.
- **Amazon CloudWatch Logs** – Captures Lambda execution details for observability.

## Deployment
- Infrastructure is provisioned using AWS CloudFormation.
- Templates define EC2, IAM roles, Lambda functions, and EventBridge schedules.
- The source for the Lambda functions has been stored in the zipped files in Amazon S3 bucket

## Learning Outcomes
- Designed and implemented a cost optimization automation for EC2 workloads.
- Gained experience with:
    - **Event-driven automation** using EventBridge Scheduler.
    - **Serverless compute** with Lambda.
    - **Infrastructure as Code (IaC)** via CloudFormation.
- Learned how to integrate multiple AWS services (EventBridge, Lambda, EC2, IAM, CloudWatch) into a cohesive solution.

## Architecture Diagram
Below is the high-level architecture of the solution.  
It shows how the EventBridge Scheduler triggers the Lambda functions, which then start/stop the EC2 instance.  
Execution logs are captured in CloudWatch. 

![alt text](<images/architecture.png>)

## Provisioned Resources
Below is the EC2 instance that was launched via Cloudformation. The instance will be stopped so that it can be started by the Lambda function triggered by the scheduler and later on be stopped by another lambda function. 

### EC2 instance launched by Cloudformation
- Creating EC2 launch Cloudformation Stack

![alt text](<images/ec2-instance-cf-launch.png>)
---------------------------------------------------------------------------------------------------------------------------------------------------------------

- Cloudformation Stack completed

![alt text](<images/ec2-instance-cf-launch-complete.png>)
---------------------------------------------------------------------------------------------------------------------------------------------------------------

- EC2 instance running after launch

![alt text](<images/ec2-instance-running.png>)
---------------------------------------------------------------------------------------------------------------------------------------------------------------

- EC2 instance stopped in order to be started later by Lambda function

![alt text](<images/ec2-instance-stopped-manually.png>)
---------------------------------------------------------------------------------------------------------------------------------------------------------------

### EventBridge Schedulers and Lambdas Cloudformation Stack
- Creating Cloudformation Stack for Schedulers and Lambdas

![alt text](<images/lambda-scheduler-create.png>)
---------------------------------------------------------------------------------------------------------------------------------------------------------------

- Cloudformation Stack completed

![alt text](<images/lambda-scheduler-create-complete.png>)
---------------------------------------------------------------------------------------------------------------------------------------------------------------

### 1. EventBridge Schedules
Two schedules are created
- **StartEC2LambdaScheduler** – triggers Lambda in the morning.  
- **StopEC2LambdaScheduler** – triggers Lambda in the evening. 

![alt text](<images/eventbridge-schedulers.png>)
---------------------------------------------------------------------------------------------------------------------------------------------------------------

### 2. Lambda Functions
Two Lambda functions handle the start and stop actions:  
- **StartEC2InstanceLambda**  
- **StopEC2InstanceLambda** 

![alt text](<images/lambda-functions.png>) 
---------------------------------------------------------------------------------------------------------------------------------------------------------------

### 3. EC2 Instance and Cloudwatch Logs
- EC2 instance started by the Lambda function.

![alt text](<images/ec2-instance-started-by-lambda.png>) 
---------------------------------------------------------------------------------------------------------------------------------------------------------------

- Cloudwatch logs confirming the EC2 instance start action
![alt text](<images/ec2-instance-start-logs.png>) 
---------------------------------------------------------------------------------------------------------------------------------------------------------------

- EC2 instance stopped by the Lambda function.

![alt text](<images/ec2-instance-stopped-by-lambda.png>) 
---------------------------------------------------------------------------------------------------------------------------------------------------------------

- Cloudwatch logs confirming the EC2 instance stop action
![alt text](<images/ec2-instance-stop-logs.png>) 
