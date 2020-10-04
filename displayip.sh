#/bin/bash

ip=(0)
ptr=0
condvar=0

file=(`awk '{print $1}' access.log`)
v=0
while [ $v -lt 10000 ]
do
word=${file[$v]}
    flag=1
    i=0
    while [ $i -le $ptr ]
    do
        if [ "$word" == "${ip[$i]}" ]
        then
            flag=0
        fi
        i=$(($i + 1))
    done
    condvar=$flag

if [ $condvar -eq 1 ]
then
    count=`grep -c $word access.log`
    echo $word $count
    ip[ptr]=$word
    ptr=$(($ptr + 1))
fi
convar=0
v=$(($v + 1))
done