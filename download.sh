#!/bin/bash
echo This script will start a download from a library.
echo Library folder will be created in /data.
echo If Library folder exists, a new folder with -1 appended will be created.
echo Input download parameters
read -p 'Library-ID: ' libraryid
read -p 'Server-url: ' serverurl
read -p 'Email-address: ' userid
/sbin/setuser sfuser seaf-cli download -l "$libraryid" -s "$serverurl" -d "/data" -u "$userid"
/sbin/setuser sfuser seaf-cli status
