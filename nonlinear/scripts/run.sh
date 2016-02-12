#!/bin/bash

WD=$1

red='\e[0;31m'
nocolor='\e[0m'

echo -e "${red}"
echo -e "##############################################"
echo -e "#### Running NonLinear Post Build Scripts ####"
echo -e "##############################################"
echo -e "${nocolor}"

for each in nonlinear/scripts/jobs/*.sh ;
do
	echo -e "${red}[Running]${nocolor}" $each
	bash $each $WD ; #> /dev/null 2>&1 ;
	rc=$?
	if [[ $rc != 0 ]] ; then
    		exit $rc
	fi
	echo -e "${red}[Done]${nocolor}" $each
done ;

