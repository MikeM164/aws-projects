EC2 Instance Start and Stop Scheduler

Overview
This project implements a cost optimization solution by automating the start and stop of Amazon EC2 instances in a development environment. It leverages Amazon EventBridge Scheduler to trigger AWS Lambda functions at defined times.

Morning → Start the EC2 instance
End of business day → Stop the EC2 instance

This ensures that development resources only run when needed, reducing unnecessary compute costs.

Architecture
- Amazon EventBridge Scheduler – Two schedules configured to invoke Lambda functions.
- AWS Lambda – One function to start the EC2 instance, another to stop it.
- IAM Roles –
    (i)   Scheduler role: Grants permissions to invoke Lambda functions.
    (ii)  Lambda role: Grants permissions to start/stop EC2 instances.
- Amazon CloudWatch Logs – Captures Lambda execution details for observability.

Deployment
- Infrastructure is provisioned using AWS CloudFormation.
- Templates define EC2, IAM roles, Lambda functions, and EventBridge schedules.

Learning Outcomes
- Designed and implemented a cost optimization automation for EC2 workloads.
- Gained experience with:
    (i)   Event-driven automation using EventBridge Scheduler.
    (ii)  Serverless compute with Lambda.
    (iii) Infrastructure as Code (IaC) via CloudFormation.

- Learned how to integrate multiple AWS services (EventBridge, Lambda, EC2, IAM, CloudWatch) into a cohesive solution.