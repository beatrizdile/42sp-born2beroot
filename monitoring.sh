#!/bin/bash

ARCH=$(uname -srvmo)
#     'uname': print system information.
#          -s: print the kernel name.
#          -r: kernel release.
#          -v: kernel version.
#          -m: hardware (32bits or 64bits for example).
#          -o: SO.

CPU=$(grep 'physical id' /proc/cpuinfo | uniq | wc -l)
#     What is 'physical processor'? is the number of devices
#     on your motherboard. More advanced computers have more than one physical CPU.
#
#           /proc/cpuinfo: show us a lot of information about the physical CPU.
#      grep 'physical id': the output will have more than 1 information group, 
#      			   because one CPU may have more than 1 cores, so we need
#      			   to filter and show just lines with the word 'physical 
#      			   id' present.
#                   uniq : remove similar lines, this will show exactly just the 
#                   	   PHYSICAL amount of CPU(s).
#                  wc -l : return the amount of lines of stdout
#                      -l: count lines of stdout.

VCPU=$(grep 'processor' /proc/cpuinfo | uniq | wc -l)
#     What is 'virtual processor'? is a portion of Physical Processor, assigned to 
#     be used by VM(s). So the processor need to have support to it. 
#     hypervisor is like a VM monitor, or manager inside these VM compatible CPU, 
#     it allocate and deallocate the CPU resources to the VM(s).
#     
#           /proc/cpuinfo: show us a lot of information about the physical CPU.
#        grep 'processor': We filter and show just, lines with the word 'processor',
#        		   because it represent the amount of vCPU.
#                   uniq : remove similar lines, this will show exactly just the 
#                   	   PHYSICAL amount of CPU(s).
#                  wc -l : return the amount of lines of stdout
#                      -l: count lines of stdout.

FULLM=$(free -m | grep Mem: | awk '{print $2}')
USEDM=$(free -m | grep Mem: | awk '{print $3}')
PCMEM=$(free -m | grep Mem: | awk '{FULLM = $2} {USEDM = $3} {printf("%.2f"), (USEDM*100)/FULLM}')
#                   free : display memory-related information.
#                     -m : show the free output in MB(megabytes).
#            grep 'Mem:' : show just the line with 'Mem:' inside, otherwise, 
#            		   the used memory.
#       awk '{print $2}' : print the 2 column which is the total RAM.
#       awk '{print $3}' : print the 3 column which is the used RAM.
#
#      awk '{FULLM = $2} {USEDM = $3} {printf("%.2f"), (USEDM*100)/FULLM}' : repeat the 
#      last 2 actions but holding in 2 variables, after, is calculated the percentage 
#      of used RAM. (USED RAM * 100 / FULL RAM)                  

FULLD=$(df -Bg | grep /dev/ | grep -v /boot | awk '{FULLD += $2} END {print FULLD}')
USEDD=$(df -Bg | grep /dev/ | grep -v /boot | awk '{USEDD += $3} END {print USEDD}')
PORUD=$(df -Bg | grep /dev/ | grep -v /boot | awk '{FULLD += $2} {USEDD += $3}  END {printf("%d"), (USEDD*100)/FULLD}')
#    		      df : displays the amount of disk space available on the file system
#                 df -Bg : report the amount of memory used in disk, in gigabytes.
#                    -Bg : set the output measurement unit of df. (g - GB).
#             grep /dev/ : show just the line representing the mount point /dev/ 
#             		   which represents the full disk.
#          grep -v /boot : remove the line containing the mount point /boot information.
#
#     awk '{FULLD += $2} END {print FULLD}' : Column 2 represents the full size of
#     the partition. So it is summing all disk size of lines containing /dev.
#
#     awk '{FULLD += $2} {USEDD += $3}  END {printf("%d"), (USEDD*100)/FULLD }' : Do the
#     last action 2 times, again for 2 columns and also for 3 columns which represents
#     the memory used, after with both values the use percentage is calculated. 
#     (USED DISK SPACE * 100 / FULL DISK SPACE).
#

