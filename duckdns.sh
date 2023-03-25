#!/bin/bash
for domain in $(<duckdomains); do
   curl "https://www.duckdns.org/update?domains=$domain&token=$(<ducktoken)&ip=&ipv6="
done