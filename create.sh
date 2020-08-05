#!/bin/bash
echo This script will create a library on the Seafile server.
echo No local folder will be created!
echo Input new library parameters
read -p 'Library-name: ' libraryname
read -p 'Server-url: ' serverurl
read -p 'Email-address: ' userid
/sbin/setuser sfuser seaf-cli create -n "$libraryname" -s "$serverurl" -u "$userid"
/sbin/setuser sfuser seaf-cli status
