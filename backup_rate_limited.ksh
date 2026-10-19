#!/bin/ksh

cd /var/log/

#mv -f intelligent.txt intelligent.0.txt

# know when i made the file
echo \# Created: $(date) \\n\# \$USER: @$(hostname) > intelligent.txt 

echo \# $(pfctl -s rules -R 15) >> intelligent.txt
echo \# $(pfctl -s rules -R 16) >> intelligent.txt

# append the contents of the rate limited guys on the file
pfctl -t intelligent -T show >> intelligent.txt

cksum -a sha512 -h intelligent.hash intelligent.txt

cp intelligent.txt /var/www/htdocs/awfulbytes.org/assets/block.txt

