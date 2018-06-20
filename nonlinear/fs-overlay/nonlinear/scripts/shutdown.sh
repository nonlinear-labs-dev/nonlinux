#!/bin/sh


while [[ $(pidof playground) -ne 0 ]];
do
	pidof playground
	echo $?
	killall playground
done	

cd /nonlinear/text2soled
./text2soled clear
./text2soled "Shutting down..." 10 10
./text2soled "Shuttong down..." 10 74
