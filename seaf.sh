#!/bin/bash
exec /sbin/setuser sfuser seaf-daemon -c /home/sfuser/.ccnet -d /home/sfuser/seafile-client/seafile-data -w /home/sfuser/seafile
