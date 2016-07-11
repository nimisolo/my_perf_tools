#!/bin/sh

###############################################################################
#
# Fetching performance infos
# This scripts is the tool's frameworks, it will search target-module's scripts
# in this directory,
# and then SOURCE them.
#
#
#
# Usage: tool_main.sh [ -i interval ] [ -c count ]
# 	@interval: interval between two fetch action, default is 3s
#	@count:  fetch times, default is 0 means forever
#
###############################################################################


###############################################################################
# prepare
###############################################################################
interval=3
count=0

# help function
display_help ()
{
	echo "USAGE: tool_main.sh [ -i interval ] [ -c count ]"
	echo "	@interval: interval between two fetch action, default is 3s"
	echo "	@count:  fetch times, default is 0 means forever"
}

# parse paraments
while getopts "i:c:h" arg
do
	case $arg in
		i)
			interval=$OPTARG;;
		c)
			count=$OPTARG
			count=`expr $count + 1`;;
		h)
			display_help
			exit 0;;
		?)
			echo "Unknow Paraments..."
			display_help
			exit 0;;
	esac
done

echo $interval
echo $count

###############################################################################
# do fetching
###############################################################################
curr_dir=`pwd`
script_dir=$(cd `dirname $0`; pwd)
data_dir="/tmp/my_perf/"
# load target-modules
source ./pm_interrupts
#source pm_meminfo
#source pm_buddyinfo
#source pm_mpstat
#source pm_vmstat
#source pm_iostat

do_fetching ()
{
	get_interrupts
}

# clean result directory
rm -rf $data_dir
mkdir $data_dir
# fetching
while [ $count -eq 0 ] || [ $count -gt 1 ]
do
	do_fetching
	if [ $count -gt 0 ]; then
		count=`expr $count - 1 `
	fi
done 


###############################################################################
# do fetching
###############################################################################
cd $curr_dir
exit 0

