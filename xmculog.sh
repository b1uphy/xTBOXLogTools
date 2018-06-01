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
cat /dev/$McuUSBSerialDevice | while read line
do
	nanosec=`date +%N`
	sec=`date +"%Y%m%d %H:%M:%S"`
	millisec=${nanosec:0:3} #date命令输出的纳秒会默认补齐长度，所以直接取纳秒的前三位

	#echo "[$sec $millisec ] $line" >> $tboxlogname
	echo "[$sec $millisec ] $line"
done

