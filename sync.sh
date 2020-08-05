#!/bin/bash
echo This script will start a sync from a library with an existing folder.
echo Input new sync parameters
read -p 'Library-ID: ' libraryid
read -p 'Server-url: ' serverurl
read -p 'Folder-name: ' foldername
read -p 'Email-address: ' userid
/sbin/setuser sfuser seaf-cli sync -l "$libraryid" -s "$serverurl" -d "/data/$foldername" -u "$userid"
/sbin/setuser sfuser seaf-cli status
