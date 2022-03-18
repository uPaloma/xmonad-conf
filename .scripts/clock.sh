#! /bin/bash 

dte="$(date +"%a, %d.%B %H:%M%p"| sed 's/  / /g')"
echo -e "$dte"
