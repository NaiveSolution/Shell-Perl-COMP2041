#!/bin/bash
# inputs: arg1 .. argn
# function: asks for n email addresses for n input arguments (picture attachments), and sends an email to each of those emails with a subject line and the corresponding picture
# written by Tariq

# set -x

for file in "$@"
do
        display "$file"
        echo -n "Address to e-mail this image to?"
        read email
        if [ -n "$email" ]
        then
                echo -n "Message to accompany image?"
                read msg
                echo "$file sent to $email"
                echo "$msg"|mutt -a "$file" -s "100% not spam" -e 'set copy=no' -- "$email"
        else
                echo "You didnt enter an email! Exiting"
                exit 1
        fi
done
