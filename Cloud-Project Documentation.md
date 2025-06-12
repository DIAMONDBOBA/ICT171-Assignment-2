 
# Le Gout - Cloud Food Blog & Cultural Journal
A Step-by-step guide to deploying the ** Le Gout** food blog on Amazon Web Services(AWS)using an EC2 instance, Apache web server, Route 53 for Domain Name System (DNS) management, and SSL/TLS encryption via Certbot.This documentation aims to be sufficiently detailed to allow an IT colleague or another ICT171 student to replicate the deployment from scratch.

>**Author:** Sarah Katuku

>**Student ID:** 35396921

>**Domain:** https://legout.click


# Introduction
This document outlines the process of setting up Le Gout, a personal food blog and cultural journal. The goal is to create an online presence that showcases culinary experiences and provides a platform for cultural sharing.

# Launching EC2 Instance 
If you don't already have an AWS account, please create one. Keeping in mind that this may take some time.

# Log in to the Amazon EC2 Management Console 
Log in to the AWS management console: https://aws.amazon.com/ec2/
Navigate to the EC2 Dashboard by searching for "EC2" and selecting it from the results.

# Launch Instance 
From the EC2 Dashboard, click on the "Launch instance" button to begin the instance creation wizard.

Figure 1: Initiating a new EC2 instance launch from the EC2 Dashboard
<img width="951" alt="image" src="https://github.com/user-attachments/assets/ffe03705-bcfd-420c-9593-fb4914316c39" />

# Choose an Amazon Machine Image(AMI:)
To create LeGout, select the t2.micro instance type to utilize AWS Free Tier benefits.

Select the t2.micro instance type

Figure 2: Selection of Ubuntu Server AMI and t2.micro instance type.
<img width="944" alt="image" src="https://github.com/user-attachments/assets/e1351277-2cc1-4313-8fa8-d8d9c15ece8a" />


## Configure Instance:
Since this is a simple food vlog, some default settings are fine 

## Storage:
The default storage is okay; this can be increased later for content requiring more space, such as high-resolution images. For now, 8 GB is  okay.

# Name Tag: add a tag
Name: Le Gout Food Vlog Server for easy identification.

**Configure Security Group:**

This is very crucial. Create a new security group
Add Rules SSH (Port 22): Allows a secure connection to the instance via the command line.
HTTP (Port 80): Allows web traffic (unencrypted).
HTTPS (Port 443): Allows secure web traffic (encrypted): Allow SSH Access.
Give the security group a descriptive name (e.g., legoutSG) 

Figure 3: Inbound rules configured for the LeGoutWebServerSG to allow SSH, HTTP, and HTTPS traffic.

<img width="946" alt="image" src="https://github.com/user-attachments/assets/f3406415-007c-4712-ba6b-ffc15aed91e1" />



**Key Pair:** Create a New Key Pair
A prompt to create a new key pair (a PEM file). should show up
This is essential for securely connecting to the instance.
Download Key Pair: immediately and store it in a secure, private location.
This is the only means to securely connect to the instance via SSH. Without it, access to the server will be impossible.


Figure 4: Creation and download of the AWS key pair.pem for secure SSH access.
<img width="933" alt="image" src="https://github.com/user-attachments/assets/8e56b262-b1a6-4442-9392-afaa9f314696" />


# Review all configured settings.
Confirm the launch by clicking the "Launch instances" button
<img width="587" alt="image" src="https://github.com/user-attachments/assets/ebd419e8-3d3e-4158-b16c-15e9586c6ee9" />


# Allocating and Associating an Elastic IP Address
EC2 instances receive dynamic public IP addresses by default. To ensure a consistent and persistent public IP for "Le Gout," an Elastic IP was allocated and associated.

Navigate to EC2 Dashboard > Network & Security > Elastic IPs.
Click "Allocate Elastic IP address".
Select the newly allocated Elastic IP, click "Actions," then "Associate Elastic IP address."
Select the Le Gout Food Vlog Server instance and confirm the association.

Figure 6: Initiating Elastic IP allocation.
<img width="956" alt="image" src="https://github.com/user-attachments/assets/4b325639-69bb-4e45-a9a3-4e66cbcdf619" />


After allocation, select the newly allocated Elastic IP, click "Actions," then "Associate Elastic IP address.

Figure 7: Associating the Elastic IP with the running EC2 instance.
<img width="944" alt="image" src="https://github.com/user-attachments/assets/ec084f24-7916-4a84-b541-45c5761c92cf" />

Select  the Le Gout Food Vlog Server instance from the dropdown menu and confirm the association

Figure 8: Confirmation of Elastic IP association details
<img width="959" alt="image" src="https://github.com/user-attachments/assets/b19f12fd-a00e-4f88-a596-cea660e03ccb" />


# Connect to server & Configure
Open the terminal on the local machine.
Set restrictive permissions for the private key file.

This makes the key file readable only by the owner, a critical security requirement for SSH.

On the local machine, navigate to the directory where the keypair.pem file is saved.

```
chmod 400 /home/cd/Awskeypair.pem
```
# SSH into the EC2 Instance
Connect to the EC2 instance via SSH
Confirm connection by verifying the terminal prompt changed to the server's hostname.

```
ssh -i "your-key.pem" ubuntu@<EC2-Public-IP>
```
# Update Instance
Once connected,  update the server. This will address any potential security vulnerabilities and ensure access to the newest features and bug fixes.

```
sudo apt update
sudo apt upgrade -y
```
Figure 10: Terminal output showing successful package update and upgrade process.

<img width="746" alt="image" src="https://github.com/user-attachments/assets/d2165bdc-7c2c-4361-b6c7-a1d1f03717ff" />



