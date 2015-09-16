#!/bin/bash
# (C) 2015 Minimal OS
# Minimal OS build script
# By Chinmay (DarkFalcon)

#Help menu
case $1 in
  -h|--help )
      echo -e "Minimal OS build script"
      echo -e "Usage:\n     ./build.sh PRODUCT_NAME JOBS"
      echo -e "PRODUCT_NAME   -   Product you're currently building for"
      echo -e "JOBS           -   Number of CPU jobs/threads you want the build to utilize"
      echo -e "-h | --help    -   Show this help and exit"
      exit
esac


#Sanity checks
if [ ! -f build/envsetup.sh ] 
then
  echo -e "The script is probably not in the parent source folder. \nExiting..."
  exit
fi

if [ !"$1" ]
then
  echo -e "No product name supplied."
  echo -e "Please enter ./build.sh $PRODUCT_NAME to run script. \nEnter ./build.sh --help for usage and more options"
  exit
fi

if [ !"$2" ]
then
  echo -e "Warning: Number of jobs not provided"
  echo -e "The script will run further tasks using default jobs"
  echo -e "Enter ./build.sh --help for usage and more options"
fi


# Define everything here
PRODUCT_NAME="$1"
JOBS="$2"
HOST=$(echo $HOSTNAME)
USER=$(whoami)


# Ask whether to do repo sync
echo -e "Perform a repo sync before froceeding to build? [Default=Yes]"
read -n 1 sync
case $sync in
   Y|y|"" )
      repo sync $JOBS"
      ;;
  *)
      echo -e "Proceeding without repo syncing..."
      ;;
esac


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
echo -e "Environment set up."


# Ask if to make a clean build
echo -e "Perform a clean build? [Default=No]"
read -n 1 make
echo -e "\n\nBuild Started!\n\n"
case $make in
   Y|y )
      mka clean && mka bacon "$JOBS"
      ;;
   N|n|"" )
      mka bacon "$JOBS"
      ;;
   * )
      echo -e "Please answer in Yes or No"
      exit;
      ;;
esac
