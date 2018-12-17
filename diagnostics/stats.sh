#/bin/hash

output=Sysinfo_$(/bin/date +date_%d-%m-%y_time_%H-%M-%S)

function _Text(){
	echo -e "\n    General Information\n"
	echo -e "This Computer Using $(uname -m) architecture \n"
	echo -e "The Linux Kernel is $(uname -r) \n"
	echo -e "This Linux Distro is $(head -n1 /etc/issue) \n"
	echo -e "The Host Name Of this computer is $(hostname) \n"
	echo -e "The Name Of the user Of this computer is $(whoami)  \n"
	echo -e "The Number Of The Users That Using This Computer $(users | wc -w) Users  \n"
	echo -e "The System Uptime = $(uptime | awk '{ gsub(/,/, ""); print $3 }')  \n"
	echo -e "The Run level Of Current OS is $(runlevel) \n"
	echo -e "The Number OF Running Process :$(ps ax | wc -l) \n"
	#cat /etc/*release*
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	echo -e "\n    CPU\n"
	echo -e "You Have $(grep -c 'processor' /proc/cpuinfo) CPU \n"
	echo -e "CPU model name is $(awk -F':' '/^model name/ { print $2 }' /proc/cpuinfo) \n"
	echo -e "CPU vendor$(awk -F':' '/^vendor_id/ { print $2 }' /proc/cpuinfo) \n"
	echo -e "CPU Speed$(awk -F':' '/^cpu MHz/ { print $2 }' /proc/cpuinfo) \n"
	echo -e "CPU Cache Size$(awk -F':' '/^cache size/ { print $2 }' /proc/cpuinfo) \n"
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	echo -e "\n    Memory\n"
	echo -e "$(cat /proc/meminfo) \n"
	echo -e "$(free -m) \n"
	#echo -e "$(top) \n"
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#echo -e "\n    Virtual Memory\n"	
	#echo -e "$(vmstat)"
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	echo -e "\n    File Systems\n"
	echo -e "$(df -h) \n"
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	echo -e "\n    PCI devices On MOtherboard {detailed}\n"
	echo -e "$(lspci -tv) \n"
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	echo -e "\n    Network\n"
	echo -e "$(/sbin/ifconfig) \n"
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#lsusb
	#List all block devices (hard disks, cdrom, and others)
	# lsblk
	#Display installed hard disk and size
	# fdisk -l | grep '^Disk /dev/'
	#Dump all hardware information
	#
	#Type the following command to see your motherboard, cpu, vendor, serial-numbers, RAM, disks, and other information directly from the system BIOS:
	# dmidecode | less

}

function _create_Html() {
	echo "<!DOCTYPE html>"
	echo "<html>"
	echo "<head><title>System Info</title></head>"
	echo "<body>"
	echo $(cat $output.txt| sed 's/$/<br>/g' ) 
	echo "</body>"
	echo "</html>"
}

_Text | tee $output.txt
_create_Html | tee $output.html 


