#!/bin/ksh

cd /root/

cp posters.txt posters.txt.0

cat /var/www/logs/access.log | grep POST | awk '{print $2}' | sort -u > posters.txt 

pfctl -t intelligent -T add -f posters.txt

