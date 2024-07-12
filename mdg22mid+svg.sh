#!/bin/bash
#===================================================================================
#
#	 FILE:	mdg22mid+svg.sh
#
#	USAGE:	mdg22mid+svg.sh n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 
#
#		where n1-n12 are any of the 9 possible integers from the set {1, 2, 3, 4, 5, 6, 7, 8, 9}, 
#		which may be obtained by tossing a 9-sided die or two 5-sided dice and subtracting 1
#		from the sum of the upturned faces
#
# DESCRIPTION:	Used for generating ABC, MIDI, and SVG files 
#		of a particular Musical Dice Game (MDG) double counterpoint of six measures 
#		based on C.P.E. Bach's Counterpoint ("Einfall")
#
#      AUTHOR:	J.L.A. Uro (justineuro@gmail.com)
#     VERSION:	1.0.5
#     LICENSE:	Creative Commons Attribution 4.0 International License (CC-BY)
#     CREATED:	2021/02/21 16:39:29
#    REVISION:	2024/07/12 08:59:25
#==================================================================================

#----------------------------------------------------------------------------------
# declare the variables "diceSG", "diceSF", and "measNR" as arrays
# diceSG/SF - arrays containing the 6 outcomes from input line
# measNR - array of all possible measure notes for a specific outcome
#----------------------------------------------------------------------------------
declare -a diceSG diceSF measNR  

#----------------------------------------------------------------------------------
# input 6-sequence of tosses as given in the command line
#----------------------------------------------------------------------------------
diceSG=($1 $2 $3 $4 $5 $6)
diceSF=($7 $8 $9 ${10} ${11} ${12})

#----------------------------------------------------------------------------------
# input rule table to determine corresponding G/F measures for each toss outcome
#----------------------------------------------------------------------------------
ruletab() {
	case $1 in
	1) measNR=(1 10 19 28 37 46);;
	2) measNR=(2 11 20 29 38 47);;
	3) measNR=(3 12 21 30 39 48);;
	4) measNR=(4 13 22 31 40 49);;
	5) measNR=(5 14 23 32 41 50);;
	6) measNR=(6 15 24 33 42 51);;
	7) measNR=(7 16 25 34 43 52);;
	8) measNR=(8 17 26 35 44 53);;
	9) measNR=(9 18 27 36 45 54);;
	esac
}

#----------------------------------------------------------------------------------
# input notes
# declare variables "notesG" and "notesF" as arrays
# notesG - array that contains the possible treble clef notes per measure
# notesF - array that contains the possible bass clef notes per measure
#----------------------------------------------------------------------------------
declare -a notesG notesF

#----------------------------------------------------------------------------------
# define notesG, array of 54 possible measures of treble clef notes
#----------------------------------------------------------------------------------
notesG=("egec" "z/e/ g/f/ e/g/ e/c/" "e3c" "cGec" "z c/d/ ec" "e/f/ g/f/ f/e/ e/c/" "c2e2" "z/c/ c/e/ e/e/ d/c/" "c c/d/ e/d/ e/c/" "dGg2" "g/a/ g/^f/ g2" "e/G/ g/^f/ g2" "ddg2" "d g/^f/ g2" "d2g2" "g/G/ g/g/ g2" "d/d/ g/^f/ g2" "gGg2" "g/a/ b/c'/ f2" "gcf2" "g/c/ d/e/ ff" "g/c/ B/c/ f2" "g/g/ c'/2g/ ff" "g2f2" "g/g/ f/e/ f2" "g/e/ d/c/ ff" "g/c/ f/e/ f2" "ff e/c/ a/c/" "f e/d/ ec" "f/f/ e/d/ e/e/ d/c/" "f e/d/ e/g/ e/c/" "f (ff/)e/ d/c/" "f3/2 f/ e/d/ e/c/" "ff2e" "ffeg" "f/B/ c/d/ e/g/ f/e/" "d3 c/d/" "d g/a/g3/2 f/" "d2d2" "d4" "dg2 f/g/" "d d/c/ d/e/ f" "dGgf" "dgGf" "d g/a/ g/a/ f/g/" "e/f/ d/e/ c2" "e/f/ e/d/ c2" "e d/e/ c2" "e/d/ e/d/ c2" "e/f/ g/e/ c2" "e/g/ e/d/ c2" "e/c/ e/d/ c2" "e3/2 d/ c2" "e/c'/ g/e/ c2")

