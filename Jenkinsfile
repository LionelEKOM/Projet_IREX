properties ([
    parameters ([
        string (
            defaultValue: 'drive.dev.onesi.ca',
            description: 'hostname of vm use to deploy service',
            name : 'DEPLOY_VM'),
        string (
            defaultValue: 'debian',
            description: 'user use to deploy service ',
            name : 'DEPLOY_USER'),
        string (
            defaultValue: 'debian',
            description: 'password of user using durig deployment',
            name : 'DEPLOY_USER_PASS'),
        string (
            defaultValue: 'dev.onesi.ca',
            description: 'domaine of service use during deployment',
            name : 'DOMAIN_SERVICE'),
        string (
            defaultValue: 'webmail.dev.onesi.ca',
            description: 'mail server hostname',
            name : 'MAIL_SERVER'),
        string (
            defaultValue: 'ldap.dev.onesi.ca',
            description: 'hostname of ldap server',
            name : 'LDAP_HOSTNAME'),
        string (
            defaultValue: 'dc=dev,dc=onesi,dc=ca',
            description: 'ldap base in ldap server',
            name : 'LDAP_BASE'),
        string (
            defaultValue: 'cn=admin,dc=dev,dc=onesi,dc=ca',
            description: 'ldap admin user in ldap server',
            name : 'LDAP_ADMIN'),
        string (
            defaultValue: 'password',
            description: 'password of admin account',
            name : 'LDAP_PASSWORD'),
        string (
            defaultValue: 'dev',
            description: 'branch of pipeline projet use to deploy certificate',
            name : 'CERT_BRANCH'),
        string (
            defaultValue: 'https://keycloak.dev.onesi.ca',
            description: 'keycloak  URL service',
            name : 'KEYCLOAK_URL'),
        string (
            defaultValue: 'admin',
            description: 'username of admin user keycloak',
            name : 'KEYCLOAK_ADMIN_USERNAME'),
        string (
            defaultValue: 'password',
            description: 'password  of admin user keycloak',
            name : 'KEYCLOAK_ADMIN_PASSWORD'),
        string (
            defaultValue: 'IREX',
            description: 'realm name ',
            name : 'KEYCLOAK_CLIENT_REALM'),
        string (
            defaultValue: 'DRIVE ONESI',
            description: 'Keycloak CLIENT NAME',
            name : 'KEYCLOAK_CLIENT_NAME'),
        string (
            defaultValue: 'https://drive.dev.onesi.ca/*',
            description: 'redirect uri after login',
            name : 'KEYCLOAK_CLIENT_REDIRECT_URI')
    ])
])

node('ansible-node') {    
    scmVars = checkout scm
    stage('SonarQube Analysis') {
        def scannerHome = tool 'SonarScanner';
        withSonarQubeEnv() {
            sh "${scannerHome}/bin/sonar-scanner"
        }
    }
    sh 'mkdir -p /tmp/step-ca-client'
	dir("/tmp/step-ca-client")
    {
        script{
            checkout([$class: 'GitSCM',
                branches: [[name: '*/$CERT_BRANCH']],
                doGenerateSubmoduleConfigurations: false,
                extensions: [[$class: 'CleanBeforeCheckout'],
                [$class: 'CloneOption', depth: 1, noTags: false, reference: '', shallow: true]], 
                submoduleCfg: [], 
                userRemoteConfigs: [[credentialsId: 'global-id-token', url: 'https://gitface.irex.aretex.ca/irex-docker-projects/mirroring-iaas-projects/authentication/step-ca-client.git']]])           
        }
    }
    get_certs()
    generate_conf()
    deploy()

}

def deploy() {
    stage 'Deploying Service'
    sh '''
        ansible-playbook -i ansible/inventory ansible/nextcloud.yml -v
        '''
    sleep 90
    sh '''
    while ! ping -c1 $DEPLOY_VM &>/dev/null
        do sleep 10;echo "Wait $DEPLOY_VM restarting "
    done
    '''
}

def generate_conf(){
    stage 'generate configuration'
    sh '''
    ansible-playbook cicd/utilies/setconf.yml -v
    '''
}
def get_certs(){
    stage 'generate certificate'
    def certificates = load '/tmp/step-ca-client/cicd/functions/certificates.groovy'
    certificates.deploy()
}
