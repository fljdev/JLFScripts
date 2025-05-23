#!/bin/bash
# File: user_manage.sh
# Description: Manages user accounts on the server

ACTION=$1
USERNAME=$2

case $ACTION in
    create)
        if [ -z "$USERNAME" ]; then
            echo "Usage: $0 create <username>"
            exit 1
        fi
        useradd -m -s /bin/bash $USERNAME
        passwd $USERNAME
        echo "User $USERNAME created."
        ;;
    delete)
        if [ -z "$USERNAME" ]; then
            echo "Usage: $0 delete <username>"
            exit 1
        fi
        userdel -r $USERNAME
        echo "User $USERNAME deleted."
        ;;
    *)
        echo "Usage: $0 {create|delete} <username>"
        exit 1
        ;;
esac