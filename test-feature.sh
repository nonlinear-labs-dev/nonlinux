#!/bin/sh

################################
# help
if [ "$#" -lt "2" ]
then
    echo "$0 <feature-branch> <SSID-of-target-instrument> [<passphase>]"
    exit 1
fi


################################
# try to find network with given ssid
nmcli device wifi list | grep " $2 " > /dev/null

if [ "$?" -ne "0" ]
then
    echo "Network '$2' could not be found."
    exit 1
fi

################################
# try to checkout requested branch
cd output/build/playground-HEAD
git checkout $1 > /dev/null 2>&1

if [ "$?" -ne "0" ]
then
    echo "Branch '$1' could not be checked out."
    exit 1
fi

################################
# try to pull requested branch
git pull origin $1 > /dev/null 2>&1

if [ "$?" -ne "0" ]
then
    echo "Branch '$2' could not be pulled."
    exit 1
fi

################################
# rebuild
cd ../../../
rm -rf output/target/nonlinear/playground
make playground-clean-for-reconfigure
make playground-clean-for-rebuild
make playground-rebuild

################################
# try to connect to target device
if [ -z "$3" ]
then
    passphrase="88888888"
else
    passphrase="$3"
fi

sudo nmcli device wifi connect $2 password $passphrase
iwconfig | grep $2 > /dev/null 2>&1

if [ "$?" -ne "0" ]
then
    echo "Could not connect to '$2'"
    exit 1
fi

################################
# deploy
version=`date +"%Y-%m-%d-%H-%M"`
targetdir=/nonlinear/playground-$1-$version

scp -r output/target/nonlinear/playground root@$1:$targetdir
ssh root@$1 "rm /nonlinear/playground"
ssh root@$1 "mv /nonlinear/playground /nonlinear/playground-old"
ssh root@$1 "ln -s $targetdir /nonlinear/playground"
ssh root@$1 "systemctl restart playground"


