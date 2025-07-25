# ANSIBLE DEPLOYMENT

## variabes

### hosts of deployment

edit file ansible/inventory/hosts, add all the servers where the service will be deployed

### variables of deployment

 edit file ansible/inventory/vars.yml with
    - gituser: username of git user with rights in repository
    - gitpass: values of a git token
    - build: values possible is true or false, (true: when you want to build docker image before deployment)
    - branch: branch name , tags name or commit values with the code to deploy