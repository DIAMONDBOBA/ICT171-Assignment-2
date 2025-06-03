 
# Le Gout - Cloud Food Blog & Cultural Journal
A Step-by-step guide to deploying the ** Le Gout** food blog on AWS using an EC2 instance, Apache, Route 53 DNS, and SSL via Certbot.

>**Author:** Sarah Katuku

>**Student ID:** 35396921

## Launching EC2 Instance ##
If you don't already have an AWS account, please create one. Keeping in mind that this may take some time.
## Log in to the Amazon EC2 Management Console ##
>Log in to the AWS management console: https://aws.amazon.com/ec2/
Navigate to the EC2 Dashboard and in the search bar at the top, type "EC2" and select it from the
results.from the EC2 Dashboard, click on the launch instance button to create the instance.

### Launch Instance
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
There will be no access to via SSH without it,server will be unaccessable.
<img width="933" alt="image" src="https://github.com/user-attachments/assets/8e56b262-b1a6-4442-9392-afaa9f314696" />
after reviewing all seetings click on Launch instances
<img width="587" alt="image" src="https://github.com/user-attachments/assets/ebd419e8-3d3e-4158-b16c-15e9586c6ee9" />


## Allocate and associate elastic IP 
To  easly access the server even after a restart:
Go to **EC2 Dashboard > Network & Security > Elastic IPs**
Click **Allocate Elastic IP**, then **Associate** it with the instance.
<img width="956" alt="image" src="https://github.com/user-attachments/assets/4b325639-69bb-4e45-a9a3-4e66cbcdf619" />

<img width="944" alt="image" src="https://github.com/user-attachments/assets/ec084f24-7916-4a84-b541-45c5761c92cf" />

<img width="959" alt="image" src="https://github.com/user-attachments/assets/b19f12fd-a00e-4f88-a596-cea660e03ccb" />



## Connect to server & Configure
### SSH into the EC2 Instance
ssh -i "your-key.pem" ubuntu@<EC2-Public-IP>
confirm connection to the server 

## Update Instance##
Once connected,  update the server:

bash
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


## Edit index.html on the Webserver ##

cd /var/www/html/
ls -l
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



















