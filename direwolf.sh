#!/bin/bash
export PATH=/usr/local/bin:$PATH

# $1 - direwolf config file
# $2 - command to pipe to direwolf
function startifdead() {
	a=`pgrep -f "direwolf -c $1"`
	if [ "$a" != "" ]
	then
		echo $a
		exit
	fi

	filename=$(basename "$1")
	extension="${filename##*.}"
	filename="${filename%.*}"

	screencmd="direwolf -c $1 -t 0 -d mati"

	if [ "$2" != "" ]
	then
		#echo "using stdin"
		screencmd="$2 | $screencmd -" # add the - to direwolf to do stdin
	fi

	echo $screencmd

	screen -d -m -S $filename bash -c "$screencmd"
}

startifdead "sdr-0.conf" "rtl_fm -f 144.39M -d 0 -"
startifdead "sdr-1.conf" "rtl_fm -f 144.34M -d 1 -"
startifdead "rx.conf"
