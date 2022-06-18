#!/bin/bash
target_dir=/home/backup/data/bkp_`date +%Y"_"%m"_"%d`
Tk_bkp()
{​
mkdir $target_dir
mariabackup --backup --target-dir=$target_dir
}​

if [ ! -d $target_dir ]
then
Tk_bkp
else
rm -rf $target_dir
Tk_bkp
fi



/usr/local/bin/aws s3api put-bucket-lifecycle --bucket s3myqlroyalclouds --lifecycle-configuration file://lifecyclepolicy.json
/usr/local/bin/aws s3 mv --recursive $target_dir s3://s3myqlroyalclouds/backup_`date +%Y"_"%m"_"%d`
