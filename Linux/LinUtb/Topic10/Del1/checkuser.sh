#!/bin/bash

userName=$1

if [ "$userName" == "" ]; then
    echo "Please provide a user name:"
    read userName
fi

userFound=$(who | cut -d ' ' -f1 | sort | uniq | grep -w $userName)
if [ "$userFound" != "" ]; then
    echo "The user '$userName'' is logged in"
    exit 0
fi
echo "The user '$userName' is not logged in or the user name is incorrectly entered"
exit 1