#----------------------------------------------------------------------------------
# define notesF, array of 54 possible measures bass clef notes
#----------------------------------------------------------------------------------
# Note: 39th measure last note from B, to A,?
notesF=("z2CC" "C3C" "C E/D/ CC" "C,2C2" "z2 C2" "z E,/D,/ C,C" "C4" "C, E,/G,/ CC" "C/C,/ E,/G,/ CC" "C B,/A,/ B,G," "CCB,B," "C/C/ B,/A,/ C/B,/ A,/G,/" "C B,/A,/ B,/D/ B,/G,/" "CC2B," "CCB,E" "C B,/A,/ B,/C/ D/E/" "CB, E/D/ C/B,/" "C/C/ B,/A,/ C/B,/ A,/G,/" "A,2 D/C/B,/A,/" "A,3_A," "A,A, A,/C/ A,/F,/" "(A,2 A,/)B,/ C/D/" "A,2 D,/F,/ E,/D,/" "A,3D" "A,(A,A,/)A,/ G,/F,/" "A,A,2D" "(A,2A,/)C/ B,/A,/" "G, A,/B,/ C2" "G,2 CC" "G,G,C2" "G,/G,/ A,/B,/ C2" "G,/D/ C/B,/ CC" "G,G,CC" "G,/G,/ C/B,/ CC" "G, C/B,/ C2" "G,2C,C" "C B,/A,/B,2" "C B,/A,/B, A,/B,/" "C (B,B,/)A,/ B," "C/A,/ B,/C/ B,/C/ A,/B,/" "CCB,B," "CB,2 A,/B,/" "C2B,2" "C2B, A,/B,/" "C/C/ B,/A,/ B,/B,/ A,/B,/" "C4" "C4" "C4" "C4" "C4" "C4" "C4" "C4" "C4")

#----------------------------------------------------------------------------------
# create cat-to-output-file function
#----------------------------------------------------------------------------------
catToFile(){
	cat >> $filen << EOT
$1
EOT
}

#----------------------------------------------------------------------------------
# create empty ABC file
# set header info: generic index number, filename
#----------------------------------------------------------------------------------
fileInd=$1w$7-$2w$8-$3w$9-$4w${10}-$5w${11}-$6w${12}
filen="cpeb-$fileInd.abc"
dbNum=$(( 1 + (${diceSG[0]}-1) +(${diceSG[1]}-1)*9 +(${diceSG[2]}-1)*9**2 +(${diceSG[3]}-1)*9**3 +(${diceSG[4]}-1)*9**4 + (${diceSG[5]}-1)*9**5 + (${diceSF[6-6]}-1)*9**6 +(${diceSF[7-6]}-1)*9**7 +(${diceSF[8-6]}-1)*9**8 +(${diceSF[9-6]}-1)*9**9 +(${diceSF[10-6]}-1)*9**10 + (${diceSF[11-6]}-1)*0 ))

#-----------------------------------------------------------------------------------------------------
# calculate permutation number for the current dice toss (from 9^6*9^5 = 31,381,059,609 possibilities)
# @90 bpm 
# 16,736,565,124.80 min =	278,942,752.08 hrs = 11,622,614.67 days = 31,820.98 years
#-----------------------------------------------------------------------------------------------------
currMeas=0
measPerm=""
for measj in ${diceSG[*]}; do
	ruletab $measj
	measPerm="$measPerm${measNR[$currMeas]}"
#	echo $measPerm
	ruletab ${diceSF[$currMeas]}
	measPerm="${measPerm}w${measNR[$currMeas]}-"
#	echo $measPerm
	currMeas=`expr $currMeas + 1`
done
measPerm="$measPerm:"

#----------------------------------------------------------------------------------
# if output abc file already exists, then make a back-up copy
#----------------------------------------------------------------------------------
if [ -f $filen ]; then 
	mv $filen $filen."bak"
fi


#----------------------------------------------------------------------------------
# generate the header of the ABC file
#----------------------------------------------------------------------------------
catToFile "%%scale 0.65
%%pagewidth 21.10cm
%%bgcolor white
%%topspace 0
%%composerspace 0
%%leftmargin 0.80cm
%%rightmargin 0.80cm
X:$dbNum
T:$fileInd
%%setfont-1 Courier-Bold 14
T:\$1cpeb::$measPerm\$0
T:\$1Perm. No.: $dbNum\$0
M:2/2
L:1/4
Q:1/4=90
%%staves [1 2]
V:1 clef=treble
V:2 clef=bass
K:C"

#----------------------------------------------------------------------------------
# write the notes of the ABC file
#----------------------------------------------------------------------------------
currMeas=0
for measj in ${diceSG[*]} ; do
# echo $currMeas
	ruletab $measj
	measNG=${measNR[$currMeas]}
	ruletab ${diceSF[$currMeas]}
	measNF=${measNR[$currMeas]}
	phrG=${notesG[$measNG-1]}
	phrF=${notesF[$measNF-1]}
	currMeas=`expr $currMeas + 1`
	if [ "${currMeas}" == "1" ]; then
		catToFile "%1
[V:1]|: $phrG |\\
[V:2]|: $phrF |\\"
		continue
	elif [ "$currMeas" == "6" ]; then
		catToFile "%6
[V:1] $phrG :|]
[V:2] $phrF :|]"
		continue
	else
		catToFile "%$currMeas
[V:1] $phrG |\\
[V:2] $phrF |\\"
	fi
#	echo "Here 6"
#	echo $currMeas
done

# create SVG
abcm2ps ./$filen -O ./"cpeb-$fileInd.svg" -g

# create MIDI
abc2midi ./$filen -quiet -silent -o ./"cpeb-$fileInd.mid"
#
##
###
