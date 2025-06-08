#!/bin/sh
while true
do
	player_status=$(playerctl status 2> /dev/null)
	if [ "$player_status" = "Playing" ]; then
		echo -e "$(playerctl metadata artist) - $(playerctl metadata title)"
	elif [ "$player_status" = "Paused" ]; then
		echo -e " $(playerctl metadata artist) - $(playerctl metadata title)"
	fi
	sleep .1
done
