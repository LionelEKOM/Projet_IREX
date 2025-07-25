==Docker Deployment steps==

1. Install git 

  sudo apt install git-all

2. Clone the project

  git clone https://gitface-prod.irex.aretex.ca/irex-docker-projects/mirroring-iaas-projects/drive/nextcloud.git

3. In order to build your dirve/drivesetup image go the sub-directory Irex_drive or Drive_setup of docker and switch to the branch master

  cd nextcloud/docker/Irex_drive or cd  nextcloud/docker/Drive_setup

  git checkout master

4. Customize the conf.defaults file (in Irex_drive) with your own information (administrator credentials, ldap, mysql, cache configuration, mail server, step-ca esrver, git 

  Note for the moment Php and nexcloud version should be keep as it. To change this version you should change Irex_drive dockerfile and confirme the value inside the conf.defaults.

5. Run the docker_main.sh script for build your image. You need to configure docker for using without sudo.

  bash docker_main.sh 2>&1 | tee ~/build.log 

  Command to run this image is also inside the docker_main.sh script but it is commented. Just copy it and run your image individually if you want.

  Instead of building your own images, you can retrive existing ones from the registry with 

  Ex : 
     docker pull registry-prod.irex.aretex.ca/irex-docker-projects/mirroring-iaas-projects/drive/nextcloud/drivesetup:v1.0

     docker pull registry-prod.irex.aretex.ca/irex-docker-projects/mirroring-iaas-projects/drive/nextcloud/drive:v22.2.0_1.0

     N.B: Make sure you are logged into the registry and pull each time lastest version of images available.

6. Make sure dns resolution is working on your server

  sudo apt install dnsutils // install dns tools
 
  dig $HOSTNAME 
        or 
  nslookup $HOSTNAME // should return a results containing your hostname and your ip address

  The commands bellow will show your hostname
 
  echo $HOSTNAME // show your hostname
 
  hostname -i // show your ip address
  
  Make sur resolution is ok before the next step

7. Launch the drvive docker using the docker-start.sh script which launch the docker-compose file. But before make sure that the port and images names are as you want in Docker_compose/docker-compose.yml file.

   bash docker-start.sh 

   N.B: There are also script for stopping and remove containers 

         - bash docker-stop.sh 
  
         - bash docker-cleanup.sh 

   Follow logs. The way to do this is given add the end of the docker-start.sh script execution.

8. Navigate to https://your_hostname:8080 (if 8080 is the exposed port for nginx).

9. Log in with ldap(here ldap dev) or admin credentials (admin credentials can be found in the conf.defaults file).

10. Log as administrator and go the admin settings -> overviews to make sure all your setup is good, then go bellow to Basic Settings and click on the send mail button to test mail server configuration
 
11. Enjoy nextcloud!!
