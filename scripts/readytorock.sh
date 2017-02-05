#!/usr/bin/env bash
set -e
VER="1.26.2-YDS"
STATUS="Stable"
DATE="`date +'%d %b/%y'`"
export VER STATUS DATE
CURRDIR=$PWD
cd "`dirname $0`"
if [[ ! -d ../busybox ]]
	then (cd .. && git clone https://github.com/yashdsaraf/busybox.git)
else
	cd ../busybox
	git pull
	cd "`dirname $0`"
fi
./build-bb.sh all
./build-ssl.sh
./update-bins.sh
./createtgz.sh
./mkzip.sh
cd ../bbx/out
DIR=`date +'%b-%d-%y'`
mkdir -p $DIR
cd $DIR
mkdir -p Tars
cd Tars
mv ../../../Bins/*tar.gz .
cd ..
mv ../*zip .
cd $CURRDIR