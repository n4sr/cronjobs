#!/bin/bash
# Njalla DDNS updater
# usage: ./njalla <infile> <logfile>
# input file ($1) should have a domain name and key pair seperated by a colon (:) on each line.
# logfile is optional

if [[ -n $1 ]]; then
    echo 'usage: ./njalla.sh <infile> <logfile>'
fi

# get ipv4 and ipv6 from google
# TODO: add more providers to choose from.
ipv4=$(dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr -d '"')
ipv6=$(dig -6 TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr -d '"')

if [[ -n $1 ]]; then
    echo 'usage: ./njalla.sh <infile> <logfile>'
fi


while read line || [[ -n $p ]]; do
    domain=$(echo $line | cut  -d ':' -f 1)
    token=$(echo $line | cut -d ':' -f 2)
    result=$(curl "https://njal.la/update/?h=$domain&k=$token&a=$ipv4&aaaa=$ipv6")
    if [[ -n $2 ]]; then
        echo -e "$(date -Iseconds)\t$domain:\t$result" >> $2
    fi
done < $1
