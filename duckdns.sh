#!/bin/bash
# Run the command to update domains registered with DuckDNS.
# Create files `ducktoken` which contains your API token, and `duckdomains` which
# contains your subdomains on new lines.
for domain in $(<duckdomains); do
   curl "https://www.duckdns.org/update?domains=$domain&token=$(<ducktoken)&ip=&ipv6="
done
