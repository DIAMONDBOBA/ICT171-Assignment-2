 
# Le Gout - Cloud Food Blog & Cultural Journal
A Step-by-step guide to deploying the ** Le Gout** food blog on Amazon Web Services(AWS)using an EC2 instance, Apache web server, Route 53 for Domain Name System (DNS) management, and SSL/TLS encryption via Certbot.This documentation aims to be sufficiently detailed to allow an IT colleague or another ICT171 student to replicate the deployment from scratch.

>**Author:** Sarah Katuku

>**Student ID:** 35396921
>** Domain:** https://legout.click


# Introduction
This document outlines the process of setting up Le Gout, a personal food blog and cultural journal. The goal is to create an online presence that showcases culinary experiences and provides a platform for cultural sharing.

# Launching EC2 Instance #
If you don't already have an AWS account, please create one. Keeping in mind that this may take some time.

# Log in to the Amazon EC2 Management Console #
Log in to the AWS management console: https://aws.amazon.com/ec2/
Navigate to the EC2 Dashboard by searching for "EC2" and selecting it from the results.

### Launch Instance
From the EC2 Dashboard, click on the "Launch instance" button to begin the instance creation wizard.

Figure 1: Initiating a new EC2 instance launch from the EC2 Dashboard
<img width="951" alt="image" src="https://github.com/user-attachments/assets/ffe03705-bcfd-420c-9593-fb4914316c39" />

**Choose an Amazon Machine Image(AMI:**
To create LeGout, select the Ubuntu Server and ensure it's free tier eligible to save costs.

**Choose an Instance Type:**
Select the t2.micro instance type
<img width="944" alt="image" src="https://github.com/user-attachments/assets/e1351277-2cc1-4313-8fa8-d8d9c15ece8a" />


**Configure Instance:**
Since this is a simple food vlog, some default settings are fine 

**Storage:** The default storage is okay; this can always be increased later for content that requires more space, such as high-resolution images. For now, 8 GB is  okay.

**Name Tag:** add a tag
Name: Le Gout food vlog  to easily identify the instance.

### Configure Security Group:##

This is very crucical.creat a new security group
Add Rules SSH (Port 22): Allows a secure connection to the instance via the command line.
HTTP (Port 80): Allows web traffic (unencrypted).
HTTPS (Port 443): Allows secure web traffic (encrypted): Allow SSH Access).
give the security group a descriptive name (e.g., legoutSG) 

<img width="946" alt="image" src="https://github.com/user-attachments/assets/f3406415-007c-4712-ba6b-ffc15aed91e1" />



**Key Pair:** Create a New Key Pair
a prompt to create a new key pair (a .pem file). should show up
This is essential for securely connecting to the instance.
Download Key Pair: immediately and store it in a secure, private location.
This is the only means to securely connect to the instance via SSH.Without it,access to the server will be impossible.
<img width="933" alt="image" src="https://github.com/user-attachments/assets/8e56b262-b1a6-4442-9392-afaa9f314696" />
after reviewing all seetings click on Launch instances
<img width="587" alt="image" src="https://github.com/user-attachments/assets/ebd419e8-3d3e-4158-b16c-15e9586c6ee9" />


## Allocate and associate elastic IP 
By defult ,EC2 instances are assigned a dynamic public IP address that changes upon stopping and starting the instance. To ensure a consistent and persisten public IP address for Le Gout, an Elastic IP was allocated and associated to easly access the server even after a restart.

Navigate to the **EC2 Dashboard > Network & Security > Elastic IPs**
Click **Allocate Elastic IP**, then **Associate** it with the instance.
<img width="956" alt="image" src="https://github.com/user-attachments/assets/4b325639-69bb-4e45-a9a3-4e66cbcdf619" />

<img width="944" alt="image" src="https://github.com/user-attachments/assets/ec084f24-7916-4a84-b541-45c5761c92cf" />

<img width="959" alt="image" src="https://github.com/user-attachments/assets/b19f12fd-a00e-4f88-a596-cea660e03ccb" />


