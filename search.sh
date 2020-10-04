#!/bin/bash
ip=(0)
status=(0)
timeperiod=(0)
count=0
url=(0)

while [ -n "$1" ]
do

	case "$1" in

	-i) 
        
        ip[0]=1
        ip[1]="$2"
        shift
        ;;

	-s)
        status[0]=1
		status[1]="$2"
		shift
		;;
	-t)
        timeperiod[0]=1
		timeperiod[1]="$2"
		shift
		;;
    -u)
        url[0]=1
        url[1]="$2"
        ;;
    -c) 
        count=1
        ;;
	

	esac

	shift

done

touch test.txt
touch test1.txt
cat access.log > test.txt
if [ ${ip[0]} -eq 1 ]
then

cat test.txt | grep "^${ip[1]} .* .* \[.*\] \".*\" .* .* \".*\" \".*\"$" >> test1.txt
cat test1.txt > test.txt
rm test1.txt
touch test1.txt
fi

if [ ${status[0]} -eq 1 ]
then

cat test.txt | grep  "^.* .* .* \[.*\] \".*\" ${status[1]} .* \".*\" \".*\"$" >> test1.txt
cat test1.txt > test.txt
rm test1.txt
touch test1.txt
fi

if [ ${timeperiod[0]} -eq 1 ]
then

cat test.txt | grep  "^.* .* .* \[${timeperiod[1]} .*\] \".*\" .* .* \".*\" \".*\"$" >> test1.txt
cat test1.txt > test.txt
rm test1.txt
touch test1.txt
fi

if [ ${url[0]} -eq 1 ]
then

cat test.txt | grep  "^.* .* .* \[.*\] \"GET ${url[1]} HTTP/1\.[01]\" .* .* \".*\" \".*\"$" >> test1.txt
cat test1.txt > test.txt
rm test1.txt
touch test1.txt
fi


rm test1.txt
if [ $count -eq 0 ]
then
cat test.txt
else
grep ^.*$ -c test.txt
fi
