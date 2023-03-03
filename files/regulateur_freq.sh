#!/bin/bash

CurrentState=0
sleepDurationSeconds=1

##########################
###Définition des états###

#Etat 0
State0=0
LowerLimitState0=0
UpperLimitState0=10
LimitFrequency0=3500mhz
#Etat 1
State1=1
UpperLimitState1=20
LimitFrequency1=3400mhz
#Etat 2
State2=2
UpperLimitState2=30
LimitFrequency2=3200mhz
#Etat 3
State3=3
UpperLimitState3=40
LimitFrequency3=3100mhz
#Etat 4
State4=4
UpperLimitState4=50
LimitFrequency4=3000mhz
#Etat 5
State5=5
UpperLimitState5=60
LimitFrequency5=2800mhz
#Etat 6
State6=6
UpperLimitState6=70
LimitFrequency6=2600mhz
#Etat 7
State7=7
UpperLimitState7=80
LimitFrequency7=2500mhz
#Etat 8
State8=8
UpperLimitState8=90
LimitFrequency8=2400mhz
#Etat 9
State9=9
UpperLimitState9=100
LimitFrequency9=2200mhz

##########################

while true
do
	####################
	###CPU_Percentage###
	###Source : https://stackoverflow.com/questions/23367857/accurate-calculation-of-cpu-usage-given-in-percentage-in-linux ####
	previousStats=$(head -1 /proc/stat)

	sleep $sleepDurationSeconds

	currentStats=$(head -1 /proc/stat)

	prevuser=$(echo "$previousStats" | awk -F " " '{print $2}')
	prevnice=$(echo "$previousStats" | awk -F " " '{print $3}')
	prevsystem=$(echo "$previousStats" | awk -F " " '{print $4}')
	previdle=$(echo "$previousStats" | awk -F " " '{print $5}')
	previowait=$(echo "$previousStats" | awk -F " " '{print $6}')
	previrq=$(echo "$previousStats" | awk -F " " '{print $7}')
	prevsoftirq=$(echo "$previousStats" | awk -F " " '{print $8}')
	prevsteal=$(echo "$previousStats" | awk -F " " '{print $9}')
	prevguest=$(echo "$previousStats" | awk -F " " '{print $10}')
	prevguest_nice=$(echo "$previousStats" | awk -F " " '{print $11}')

	user=$(echo "$currentStats" | awk -F " " '{print $2}')
	nice=$(echo "$currentStats" | awk -F " " '{print $3}')
	system=$(echo "$currentStats" | awk -F " " '{print $4}')
	idle=$(echo "$currentStats" | awk -F " " '{print $5}')
	iowait=$(echo "$currentStats" | awk -F " " '{print $6}')
	irq=$(echo "$currentStats" | awk -F " " '{print $7}')
	softirq=$(echo "$currentStats" | awk -F " " '{print $8}')
	steal=$(echo "$currentStats" | awk -F " " '{print $9}')
	guest=$(echo "$currentStats" | awk -F " " '{print $10}')
	guest_nice=$(echo "$currentStats" | awk -F " " '{print $11}')

	PrevIdle=$((previdle + previowait))
	Idle=$((idle + iowait))
	
	PrevNonIdle=$((prevuser + prevnice + prevsystem + previrq + prevsoftirq + prevsteal))
	NonIdle=$((user + nice + system + irq + softirq + steal))
	
	PrevTotal=$((PrevIdle + PrevNonIdle))
	Total=$((Idle + NonIdle))
	
	totald=$((Total - PrevTotal))
	idled=$((Idle - PrevIdle))
	
	#CPU_Percentage=$(awk "BEGIN {print ($totald - $idled)/$totald*100}")
	let "CPU_Percentage=(totald-idled)*100/totald"
	
	####################
	

	# Etat 0
	if [ $LowerLimitState0 -le $CPU_Percentage ] && [ $CPU_Percentage -lt $UpperLimitState0 ] && [ $CurrentState -ne $State0 ]
		then
			cpupower frequency-set -u $LimitFrequency0
			CurrentState=$State0
			echo "Taux utilisation :" $CPU_Percentage"%"
			echo "Limite fréquence CPU définie:" $LimitFrequency0
	# Etat 1
	elif [ $UpperLimitState0 -le $CPU_Percentage ] && [ $CPU_Percentage -lt $UpperLimitState1 ] && [ $CurrentState -ne $State1 ]
		then
			cpupower frequency-set -u $LimitFrequency1
			CurrentState=$State1
			echo "Taux utilisation :" $CPU_Percentage"%"
			echo "Limite fréquence CPU définie:" $LimitFrequency1
	
	# Etat 2
	elif [ $UpperLimitState1 -le $CPU_Percentage ] && [ $CPU_Percentage -lt $UpperLimitState2 ] && [ $CurrentState -ne $State2 ]
		then
			cpupower frequency-set -u $LimitFrequency2
			CurrentState=$State2
			echo "Taux utilisation :" $CPU_Percentage"%"
			echo "Limite fréquence CPU définie:" $LimitFrequency2
	
	# Etat 3
	elif [ $UpperLimitState2 -le $CPU_Percentage ] && [ $CPU_Percentage -lt $UpperLimitState3 ] && [ $CurrentState -ne $State3 ]
		then
			cpupower frequency-set -u $LimitFrequency3
			CurrentState=$State3
			echo "Taux utilisation :" $CPU_Percentage"%"
			echo "Limite fréquence CPU définie:" $LimitFrequency3
	
	# Etat 4
	elif [ $UpperLimitState3 -le $CPU_Percentage ] && [ $CPU_Percentage -lt $UpperLimitState4 ] && [ $CurrentState -ne $State4 ]
		then
			cpupower frequency-set -u $LimitFrequency4
			CurrentState=$State4
			echo "Taux utilisation :" $CPU_Percentage"%"
			echo "Limite fréquence CPU définie:" $LimitFrequency4
	
	# Etat 5
	elif [ $UpperLimitState4 -le $CPU_Percentage ] && [ $CPU_Percentage -lt $UpperLimitState5 ] && [ $CurrentState -ne $State5 ]
		then
			cpupower frequency-set -u $LimitFrequency5
			CurrentState=$State5
			echo "Taux utilisation :" $CPU_Percentage"%"
			echo "Limite fréquence CPU définie:" $LimitFrequency5
	
	# Etat 6
	elif [ $UpperLimitState5 -le $CPU_Percentage ] && [ $CPU_Percentage -lt $UpperLimitState6 ] && [ $CurrentState -ne $State6 ]
		then
			cpupower frequency-set -u $LimitFrequency6
			CurrentState=$State6
			echo "Taux utilisation :" $CPU_Percentage"%"
			echo "Limite fréquence CPU définie:" $LimitFrequency6
	
	# Etat 7
	elif [ $UpperLimitState6 -le $CPU_Percentage ] && [ $CPU_Percentage -lt $UpperLimitState7 ] && [ $CurrentState -ne $State7 ]
		then
			cpupower frequency-set -u $LimitFrequency7
			CurrentState=$State7
			echo "Taux utilisation :" $CPU_Percentage"%"
			echo "Limite fréquence CPU définie:" $LimitFrequency7
	
	# Etat 8
	elif [ $UpperLimitState7 -le $CPU_Percentage ] && [ $CPU_Percentage -lt $UpperLimitState8 ] && [ $CurrentState -ne $State8 ]
		then
			cpupower frequency-set -u $LimitFrequency8
			CurrentState=$State8
			echo "Taux utilisation :" $CPU_Percentage"%"
			echo "Limite fréquence CPU définie:" $LimitFrequency8
	
	# Etat 9
	elif [ $UpperLimitState8 -le $CPU_Percentage ] && [ $CPU_Percentage -le $UpperLimitState9 ] && [ $CurrentState -ne $State9 ]
		then
			cpupower frequency-set -u $LimitFrequency9
			CurrentState=$State9
			echo "Taux utilisation :" $CPU_Percentage"%"
			echo "Limite fréquence CPU définie:" $LimitFrequency9
	fi
done
