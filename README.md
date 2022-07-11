# aws-terraform-fargate

## Description

This is an example of how to deploy a NestJS application to AWS Fargate using Terraform

## Application

For locally testing and running the application

### Installation

```bash
$ npm install
```

### Running the app

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev

# production mode
$ npm run start:prod
```

### Test

```bash
# unit tests
$ npm run test

# e2e tests
$ npm run test:e2e

# test coverage
$ npm run test:cov
```

## USAGE

1. Provision Terraform backend bucket and lock table

```
cd terraform/backend-terraform
terraform plan -var-file="../terraform.tfvars"
terraform apply -var-file="../terraform.tfvars"
terraform output
```

2. Initializing Terraform requires passing a few parameters

```
cd terraform/development
terraform init \
    -backend-config="bucket=${APP_NAME}-backend-terraform" \
    -backend-config="region=us-east-1" \
    -backend-config="dynamodb_table=${APP_NAME}-terraform-locks" \
    -backend-config="key=${ENVIRONMENT}/terraform.tfstate"
terraform apply -var-file="../terraform.tfvars"
```

Now you're ready to push your code and have the underlying infrastucture and API provisioned and deployed.