CLOAD=$(top -bn1 | grep 'Cpu' | cut -c 9- | awk '{printf("%.1f%%"), $1 + $3}')
#     What is 'utilization rate of processor'?
#     Formula:  1 - (I/O Time of a processor, so time that CPU wait a proccess Input 
#     or Output) ^ Number of processes.
#     "Represents the time that a process is being processed by CPU."  
#     
#               top -bn1 : Outputs in screen all processors being executed now, in a 
#                          mode that can be easily piped for others commands. 
#                    top : Display all processors being executed in a mini processes 
#                          monitor program, which isn't so flexible with PIPE etc. 
#                          The important column to this script is x and y because they 
#                          represent x and y.
#                     -b : Display the top result in batch mode, like a cat, so this 
#                          result can be easily piped and receibe others commands.
#                    -n1 : Stop the processes refresh after 1 time refreshed.
#               grep Cpu : display just one line in this top result, which represents 
#                          some statistics about CPU.
#              cut -c 9- : Select just the characters after digit 9 in this line, in
#                          others words, the start of this line is cutted.
#               "0.0 us" : % of CPU used in user processes.
#               "0.0 ni" : % of CPU used in system low priority processes.
#   awk '{printf("%.1f%%"), $1 + $3}' : Sum both values and return formatted with 2 
#   decimal places using printf.

LAST=$(who -b | awk '{print($3 " " $4)}')
#                      who : show who is logged.
#                       -b : show data and time of last login.
#   awk '{print $3 " " $4}': show concatenation date and time.

CHECK_LVM=$(cat /etc/fstab | grep /dev/mapper/ | wc -l)
LVM=$(if [ ${CHECK_LVM} -eq 0 ]; then echo no; else echo yes; fi)
#                CHECK_LVM : report the amount of memory used in disk, in gigabytes.
#                      LVM : checks if there are partitions.

TCP=$(netstat -t | grep ESTABLISHED | wc -l)
NTCP=$(if [ ${TCP} -eq 0 ]; then echo 0; else echo ${TCP} ESTABLISHED; fi)
#		        TCP: Transmission Control Protocol connection is a communication
#		             channel established between two devices over a network. TCP provides 
#		             reliable, ordered, and error-checked delivery of data packets between 
#		             applications running on different hosts. When two devices, such as a 
#		             client and a server, need to communicate with each other over a network
#		             using TCP, they establish a TCP connection.
#               netstat -t : Print network connections with details.
#         grep ESTABLISHED : Filter just the connections that are established.
#                    wc -l : Count lines of output.
#   if [ ${CONNECTIONS} -eq 0 ]; then echo 0; 
#   else echo ${CONNECTIONS} ESTABLISHED; fi  : If there's more 
#   than 0 return the amount of conections, if not, return 0.

USERS=$(who | wc -l)
#  who : show who is logged on
#   wc : print newline, word, and byte counts for each file
#   -l : print the newline counts

IP=$(hostname -I | awk '{print $1}')
MAC=$(cat /sys/class/net/*/address | head -n 1)
#                     hostname -I : Display IPv4.
#             awk '{ print($1) }' : Show it.
#    cat /sys/class/net/*/address : Display MAC Address.
#                       head -n 1 : Display just the first line.

SUDO=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)

echo "#Architecture: ${ARCH}"
echo "#CPU physical: ${CPU}"
echo "#vCPU: ${VCPU}"
echo "#Memory Usage: ${USEDM}/${FULLM}MB (${PCMEM}%)"
echo "#Disk Usage: ${USEDD}/${FULLD}Gb (${PORUD}%)"
echo "#CPU load: ${CLOAD}"
echo "#Last boot: ${LAST}"
echo "#LVM use: ${LVM}"
echo "#Connections TCP: ${NTCP}"
echo "#User log: ${USERS}"
echo "#Network: IP ${IP} (${MAC})"
echo "#Sudo: ${SUDO} cmd"