# Install Apache 
Install the Apache web server package on the Ubuntu server.
```
sudo apt install apache2 -y
```
Figure 11: Terminal output showing Apache2 installation process

<img width="590" alt="image" src="https://github.com/user-attachments/assets/8133f2e7-6254-426f-904b-153679922fec" />

# Verify Apache Installation
Test Apache: Open a web browser and navigate to the EC2 instance's public IPV4 address, which will take you to the default Apache page. This confirms that Apache is running and the security group is correctly allowing HTTP traffic. Connect to the EC2 instance using SSH with the previously created key pair.


Figure 12: Default Apache2 welcome page confirming successful web server installation and accessibility.
<img width="949" alt="image" src="https://github.com/user-attachments/assets/9301e232-66e6-4e0b-8080-9f787d6682d7" />

# Deploy "Le Gout" HTML Content
Once Apache is successfully installed and verified, replace the default welcome page with the custom HTML content for Le Gout.

# Edit index.html on the web server 
Connect to the EC2 instance via SSH,
navigate to the default Apache web root directory, and remove the existing default index.html file. Back up the file before removal.

```
cd /var/www/html/
ls -l
sudo mv index.html index.html.Back
Paste custom HTML code in the files
```

Figure 13: Terminal output showing the initial contents of the /var/www/html/ directory and backup of the default index.html.

<img width="743" alt="Screenshot 2025-06-07 200847" src="https://github.com/user-attachments/assets/41085c8c-aa2f-44c2-86b0-5a5ad33bdd94" />

Figure 14: Terminal output confirming the contents of the /var/www/html/ directory after
<img width="772" alt="Screenshot 2025-06-07 200929" src="https://github.com/user-attachments/assets/77359d13-f9f5-406b-b10b-629b52d839c9" />


# Register a Domain Name:
Create a Hosted Zone
In the AWS console, search for and navigate to "Route 53."
In the left navigation pane, under DNS management, click on hosted zones.
Click the Create Hosted Zone button.
Enter domain name (Legout.click). In the domain field.
Select a public hosted zone for the type. Click Create Hosted Zone.


Figure 15: Creation of a Public Hosted Zone for legout. Click on Route 53.
<img width="955" alt="image" src="https://github.com/user-attachments/assets/85b63266-3db4-486d-8261-a7dda3d869be" />


# Create DNS Records in Route 53:
In the Route 53 hosted zone, click "Create record."
Record type: A (IPv4)
Value: Enter  the EC2 instance's Public IP address.
Routing policy: Simple routing
Click "Create records."
Note: It can take a few minutes to up to 48 hours for DNS changes to propagate across the internet.periodically teste the domain in the browser.


Figure 16: Configuration of the A record to map legout. Click on the EC2 instance's Elastic IP.
<img width="939" alt="image" src="https://github.com/user-attachments/assets/b49be897-aa1b-4c7b-8a8a-87b10addf6a2" />



# Setting Up HTTPS with SSL
Implementing HTTPS is very crucial for website security and user trust.
An SSL certificate is Essential to  enable HTTPS (secure connection).

Install Certbot 

```
sudo apt update
sudo apt install certbot python3-certbot-apache -y
sudo certbot --apache

```
# Follow the prompts
Enter email address: Enter a valid email for urgent renewal notices and security warnings.
Terms of service: Agree to the Let's Encrypt terms of service.
Enter your domain name (legout.click).
redirect HTTP to HTTPS (recommended: "2: Redirect").
Automatic Renewal: This will ensure that all visitors use the secure connection.
Open a web browser and navigate to http://legout.click.
The browser will automatically be redirected to https://legout.click
Check for the padlock icon in the browser address bar, indicating a secure, encrypted connection. This confirms that HTTPS is successfully enabled and working.

Figure 17: Certbot prompts during SSL certificate issuance and configuration for Apache.

<img width="752" alt="Screenshot 2025-06-07 203653" src="https://github.com/user-attachments/assets/6255fb51-e301-460a-bf0a-c113f5bf686d" />


# Firewall 
To further enhance the security of the Le Gout server beyond AWS security Groups, a software firewall(ufw)will provide an additional layer of defense.
Connect to EC2 instance via SSH
, scp -i your-key.pem * ubuntu@<EC2-IP>:/var/www/html/
Enable Firewall
```
sudo ufw allow ssh
sudo ufw allow 'Apache Full'
sudo ufw enable
sudo ufw status

```

Figure 18: Terminal output showing UFW firewall configuration and status

<img width="797" alt="image" src="https://github.com/user-attachments/assets/1cc4ebea-97b2-4e9c-9ea1-38d65b250a98" />


# Automate Content Deployment Script

This deploy_legout.sh script automates the secure transfer of the entire "Le Gout" website it securly transfers all alocal HTML,CSS nd images files from the local computer to the AWS EC2 instance's Apache web root(/var/www/html) after tranfere it ensures correct file ownership and permissions for the Apache web server (www-data user) to maintain proper functionality and security.

Second Script Favorite food
This script prompts the user to enter their the name of their favorite food and displays it back to them.


<img width="860" alt="Screenshot 2025-06-06 204409" src="https://github.com/user-attachments/assets/8341d717-4051-42ad-98c5-1dea98068fda" />


# Conclusion
This documentation details the complete depolyment of Le Gout, using AWS EC2 instances,and configuration of the Apache web server along with the intergration of Route 53 for Domain Name resolution and the implemenation of SSL/TLS encryption using Certbot.Le Gout can be re created by any one and is easily updatable throught the use of the deployement script.


# References##
Certbot Apache—https://certbot.eff.org/instructions

Simplefood-https://simplefood.blog/

codecademy - https://www.codecademy.com/catalog/language/html-css

















