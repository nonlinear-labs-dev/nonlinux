#!/bin/sh
# $2 branch
echo "pulling branch $1"
cd output/build/playground-HEAD/
git pull origin $1
echo "building into /nonlinear/playground/"
sudo make install
echo "done!"
cd /nonlinear/
echo "copying to connected device"
scp -r playground/* root@192.168.8.2:/nonlinear/playground-build
echo "done! connect to device and start playground!"
