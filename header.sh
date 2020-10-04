#!/bin/bash
touch access2.log
touch buff.txt
echo 'IP user-identifier userid [time] "request" status-code size "url" "user-agent-string"' > buff.txt
cat access.log >> buff.txt
sed 's_^\(.*\) \(.*\) \(.*\) \(\[.*\]\) \(\".*\"\) \(.*\) \(.*\) \(\".*\"\) \(\".*\"\)$_\1@\2@\3@\4@\5@\6@\7@\8@\9_g' buff.txt | column -t -s "@" >> access2.log
rm buff.txt
# i=0
# while [ $i -lt 10 ]
# do
# head -1000 buff.txt | column -t -s "@" >>access2.log
# sed -i '1,1000d' buff.txt
# done