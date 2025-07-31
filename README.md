# Roadmap Deployment step


### 1. Install git


  **```sudo apt install git-all```**
  

### 2. clone the project


  **```git clone https://gitface-prod.irex.aretex.ca/irex-docker-projects/mirroring-iaas-projects/drive/nextcloud.git```**
  

### 3. go the nextcloud directory and switch to the branch master


  **```cd nextcloud```**

  **```git checkout install_vm```**
  

4. customize the conf.defaults file with your own information (administrator credentials, ldap, mysql, cache configuration, mail server, step-ca esrver, git user...)



The meanings of the most modified variables:

DB_USER_NAME: It is the name of the user of the DB on which the service will be installed.

DB_NAME: name of the DB

DB_PASSWORD: This is the password of the user of the DB on which the service will be installed.


Change the version of nextcloud according to your needs with the variable VERSION.


PHP_VERSION: to change the PHP version but the minimum required is 7.1.


ADMIN_LOG: the name of the administrator of the service to fill in when connecting to the service.

ADMIN_PASS: the service administrator's password to be entered when connecting to the service.

DRIVE_DIR: nextcloud installation directory

DATA_DIR: installation directory of the data file

DOMAIN_NAME: configure hostname


THEME_NAME: change theme name


MAIL_MODE: change the communication protocol for mail exchange by default leave smtp.

MAIL_SERVER: the server's email address 


MAIL_SERVER_DOMAIN=the hostname of the mail server

MAIL_TIMEOUT: Increase the server timeout if a malware or SPAM scanner is running


PASSWORD: ldap connection password

PORT: ldap port

BASEDNUSER: ldap login user

HOST: the hostname to access ldap 

GIT_USER: insert your user on Gitlab

GIT_PASS: insert your Gitlab token


5. as root user, run the main.sh script


chmod +x main.sh

sudo ./main.sh 2>&1 | tee ~/drive_main.log

you will have installation logs in logs directory


6. Make sure dns resolution is working on your server


sudo apt install dnsutils // install dns tools

dig $HOSTNAME

or nslookup $HOSTNAME // should return a results containing your hostname and your ip address

The commands bellow will show your hostname

echo $HOSTNAME // show your hostname

hostname -i // show your ip address

Make on resolution is ok before the next step



7. navigate to https://your_hostname/


8. log in with ldap(here ldap dev) or admin credentials (admin credentials can be found in the conf.defaults file)



9. log as administrator and go the admin settings -> overviews to make sure all your setup is good, then go bellow to Basic Settings and click on the send mail button to test mail server configuration



10. enjoy nextcloud!
