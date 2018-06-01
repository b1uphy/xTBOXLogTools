#!/bin/bash

function save_arm_log {
  #create local path to save mpu arm log
  Mpu_log_dir="./Mpu_$(date +'%Y%m%d_%H%M%S')"
  echo $Mpu_log_dir
  
  mkdir $Mpu_log_dir

  #pull mpu arm log from TBOX
  adb pull /home/log/arm/ $Mpu_log_dir
  #adb pull /etc/conf/processor_conf.xml $Mpu_log_dir
  #adb pull /etc/conf/version.conf $Mpu_log_dir
  adb pull /home/conf/ $Mpu_log_dir
  adb shell dmesg > $Mpu_log_dir/kmsg.log
  adb shell "cat /proc/interrupts" > $Mpu_log_dir/wakeup_source_log.txt
  tar -czf $Mpu_log_dir.tar.gz $Mpu_log_dir
  rm -rf $Mpu_log_dir
}

function clean_arm_log {
  adb shell rm /home/log/arm/*.log
}

#-------------main----------------
#auto arm log catcher period, default value is 1h

#set the interval unit second
cd /cygdrive/c/tbox_log_tools/log/mpuarmlog
period=${1:-90}
echo off
while true; do
	echo "begin"
	save_arm_log
#   clean_arm_log
	echo "waiting... "
	sleep $period
done









