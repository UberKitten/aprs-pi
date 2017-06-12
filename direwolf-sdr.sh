#!/bin/bash
export PATH=/usr/local/bin:$PATH

#a=`pgrep -x direwolf`
a=`pgrep -f "direwolf -c /home/astra/sdr.conf"`
if [ "$a" != "" ]
then
  echo $a
  exit
fi

screen -d -m -S direwolf-sdr bash -c 'rtl_fm -f 144.39M - | direwolf -c ~/sdr.conf -r 24000 -D 1 -t 0 -d agti -'

