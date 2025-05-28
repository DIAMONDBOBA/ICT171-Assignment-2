```
_____    __      __   _________ ____________________  ________   .___                   __                                   
   /  _  \  /  \    /  \ /   _____/ \_   _____/\_   ___ \ \_____  \  |   |  ____    _______/  |_ _____     ____    ____    ____  
  /  /_\  \ \   \/\/   / \_____  \   |    __)_ /    \  \/  /  ____/  |   | /    \  /  ___/\   __\\__  \   /    \ _/ ___\ _/ __ \ 
 /    |    \ \        /  /        \  |        \\     \____/       \  |   ||   |  \ \___ \  |  |   / __ \_|   |  \\  \___ \  ___/ 
 \____|__  /  \__/\  /  /_______  / /_______  / \______  /\_______ \ |___||___|  //____  > |__|  (____  /|___|  / \___  > \___  >
         \/        \/           \/          \/         \/         \/           \/      \/             \/      \/      \/      \/ 
```

## Launching EC2 Instance ##
If you don't already have an AWS account, please create one. This may take some time.
## Log in to the Amazon EC2 Management Console ##
Log in to the AWS management console: https://aws.amazon.com/ec2/
Navigate to the EC2 Dashboard and in the search bar at the top, type "EC2" and select it from the
results.
## Launch an Ubuntu Machine in EC2 ##
Click on the "launch instance" button.
Choose an Amazon machine image (AMI):##
Select Ubuntu, make sure it is marked as free tier eligible (got to save money)
Choose an Instance Type: select the t2.micro and make sure it is a free tier eligible.
## Configure Instance Details ##
Network: Leave as default:
Auto-assign Public IP: Enable 
Add storage:8 GiB
Add Tags Add a Name tag (Le Gout)
##Configure Security Group:##
Add Rules SSH (Port 22): Allows a secure connection to the instance via the command line.
HTTP (Port 80): Allows web traffic (unencrypted).
HTTPS (Port 443): Allows secure web traffic (encrypted)
Description: ( "Allow SSH Access").
## Review and Launch:##
Review all settings.
Click "Launch."
## Create a New Key Pair:##
a prompte to create a new key pair (a .pem file). should show up
This is essential for securely connecting to the instance.

Download Key Pair: immediately and store it in a secure, private location. it cannot download it again. if lost, you'll be locked out of the instance.
Click "Launch Instances."
## onnect via SSH:##
Open a terminal (CMD OR POWER SHELL)
Navigate to the directory where thes .pem file. is saved.

## Update Instance:##
Once connected, it's good practice to update the server:
sudo apt update
sudo apt upgrade -y

## Install Apache ##

sudo apt install apache2 -y
Test Apache: Open a web browser and navigate to legout ip address and be able to should see the Apache default page.


## Edit index.html on the Webserver ##
sudo nano /var/www/html/index.html

## Register a Domain Name:##
Create a Hosted Zone
In the AWS console, search for "Route 53" and go to "Hosted zones."
Click "Create hosted zone."
Enter domain name (Legout.click).

##Create DNS Records in Route 53 ##
In Route 53 hosted zone, click "Create record."
A record:
Record name: Leave blank 
Record type: A
Value: Enter  EC2 instance's Public IP address.
Routing policy: Simple routing
Click "Create records."
Plase note It can take a few minutes to up to 48 hours for DNS changes to propagate across the internet.


## Setting Up HTTPS with SSL/TLS#
an SSL certificate is Essential to  enable HTTPS (secure connection).
Install Certbot 
sudo apt update
sudo apt install certbot python3-certbot-apache -y
Run Certbot:
sudo certbot --apache
Follow the prompts:
Enter email address.
Agree to terms of service.
Enter your domain name (e.g.,legout.click).
redirect HTTP to HTTPS (recommended: "2: Redirect").
Automatic Renewal


















