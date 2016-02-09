#!/bin/bash

if [ ! $(pwd) = "/home/$(whoami)" ]
then
  echo -e "\nMake sure the script is in the home folder.\nExiting..."
  exit
fi

if [ ! "$1" ]
then
  echo -e "No source folder name supplied."
  echo -e "Please enter ./$0 '$SOURCE_DIR' to run script.\nExample - ./$0 caf"
  exit
  else
    SOURCE_DIR="$1"
fi

JOBS=$(cat /proc/cpuinfo | grep processor | wc -l)

cd $SOURCE_DIR
repo sync -j$JOBS
bash $OLDPWD/timeconst_fix.sh
source build/envsetup.sh

case $1 in
  caf)
     lunch aosp_osprey-userdebug
     if [[ $2 == '-c' || $2 == '-C' ]]
     then
       make clean
     fi
     make otapackage -j$JOBS
     ;;
   cm)
     lunch cm_osprey-userdebug
     if [[ $2 == '-c' || $2 == '-C' ]]
     then
       make clean
     fi
     mka bacon -j$JOBS
     ;;
esac
