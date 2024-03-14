#/usr/bin/env bash

echo "$1 notification" >> ~/scripts/dunst/notification.txt
echo "Summary: $2" >> ~/scripts/dunst/notification.txt
echo "body: $3" >> ~/scripts/dunst/notification.txt
echo "icon: $4" >> ~/scripts/dunst/notification.txt
echo "urgency: $5" >> ~/scripts/dunst/notification.txt
