
# Le Gout - Cloud Food Blog & Cultural Journal
A Step-by-step guide to deploying the ** Le Gout** food blog on AWS using an EC2 instance, Apache, Route 53 DNS, and SSL via Certbot.

>**Author:** Sarah Katuku

>**Student ID:** 35396921

## Launching EC2 Instance ##
If you don't already have an AWS account, please create one. Keeping in mind that this may take some time.
## Log in to the Amazon EC2 Management Console ##
>Log in to the AWS management console: https://aws.amazon.com/ec2/
Navigate to the EC2 Dashboard and in the search bar at the top, type "EC2" and select it from the
results.

### Launch Instance
-**Choose an Amazon Machine Image(AMI:**
To create LeGout, select the Ubuntu Server and ensure it's free tier eligible to save costs.

-**Choose an Instance Type:**
Select the t2.micro instance type
-**Configure Instance:**
Since this is a simple food vlog, some default settings are fine 

-**Storage:** The default storage is okay; this can always be increased later for content that requires more space, such as high-resolution images. For now, 8 GB is  okay.


-**Name Tag:** add a tag
Name: Le Gout food vlog  to easily identify the instance.

### Configure Security Group:##

_**Key Pair:** Create a New Key Pair
a prompt to create a new key pair (a .pem file). should show up
This is essential for securely connecting to the instance.
Download Key Pair: immediately and store it in a secure, private location. It cannot be downloaded again. if lost, you'll be locked out of the instance.

### Configure Security Group:##
Add Rules SSH (Port 22): Allows a secure connection to the instance via the command line.
HTTP (Port 80): Allows web traffic (unencrypted).
HTTPS (Port 443): Allows secure web traffic (encrypted): Allow SSH Access").

## Allocate and associate elastic IP 
To keep easly access the server even after a restart:
Go to **EC2 Dashboard > Network & Security > Elastic IPs**
Click **Allocate Elastic IP**, then **Associate** it with the instance.


## Connect to server & Configure
### SSH into the EC2 Instance

```
bash
ssh -i "your-key.pem" ubuntu@<EC2-Public-IP>

## Update Instance
Once connected,  update the server:
sudo apt update
sudo apt upgrade -y

## Install Apache ##

sudo apt install apache2 -y
Test Apache: Open a web browser and navigate to legout ip address and be able to should see the Apache default page.


## Edit index.html on the Webserver ##
sudo nano /var/www/html/index.html
paste cstome HTML code

## Register a Domain Name:##
Create a Hosted Zone
In the AWS console, search for "Route 53" and go to "Hosted zones."
Click "Create hosted zone."
Enter domain name (Legout.click).

##Create DNS Records in Route 53 ##
In Route 53 hosted zone, click "Create record."
Record type: A (IPv4)
Value: Enter  EC2 instance's Public IP address.
Routing policy: Simple routing
Click "Create records."
Note: It can take a few minutes to up to 48 hours for DNS changes to propagate across the internet.


## Setting Up HTTPS with SSL#
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

## Automated Deployment
to simplify any future updates

scp -i your-key.pem * ubuntu@<EC2-IP>:/var/www/html/
Enable Firewall
sudo ufw allow 'Apache Full'
sudo ufw enable
sudo apt update && sudo apt upgrade -y



















