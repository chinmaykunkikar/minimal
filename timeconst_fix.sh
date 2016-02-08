#!/bin/bash

# Definitions
ENVSETUP=build/envsetup.sh
KERNELSRC=kernel/motorola/msm8916
TIMECONSTBCCOMMIT='70730bca1331fc50c3caacaea00439de1325bd6e'
TIMECONSTWARNINGCOMMIT='7b4a6e771369f394726154db0bc465acfd00a1a3'
REMOTEURL=https://github.com/MinimalOS-AOSP/kernel_huawei_angler

echo -e "\nFixing timeconst error real quick\n"

if [ ! -f $ENVSETUP ]
then
  echo -e "The script is probably not in the parent source folder. \nExiting..."
  exit
fi

function cherry-pick() {
  git fetch minimal mr1
  git cherry-pick $TIMECONSTWARNINGCOMMIT
}

cd $KERNELSRC
git revert $TIMECONSTBCCOMMIT
if [ $(git remote | grep minimal) == "minimal" ]
then
  cherry-pick
else
  git remote add minimal $REMOTEURL
  cherry-pick
fi
