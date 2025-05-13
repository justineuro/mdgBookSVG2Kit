#!/bin/bash
#===================================================================================
#
#	 FILE:	mdg22midRndN+svg.sh
#
#	USAGE:	mdg22midRndN+svg.sh <num>
#
#		where <num> is the number of random MDG minuets to be generated, e.g., 50.
#		*** NOTE:  This script has to be in the same directory as mdg22mid+svg.sh. ***
#
# DESCRIPTION:	Used for generating <num> ABC, MIDI, and SVG files, each a Musical 
#		Dice Game (MDG) double counterpoint of six measures based on C.P.E. Bach's 
#		Counterpoint ("Einfall")
#
#      AUTHOR:	J.L.A. Uro (justineuro@gmail.com)
#     VERSION:	1.0.6
#     LICENSE:	Creative Commons Attribution 4.0 International License (CC-BY)
#     CREATED:	2021/02/21 17:28:40
#    REVISION:	2025/05/13 10:23:44 
#==================================================================================

#----------------------------------------------------------------------------------
# define the function genS() that randomly chooses an integer from 1 to 9, inclusive
#----------------------------------------------------------------------------------
genS() { # RANDOM randomly generates an integer in from 0 to 32767; rem in {0..8}
	rnd=32760
	until [ $rnd -lt 32760 ]
	do
		rnd=$[RANDOM]
		if [ $rnd -lt 32760 ]; then echo $[rnd%9+1]; fi
	done
}

#----------------------------------------------------------------------------------
# declare the variables "diceS" as an array
# diceS - array containing the 12 outcomes from input line
#----------------------------------------------------------------------------------
declare -a diceS

#----------------------------------------------------------------------------------
# generate the <num> random minuets
#----------------------------------------------------------------------------------
i=1
while [ $i -le $1 ]; do
#----------------------------------------------------------------------------------
# generate the random 6x2-sequence of outcomes of the 12 throws of 9-sided die
#----------------------------------------------------------------------------------
	for j in {0..11}; do
		diceS[$j]=`genS`
	done

#----------------------------------------------------------------------------------
# generate a minuet in ABC notation and corresponding MIDI for the current diceS 
# using mdg22mid+svg.sh
#----------------------------------------------------------------------------------
	echo ${diceS[*]}
	./mdg22mid+svg.sh ${diceS[*]}
	i=`expr $i + 1`
done
#
##
###
