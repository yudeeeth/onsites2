#!/bin/bash

ip=(0)
ptr=0
condvar=0
sum=0
unicount=1
greatestsuccess=(0)
greatestfail=(0)
greatestoverall=(0)

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
    #get high succ
    buff=`./search.sh -c -i $word -s 200`
    [ $buff -gt ${greatestsuccess[0]} ] && greatestsuccess[0]=$buff && greatestsuccess[1]=$word
    #get high overa
    #buff2=`./search.sh -c -i $word`
    [ $count -gt ${greatestoverall[0]} ] && greatestoverall[0]=$count && greatestoverall[1]=$word
    #get high fail
    buff=$(($count-$buff))
    [ $buff -gt ${greatestfail[0]} ] && greatestfail[0]=$buff && greatestfail[1]=$word
    sum=$(($sum + $count))
    unicount=$(($unicount + 1))
    #echo $unicount
    ip[ptr]=$word
    ptr=$(($ptr + 1))
fi
convar=0
v=$(($v + 1))
done

echo largest successful requests ${greatestsuccess[1]} ${greatestsuccess[0]}
echo largest failed requests ${greatestfail[1]} ${greatestfail[0]}
echo largest overall requests ${greatestoverall[1]} ${greatestoverall[0]}
echo average number of requests per device $(($sum / $unicount )) 
