# llm-infra

This project sets up a serverless container architecture, powered by AWS Fargate running on AWS ECS (Elastic Container Service), an Application Load Balancer, and a custom VPC. The infrastructure is defined and managed using Terraform.

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed (version 0.12+)
- [Docker container for testing](https://github.com/jscottcronin/fastapi-llm)

## Setup and Deployment

1. Clone this repository:
```bash
git clone <repository-url>
cd llm-infra
```
2. Update `terraform.tfvars` with your specific values:
```hcl
region = "eu-west-1"
project_name = "fastapi-demo"
vpc_cidr = "10.0.0.0/16"
container_image = "your-account-id.dkr.ecr.eu-west-1.amazonaws.com/fastapi-app:latest"
container_port = 8000
```
3. Build and push your FastAPI Docker image to ECR:
* Create an ECR repository in your AWS account
* Build your FastAPI Docker image
* Tag and push the image to ECR
* Update the container_image in terraform.tfvars with the correct ECR image URL

4. Initialize Terraform:
`terraform init`
5. Plan the deployment:
`terraform plan`
6. Apply the configuration:
`terraform apply`

7. After successful application, Terraform will output the ALB DNS name. Use this to access your FastAPI application.

## Testing

Access your FastAPI application:
curl http://<alb-dns-name>/

If you've set up a health check endpoint:
curl http://<alb-dns-name>/health


## Cleaning Up
To avoid incurring unnecessary costs, destroy the resources when you're done:
`terraform destroy`

## Troubleshooting

If your app isn't responding, check the ECS console for task status and logs
Verify that your security groups are correctly configured
Check that your FastAPI app is listening on 0.0.0.0 instead of localhost
Use AWS CloudWatch logs to debug any issues with your ECS tasks

## Customization

Adjust the number of AZs and subnets by modifying the az_count variable in the VPC module
Modify the ECS task definition in modules/ecs/main.tf to change container specifications
Update the ALB configuration in modules/alb/main.tf for different routing or SSL setup