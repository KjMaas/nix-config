#!/usr/bin/env bash

SLEEP_TIME=30
full_flag=0
low_flag=0
crit_flag=0
vcrit_flag=0
while true; do
	capc=$(cat /sys/class/power_supply/BAT0/capacity)
	if [[ $(cat /sys/class/power_supply/BAT0/status) != "Discharging" ]]; then # -- charging state
		shutdown -c                                                               # -- closing the pending shutdowns from critical shutdown action
		low_flag=0
		crit_flag=0
		vcrit_flag=0
		if ((capc == 100)); then
			if ((full_flag != 1)); then
				notify-send -t 20000 -u low "    Battery FULL"
				full_flag=1
			fi
		fi
		SLEEP_TIME=30

	else # -- discharging state

		full_flag=0
		if ((capc >= 60)); then
			SLEEP_TIME=40
		else
			SLEEP_TIME=30
			if ((capc <= 10)); then
				SLEEP_TIME=20
				if ((low_flag != 1)); then
                    notify-send -t 20000 -u medium "    Battery LOW"
					low_flag=1
				fi

			fi
			if ((capc <= 5)); then
				SLEEP_TIME=15
				if ((crit_flag != 1)); then
                    notify-send -t 30000 -u critical "    Battery low" "SHUTDOWN when battery @2%"
					crit_flag=1
				fi
			fi
			if ((capc <= 2)); then
				SLEEP_TIME=10
				if ((vcrit_flag != 1)); then
                    notify-send -t 0 -u critical " 2%   BATTERY VERY LOW!" "Imminent Shutdown"
					shutdown
					vcrit_flag=1
				fi

			fi
		fi

	fi
	#echo "$capc sl_time = $SLEEP_TIME"
	sleep $SLEEP_TIME
done
