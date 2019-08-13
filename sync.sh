#!/bin/bash
echo Input new sync parameters
read -p 'Library-ID: ' libraryid
read -p 'Server-url: ' serverurl
echo Library folder will be located in /data
read -p 'Email-address: ' userid
/sbin/setuser sfuser seaf-cli download -l "$libraryid" -s "$serverurl" -d "/data" -u "$userid"
/sbin/setuser sfuser seaf-cli status
