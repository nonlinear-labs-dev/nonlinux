#!/bin/sh

function print2soled {
  Text=$1
  /nonlinear/text2soled $Text 10 80
  /nonlinear/text2soled/text2soled $Text 10 80
  /nonlinear/text2soled $Text 10 180           
  /nonlinear/text2soled/text2soled $Text 10 180

}

pid=`ps axf | grep playground/playground  | grep -v grep | awk '{print "kill -0 " $1}'`
echo $pid

counter=0
wait=3

/nonlinear/text2soled/text2soled clear
/nonlinear/text2soled clear

while `$pid` 2> /dev/null; do
	print2soled "Shutdown..."
	sleep 1
	counter=$(expr $counter + 1)
	if [ "$counter" -gt "$wait" ]; then
		exit 1	
	fi
done
