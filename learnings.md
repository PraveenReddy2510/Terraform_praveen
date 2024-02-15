# ALL Learnings Doc

<details>
<summary>Explain the following block of Terraform code
    
```
resource "aws_instance" "gfg-ec2" {
  ami           = "ami-0c94855ba95c286c99"
  instance_type = "t2.micro"
}
```
</summary><br>

Let's break down the Terraform HCL (HashiCorp Configuration Language) syntax used in the provided code:

- **resource**: This keyword indicates that you're declaring a new resource. In Terraform, resources represent infrastructure components such as instances, databases, networks, etc.

- **"aws_instance"**: This is the resource type. In this case, it's an AWS EC2 instance. Terraform supports a wide range of providers, and "aws_instance" indicates that we're creating a resource using the AWS provider.

- **"gfg-ec2"**: This is the name of the resource instance. It's a user-defined name for this specific instance of the "aws_instance" resource. It must be unique within your Terraform configuration.

- **{}**: This block contains the configuration for the resource. All configuration settings specific to this resource instance are enclosed within these braces.

- **ami**: This is one of the configuration parameters for the EC2 instance. It specifies the Amazon Machine Image (AMI) ID that will be used to launch this instance. AMIs are pre-configured templates for virtual machines.

- **instance_type**: This is another configuration parameter for the EC2 instance. It specifies the type of the instance to be launched. In this case, it's "t2.micro", which is a type of small, general-purpose instance available in AWS.

- **=**: This operator is used to assign values to the parameters. In this case, it's assigning the AMI ID and instance type to their respective parameters.

- **"ami-0c94855ba95c286c99" and "t2.micro"**: These are the values assigned to the ami and instance_type parameters, respectively. They are literal string values representing the AMI ID and instance type.

Overall, this Terraform configuration defines an AWS EC2 instance resource named "gfg-ec2" using the specified AMI and instance type. When you apply this configuration using Terraform, it will create an EC2 instance in your AWS account with the specified characteristics.

</details>
