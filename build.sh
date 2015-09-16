#!/bin/bash
# (C) 2015 Minimal OS
# Minimal OS build script
# By Chinmay (DarkFalcon)

#Help menu
case $1 in
  -h|--help )
      echo -e "Minimal OS build script"
      echo -e "Usage:\n     ./build.sh [PRODUCT_NAME] [-sc] [JOBS]"
      echo -e "PRODUCT_NAME   -   Product you're currently building for"
      echo -e "[sc]           -   Specify the mode. -s is for repo sync and -c is for clean build."
      echo -e "                   Using -sc whill perform a repo sync as well as a clean build."
      echo -e "JOBS           -   Number of CPU jobs/threads you want the build to utilize"
      echo -e "-h | --help    -   Show this help and exit"
      exit
esac


# Define everything here
PRODUCT_NAME="$1"
MODE="$2"
JOBS="$3"
HOST=$(echo $HOSTNAME)
USER=$(whoami)


#Sanity checks
if [ ! -f build/envsetup.sh ] 
then
  echo -e "The script is probably not in the parent source folder. \nExiting..."
  exit
fi

if [ !"$PRODUCT_NAME" ]
then
  echo -e "No product name supplied."
  echo -e "Please enter ./build.sh $PRODUCT_NAME to run script. \nEnter ./build.sh --help for usage and more options"
  exit
fi

if [ !"$JOBS" ]
then
  echo -e "Warning: Number of jobs not provided"
  echo -e "The script will run further tasks using default jobs"
  echo -e "Enter ./build.sh --help for usage and more options"
fi


# repo sync
if [ $MODE == "-s" ] || [ $MODE == "-sc" ]
then
      echo -e "Repo syncing..."
      repo sync "$JOBS"
  else
      echo -e "Proceeding without repo syncing..." 
fi


# Show the USER and HOST to user
echo -e "\nYour user is $USER and host is $HOST\n"


# Start the actual build
echo -e "Setting up the environment..."
sleep 3
export KBUILD_BUILD_USER="$USER"
export KBUILD_BUILD_HOST="$HOST"
lunch minimal_"$PRODUCT_NAME"-userdebug
export USE_PREBUILT_CHROMIUM=true;
export CHANGELOG=true
rm $OUT/system/build.prop;
echo -e "Environment set up."


# Clean build
echo -e "Perform a clean build? [Default=No]"
read -n 1 make
echo -e "\n\nStarting build for $PRODUCT_NAME\n\n"
if [ $MODE == "-c" ] || [ $MODE == "-sc" ]; then
       echo -e "Cleaning up out folder..."
       mka clean && mka bacon "$JOBS"
    else
      mka bacon "$JOBS"
fi
