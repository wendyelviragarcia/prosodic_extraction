

#	extracts_f0_from_points_and_matching_interval_label.praat (2018)
#
# 	Reads sound files and its TextGrid tier for each of the sounds and it can get:
#		a) labels from a point tier
#		b) time of point
#		c) F0 of wav at that time 
#		d) Label in an upper or lower interval tier
# 		
#	The output is a txt (tab separated) that is saved in the same folder of your files. Name of file: "f0_log.txt"
#	
# 
# 								INSTRUCTIONS
#	0. You need a .wav with its Textgrid saved in the same folder and with at least 1 point tier and 1 interval tier.
#	1. Run
#	2. FORM EXPLANATIONS:
#		In the first field you must write the path of the folder where your files are kept
# 			in a mac something like: /Users/yourName/Desktop
# 			for windows: C:\Users\yourUserName\Desktop
# 			if you have a linux, you don't need me to tell you your path
#		
#	Any feedback is welcome, please if you notice any mistakes or come up with anything that can improve this script, let me know!
#
#		Wendy Elvira-García
#		Laboratory of Phonetics (University of Barcelona)
#		wendyelviragarcia@gmail.com
#		
#		
##############################################################################################################

if praatVersion < 5363
	exit Your Praat version is too old. Download at least version 5.3.63
endif

form extract F0_point_and_labels_from_interval
	sentence Folder /Users/weg/Desktop/n/
	comment Which tier do you want to use to extract the data (point tier)?
	integer tier 2
	comment From which matching interval tier do you want to extract labels?
	integer tierMatchingLabel 1
	comment Parameters for the analysis of F0
	integer f0_floor 75
	integer f0_ceiling 600
endform

########################################
#folder$ = chooseDirectory$ ("Choose a directory to read")
#creates txt file
writeFileLine: folder$+ "/"+ "f0_log.txt" , "Filename", tab$, "PointLabel", tab$, "time of Point", tab$, "fo", tab$, "labelIntervalInOtherTier"

Create Strings as file list: "list", folder$+ "/" +"*.wav"
numberOfFiles = Get number of strings

#empieza el bucle
for ifile to numberOfFiles
	######################	ACCIONES PARA TODOS LOS archivos	#############################
	select Strings list
	fileName$ = Get string: ifile
	appendFile: folder$+ "/"+ "f0_log.txt" , fileName$, tab$
	base$ = fileName$ - ".wav"

	# Lee el Sonido
	mySound = Read from file: folder$+ "/" + base$ + ".wav"
	# Lee el TextGrid
	myText= Read from file: folder$ +"/"+ base$ + ".TextGrid"
	selectObject: mySound
	myPitch= To Pitch: 0, f0_floor, f0_ceiling
	#To Pitch (ac): 0, 75, 15, 0, 0.03, 0.45, 0.01, 0.35, 0.14, 600
	myPitchTier= Down to PitchTier
	removeObject: myPitch


	selectObject: myText
	numberOfPoints= Get number of points: tier

	# for each point in the textgrid, get the time of the point and the F0 and that point, then writes it down in txt file
	for point to numberOfPoints
		#gets the time of the point
		selectObject: myText
		timeOfPoint= Get time of point: tier, point
		labelOfPoint$= Get label of point: tier, point

		intervalInOtherTier = Get interval at time: tierMatchingLabel, timeOfPoint
		labelIntervalInOtherTier$ = Get label of interval: tierMatchingLabel, intervalInOtherTier
	
		#extracts f0 values
		selectObject: myPitchTier
		f0_value = Get value at time: timeOfPoint
		f0_value$ = fixed$ (f0_value, 0)
		
		#lo escribe 
		appendFile: folder$+ "/"+ "f0_log.txt" , labelOfPoint$, tab$, timeOfPoint, tab$, f0_value$, tab$, labelIntervalInOtherTier$, tab$
	endfor


	appendFileLine: folder$+ "/"+ "f0_log.txt" , tab$

	removeObject: mySound, myText, myPitchTier
endfor
