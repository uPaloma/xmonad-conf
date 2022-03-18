#! /bin/bash

mem="$(free -h | awk '/^Speicher:/ {print $3 "/" $2}')"
echo -e "$mem RAM"