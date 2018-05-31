#!/bin/sh

while [ `killall playground` ]
do
	sleep 1
done

/nonlinear/text2soled clear
/nonlinear/text2soled "Shutting down ..." 10 10
/nonlinear/text2soled "Shutting down ..." 10 74


