#!/bin/bash
#redirect to file, example: ./McuSerialLogCatcher_AddMillisecTimestamp.sh > 1.log

#check the serial device, default value is "ttyUSB0"
ls /dev | grep ttyS
McuUSBSerialDevice="ttyS3"


stty sane
stty -F /dev/$McuUSBSerialDevice $tbxttycfg 38400 cs8

#saving mcu serial log
tboxlogname=`date  +%Y%m%d_%H%M%S_mcu.log`
echo $tboxlogname
cd ../log/mculog
cat /dev/$McuUSBSerialDevice | tee $tboxlogname


