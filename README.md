# Terraform with Ansible Demo Project

This project is created to demonstrate how to create a production grade AWS infrastructure
and deploy a Web application using ansible tasks. 

Project Scope:
* Terraform Modules are used
* Ansible is used to install and bootstrap the servers
* Parameterized
* Highly Available Infrastructure
* one click deploy
* Deploy to any region in AWS.


# AWS Infrastructure
|S.No | AWS Resources  | Description |
|-----| ------------- | ------------- |
|  1.  | VPC  | one AWS VPC   |
|  2.  | 12 Subnets  | 3 Private subnets, 3 Ingress Subnets, 3 Egress Subnets, 3 Data Subnets (1 per AZ)  |
|  3.  | 1 Internet GW | Internet GateWay  |
|  4.  | Route Tables  | Private Route tables Per region associated with respective NAT GateWays |
|  5.  | Bastion  | One bastion host to access Private instances |
|  6.  | 1 ASG  | Random Password Generator Application is deployed in this autoscaling group.




# Usage

#### Install Terraform 0.14
#### Configure AWS Access Keys and Secret Keys (aws configure or ENV Variables)


```shell
  terraform init
  git clone https://github.com/baijupadmanabhan/metro-demo.git
  cd metro-demo
  terraform plan
  terraform apply --yes 
  ```

# Ansible 

I have used simple ansible playbook in user data to install the application. 

This playbook installs nginx, Golang and downloads the UI files and starts the application.


Note: <i> This can be done in multiple other ways depending on the use case.



# Random Password Generator






