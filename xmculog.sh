#!/bin/bash
#redirect to file, example: ./McuSerialLogCatcher_AddMillisecTimestamp.sh > 1.log

stty sane

#check the serial device, default value is "ttyUSB0"
McuUSBSerialDevice="ttyS2"

#check the serial Baud rate 
#result=`stty -a -F /dev/$McuUSBSerialDevice`
#echo "result: $result"

#str="speed 38400 baud"
#if [[ !("$result" =~ "$str") ]] ; then
#    echo "Change the baud rate as 38400" 
#   stty -F /dev/$McuUSBSerialDevice 38400 
#fi

#tbxttycfg="4:0:830:0:0:0:0:0:0:0:0:0:0:0:0:0:11:13:0:0:0:0"
stty -F /dev/$McuUSBSerialDevice $tbxttycfg 38400 cs8

#saving mcu serial log
tboxlogname=`date  +%Y%m%d_%H%M%S_mcu.log`
echo $tboxlogname
cd ../log/mculog
cat /dev/$McuUSBSerialDevice >> $tboxlogname

