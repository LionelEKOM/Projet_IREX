#!/bin/bash

export CERT_FOLDER=/etc/letsencrypt/live/$STEP_CLIENT_NAME

sudo apt-get update --allow-releaseinfo-change -y

function get_cert_by_step()
{
    sudo hostnamectl set-hostname $STEP_CLIENT_NAME
    ###get certificates from client
    echo "clone the step-client repo.."
    if [[ -z $GIT_PASS ]]
    then
        git clone $URL_REPO $HOME/step-ca-client;
    else
        git clone  https://$GIT_USER:$GIT_PASS@$URL_REPO $HOME/step-ca-client;
    fi

    echo "end clone repo.."

    echo "enter to the directory..."
    cd $HOME/step-ca-client

    echo "modify the default.conf.."

    sed -i.bak -e "s#STEP_CA_HOST=.*#STEP_CA_HOST=$STEP_CA_HOST#g" $HOME/step-ca-client/Conf/conf.defaults
    sed -i -e "s#STEP_CLIENT_NAME=.*#STEP_CLIENT_NAME=$STEP_CLIENT_NAME#g" $HOME/step-ca-client/Conf/conf.defaults
    sed -i -e "s#STEP_CA_IP=.*#STEP_CA_IP=$STEP_CA_IP#g" $HOME/step-ca-client/Conf/conf.defaults
    sed -i -e "s#PORT_ACCESS=.*#PORT_ACCESS=$PORT_ACCESS#g" $HOME/step-ca-client/Conf/conf.defaults
    sed -i -e "s#STEP_CA_USER=.*#STEP_CA_USER=\"$STEP_CA_USER\"#g" $HOME/step-ca-client/Conf/conf.defaults
    sed -i -e "s#STEP_CA_PASS_USER=.*#STEP_CA_PASS_USER=\"$STEP_CA_PASS_USER\"#g" $HOME/step-ca-client/Conf/conf.defaults

    echo "run main client script.."
        ./MainScript.sh
    echo "end run main script client.."
}

function get_cert_by_openssl()
{
    sudo mkdir -p $CERT_FOLDER 
    sudo openssl req -nodes -newkey rsa:2048 -keyout $CERT_FOLDER/privkey.pem -out $CERT_FOLDER/fullchain.pem -subj "/C=$COUNTRY/ST=$STATE/L=$LOCATION/O=$ORGANIZATION/OU=$ORGANIZATION_UNIT/CN=$COMMON_NAME"    
}


function launch()
{
    case $CERT_SOURCE in

    step)
        echo "get cert with step"
        get_cert_by_step
    ;;

    openssl)
        echo "get cert with openssl"
        get_cert_by_openssl
    ;;

    *)
        echo "no option choice"
        exit 0;
    ;;
    esac
}


if [[ -d "$CERT_FOLDER" ]]
then
    echo "$DIR directory exists. cert already exists..."
    echo "pass to anothers scripts"
else
    echo "cert not exists."
    get_cert_by_step
fi

if [[ -d "$CERT_FOLDER" ]]
then
    echo "nice........."
else
    echo "certificates creation has failed"
fi




