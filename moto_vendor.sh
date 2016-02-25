#!bin/bash

TM='https://github.com/TheMuppets/proprietary_vendor_motorola/tree/cm-13.0'
MOTO='https://github.com/moto8916/proprietary_vendor_motorola/tree/cm-13.0_msm8916'
DF='https://github.com/dark-falcon/vendor_motorola/tree/master'
PD='~/working'
WD="$PD/proprietary_vendor_motorola"
MSM8916_DEVICES='lux merlin msm8916-common osprey surnia'
MSM8226_DEVICES='falcon msm8226-common peregrine thea titan'

# initialize
mkdir -p $PD
cd $PD

# clone
git clone $DF
cd $WD

# fetch
if [ $(git remote | grep moto8916) ! == "moto8916" ]
then
  git remote add moto8916 $MOTO
fi
if [ $(git remote | grep themuppets) ! == "themuppets" ]
then
  git remote add themuppets $TM
fi
git fetch moto8916 cm-13.0_msm8916
git fetch themuppets cm-13.0

# make .log files
git log moto8916/cm-13.0_msm8916 --pretty=oneline -- $MSM8916_DEVICES | cut -d' ' -f1 > msm8916.tmp
git log themuppets/cm-13.0 --pretty=oneline -- $MSM8226_DEVICES | cut -d' ' -f1 > msm8226.tmp
tac msm8916.tmp > msm8916.log
tac msm8226.tmp > msm8226.log
rm -f *.tmp

# pick commits
for commit_8226 in $(cat msm8226.log)
do 
	git cherry-pick $commit_8226
done

for commit_8916 in $(cat msm8916.log)
do 
	git cherry-pick $commit_8916
done

# remove those device blobs which are not needed
rm -r merlin surnia
rm -r peregrine thea
