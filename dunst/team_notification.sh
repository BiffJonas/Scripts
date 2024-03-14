#!/bin/bash

TEAMS_NOTIF="~/scripts/dunst/team_notification_counter.txt"
messages=$(<~/scripts/dunst/team_notification_counter.txt)
((messages++))
echo $messages > ~/scripts/dunst/team_notification_counter.txt