## Connect to server & Configure
on the local machine, navagate to the directory where the keypair.pem file is saved.
### SSH into the EC2 Instance
connect to the EC2 instance using SSH


```
ssh -i "your-key.pem" ubuntu@<EC2-Public-IP>
confirm connection to the server 
```
Confirm the connection by verifying the terminal prompt change to the servers' hostname.
## Update Instance##
Once connected,  update the server this will address any potential security vulnerabilities and ensures access to the newest features and bug fixes.

```
sudo apt update
sudo apt upgrade -y
```
## Install Apache ##
```
sudo apt install apache2 -y
```

Test Apache: Open a web browser and navigate to EC2 instance's public IPV4 address,this will take you to the default Apache page.this confirms that apacge is running and the security group is correctly allowing http traffic. connect to the EC2 instance using SSH with the previously created key pair.


<img width="949" alt="image" src="https://github.com/user-attachments/assets/9301e232-66e6-4e0b-8080-9f787d6682d7" />

## Deploy "Le Gout" HTML Content
once apache is succeffully installed and verified replace the default welcome page with the custom HTML content for Le Gout.

## Edit index.html on the Webserver ##
connect to the EC2 instance via SSH
navigate to the default Apache web root directory and remove the existing default index.html file, back the file before removal.

```
cd /var/www/html/
ls -l
sudo mv index.html index.html.bak
paste cstome HTML code in the files
```
## Register a Domain Name:##
Create a Hosted Zone
In the AWS console, search for and navigate to "Route 53"
in the left navigation pane,under DNS management,Click on hosted zones.
click create hosted zone button.
Enter domain name (Legout.click).in the domain field.
select public hosted zone for the type. click create hosted zone.

##Create DNS Records in Route 53:##
In Route 53 hosted zone, click "Create record."
Record type: A (IPv4)
Value: Enter  EC2 instance's Public IP address.
Routing policy: Simple routing
Click "Create records."
Note: It can take a few minutes to up to 48 hours for DNS changes to propagate across the internet.periodically teste the domain in the browser.

## Setting Up HTTPS with SSL#
Implementing HTTPS is very crucial for website security and user trust.
an SSL certificate is Essential to  enable HTTPS (secure connection).

Install Certbot 

```
sudo apt update
sudo apt install certbot python3-certbot-apache -y
sudo certbot --apache

```
##Follow the prompts##
Enter email address: Enter a vaild email for urgent renewal notices and security warnings.
Terms of service: Agree to the let's Encrypt terms of service.
Enter your domain name (e.g.,legout.click).
redirect HTTP to HTTPS (recommended: "2: Redirect").
Automatic Renewal this will ensure that all vistors use the secure connection.
open a web brower and navigate to http://legout.click.
The browser will automatically redirected to https://legout.click
check for the padlock icon in the browser address bar,indicating a secure,encrypted connection.This confirms that HTTPS is Successfully enabled and working.

## Firewall ##
To further enchance the security of Le Gout server beyond AWS security Groups a software firewall(ufw)will provide additional layer of defense.
connect to EC2 instance via SSH
scp -i your-key.pem * ubuntu@<EC2-IP>:/var/www/html/
Enable Firewall
```
sudo ufw allow ssh
sudo ufw allow 'Apache Full'
sudo ufw enable
sudo ufw status
sudo apt update && sudo apt upgrade -y
```

## Automate Content Deployment Script
To streamline future updates to Le Gout a simple shell scrip was created to automate the transfer of new HTML files.

This deploy_legout.sh script automates the secure transfer of the entire "Le Gout" website content to the production server. It leverages scp (Secure Copy Protocol) to copy files from a specified local directory to the Apache web root on the EC2 instance. After transfer, it ensures correct file ownership and permissions for the Apache web server (www-data user) to maintain proper functionality and security.

## References##
Certbot Apache—https://certbot.eff.org/instructions
Simplefood-https://simplefood.blog/














