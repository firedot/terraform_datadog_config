# terraform_datadog_config
Terraform configuration that creates GCP infrastructure and monitoring for it

**TO-DO**

- Create Terrarofm configuration that:
   - creates 4 GCP Ubuntu based servers
   - installs DataDog Agent on every server
- Create a script that configures the DataDog agent installed in the previous step
  to send data to DataDogHQ
- Create Terraform configuration that:
   - creates every type of DataDog monitor resource 
   - creates a DataDog user resource
   - separate the monitor resources into modules

