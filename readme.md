# ANSIBLE DEPLOYMENT OPTIONS FOR BIOSTAR-CENTRAL

## 1. QuickStart

```
# Deploy to an AWS EC2 instance
ansible-playbook deploy.yml -i 'localhost',

# Deploy on your server using virtual box
vagrant up
```

***
## Table of Contents

- [1. QuickStart](#1-quickstart)
- [2. Overview](#2-overview)
- [3. AWS EC2 DEPLOYMENT](#3-aws-ec2-deployment)
  - [3.1. Requirements](#31-requirements)
  - [3.2. Usage](#32-usage)
  - [3.3. Accessing the containers](#33-accessing-the-containers)
  - [3.4. Continuous Deployment](#34-continuous-deployment)
- [4. VIRTUAL BOX DEPLOYMENT](#4-virtual-box-deployment)
  - [4.1. Requirements](#41-requirements)
  - [4.2. Usage](#42-usage)
  - [4.3. Accessing the VM](#43-accessing-the-vm)

***
	
## 2. Overview

An Ansible deployment suite for various deployment options for Biostar-Central using 'ansible'. It contains two provisions for deployment.
- Deploying on an AWS EC2 instance using Ansible
- An ansible proisioned Vagrant-VirtualBox deployment

For any of the above deployments, cd into the respective directory before continuing.


## 3. AWS EC2 DEPLOYMENT

Deploying on an Amazon Web Services - EC2 instance using Ansible. It is a one line deployment with continuous github deployment integrated. With all your settings in one space, there is no hassle of editing and copying different files.

The playbook performs the following tasks:
- Create an ssh public key on your computer to provide easy ssh access to the server
- Create a security group on EC2 with open ports 20, 80, 443 open.
- Launch an Amazon EC2 instance.
- Install Docker on the instance
- Create a PostgreSQL server in a Docker container
- Create a Docker container with Biostar-Central
- Run Biostars using [Waitress](http://waitress.readthedocs.org/en/latest/) as the webserver

### 3.1. Requirements

The only requirement for this deployment is Ansible.

```
To install, execute in terminal:
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install ansible
```

For more installation options, visit [Ansible](http://docs.ansible.com/ansible/intro_installation.html)	

### 3.2. Usage

1. `git clone http://github.com/Lohit13/biostar-ansible`
2. Edit 'variables.yml'. It contains all the settings required to host your own Biostar-Central app.
3. run `ansible-playbook deploy.yml -i 'localhost',
4. Wait for it to finish! All done:)

### 3.3. Accessing the containers

The ansible playbook automatically adds your ssh key to the EC2 instance. So you don't need a .pem file. To access the docker containers, follow the step below:

1. ssh into the EC2 container: ssh ubuntu@IP_OF_CONTAINER

To access Postgres Container:
2. `sudo docker exec -it post bin/bash`

To access Biostar Webapp Container
2. `sudo docker exec -it biostar bin/bash`

To exit any container, simple type `exit`

### 3.4. Continuous Deployment

To enable continuous deployment with github, follow the steps below:

1. Add the you Github Handle in the 'GITHUB_HANDLE' field in variables.yml
2. Go to your Biostar fork settings. Add a webhook service and point the payload to 'https://my-biostar-url.com/webhook/github/update'

Now, everytime you push (or your custom webhook payload) to your Biostar fork, the deployed code will automatically get updated and run.

## 4. VIRTUAL BOX DEPLOYMENT

You can also deploy Biostars in a virtual box environment using ansible-provisioned vagrant.

### 4.1. Requirements

One needs to have vagrant and virtual box set up on their machine for this deployment. 

To install the above, refer to this manual:
`http://www.olindata.com/blog/2014/07/installing-vagrant-and-virtual-box-ubuntu-1404-lts'

### 4.2. Usage

To deploy:
1. Edit 'variables.yml'. It contains all the settings required to host your own Biostar-Central app.
2. Run `varant up`
3. That's it. All done!

### 4.3. Accessing the VM

To access the virtual machine Biostars would be running on:
1. cd into the biostar-ansible/VirtualBox directory
2. Run `vagrant ssh`

To exit the vm, run `exit`

