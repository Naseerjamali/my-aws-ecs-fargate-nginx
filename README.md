# my-aws-ecs-fargate-nginx
An AWS ECS Fargate application that runs Nginx 

# the terraform code is segragated into base infrastructure and ecs infrastructure
Using Terraform modules the code is DRY and Terraform commands can be run in the current directory which contains main.tf and variables.tf
To modify the values, go into the variables.tf and change the current values to desired

# here's the directory tree:
```bash
.
├── Base-infrastructure      
│   ├── aws-alb
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfstate
│   │   └── variables.tf
│   ├── aws-security-groups
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfstate
│   │   └── variables.tf
│   └── aws-vpc-subnet
│       ├── main.tf
│       ├── outputs.tf
│       ├── terraform.tfstate
│       ├── terraform.tfstate.backup
│       └── variables.tf
├── README.md
├── ecs-infrastructure
│   ├── aws-ecr
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── aws-ecs-cluster
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── main.tf
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf

7 directories, 24 files
```
