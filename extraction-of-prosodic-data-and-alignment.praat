#############################################################################################################################################################
# extraction-of-prosodic-data-and-alignment (v. 1.0) (version para corpus del angular)
#  Gets F0 and peak alignment
# Wendy Elvira-García
#  Citation: Elvira-García, Wendy (2014). Extraction of prosodic data and alignment v.1.0. [Praat script]
# (february, 2014, for Praat 5.58)
###########################################################################################################################
#
#									DESCRIPTION
#				This script runs through all the files in a folder and gets its:
#				1) interval number, label, Fo...
#				2) and writes the data in a tab separated txt							
#									INSTRUCTIONS
# 				1) This script works with 5 tiers: 
#					1) interval tier with the whole sentence
#					2) interval tier with the segments
#					3) interval tier with syllables	
#					4) point tier with the break indices	
#					5) point tier with the minimum and maximum F0
#				and extracts the necessary data one row par file
#			The txt will be saved in the same folder where the script is.
#
#		comments are always welcome 
#	Wendy Elvira-Garcia
#	wendyelviragarcia@gmail.com
#	Laboratori de Fonètica (University of Barcelona)
#
#	
####################################		FORMULARIO		###################################################################################

if praatVersion < 5363
	exit Your Praat version is too old. Download at least version 5.3.63
endif

##############################		VARIABLES PREDEFINIDAS		############################################################################################

txtName$ = "extraccion-angular"
speakers_id = 1
folder$ = chooseDirectory$ ("Where are your files?")

####################

# form Peak alignment
	# comment All the files in the folder you write in here will be processed:
	# sentence Folder C:\Users\Laboratori15\Desktop\subjecte_la_annotats\
	# word txtName extraccion-angular
	# comment Do you have a "speaker code"? How many characters it has?
	# integer speakers_id 4
# endform


#Encabezado

writeFileLine: "extraccion-angular.txt"

appendFile: "'txtName$'.txt", "speaker	", "file	",
... "enunciat	", "duration	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number	", "label	", "duration	", "F0_1	", "F0_2	", "F0_3	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "interval_number_syllable	", "label_syllable	", "duration_syllable	", "F0_1 syllable	", "F0_2 syllable	", "F0_3 syllable	",
... "label BI	", "F0-punto BI	",
... "label BI	", "F0-punto BI	",
... "label BI	", "F0-punto BI	",
... "label BI	", "F0-punto BI	",
... "label BI	", "F0-punto BI	",
... "label	", "F0-punto	", "segmento	", "porcentajedelsegmento	", "silaba	", "porcentaje de la sílaba	",
... "label	", "F0-punto	", "segmento	", "porcentajedelsegmento	", "silaba	", "porcentaje de la sílaba	",
... "label	", "F0-punto	", "segmento	", "porcentajedelsegmento	", "silaba	", "porcentaje de la sílaba	",
... newline$


########################################
#folder$ = chooseDirectory$ ("Choose a directory to read")
Create Strings as file list... list 'folder$'/*.wav
numberOfFiles = Get number of strings

#empieza el bucle
for ifile to numberOfFiles
	######################	ACCIONES PARA TODOS LOS archivos	#############################
	select Strings list
	fileName$ = Get string... ifile
	base$ = fileName$ - ".wav"

	# Lee el Sonido
	Read from file... 'folder$'/'base$'.wav
	# Lee el TextGrid
	Read from file... 'folder$'/'base$'.TextGrid
	select Sound 'base$'
	do ("To Pitch (ac)...", 0, 75, 15, "no", 0.03, 0.45, 0.01, 0.35, 0.14, 600)
	Down to PitchTier
	
	# Consigue el nombre del informante
	# left$ (a$, n)
	speakersId$ = left$ (base$, speakers_id)
	# lo escribe
	appendFile ("'txtName$'.txt", "'speakersId$'	", "'base$'	")

	######################		TIER 1	######################
	#Consigue el nombre de cada intervalo
	select TextGrid 'base$'
	
	#el primer numero es el numero de tier el segundo el de intervalo
	label$ = Get label of interval... 1 2
	start_point = Get start point... 1 2
	end_point = Get end point... 1 2
	duration = end_point - start_point
	duration$ = fixed$ (duration, 4)
	
	appendFile ("'txtName$'.txt", "'label$'	", "'duration$'	")
	
	
	######################	BUCLE DE INTERVALOS	TIER 2	######################
	select TextGrid 'base$'
	numberOfIntervals=  Get number of intervals: 2

	for n to numberOfIntervals
		select TextGrid 'base$'
		label$ = Get label of interval: 2, n
		start_point = Get start point... 2 n
		end_point = Get end point... 2 n
		duration = end_point - start_point
		#pasa la duracion a milisegundos, cuidado que Praat no puede trabajar con ella así!!
		mid_point = start_point + (duration/2)
		duration = duration * 1000
		duration$ = fixed$ (duration, 2)

		select PitchTier 'base$'
		f0_1 = Get value at time... start_point
		f0_2 = Get value at time... mid_point
		f0_3 = Get value at time... end_point
		
		f0_1$ = fixed$ (f0_1, 0)
		f0_2$ = fixed$ (f0_2, 0)
		f0_3$ = fixed$ (f0_3, 0)
		
		#lo escribe 
		appendFile: "'txtName$'.txt", "'n'	", "'label$'	", "'duration$'	", "'f0_1$'	", "'f0_2$'	", "'f0_3$'	"

		
	endfor
	
	if numberOfIntervals < 30
		resto = 30 - numberOfIntervals 
		for i to resto
			appendFile ("'txtName$'.txt", "-	", "-	", "-	", "-	", "-	", "-	")
		endfor
	endif
	######################	BUCLE DE INTERVALOS	TIER 3	######################
	select TextGrid 'base$'
	numberOfIntervals = Get number of intervals: 3
	
	for n to numberOfIntervals
		select TextGrid 'base$'
		label$ = Get label of interval: 3, n
		start_point = Get start point... 3 n
		end_point = Get end point... 3 n
		duration = end_point - start_point
		mid_point = start_point + (duration/2)
		#pasa la duracion a milisegundos, cuidado que Praat no puede trabajar con ella así!!
		duration = duration * 1000
		duration$ = fixed$ (duration, 2)

		select PitchTier 'base$'
		f0_1 = Get value at time... start_point
		f0_2 = Get value at time... mid_point
		f0_3 = Get value at time... end_point
		
		f0_1$ = fixed$ (f0_1, 0)
		f0_2$ = fixed$ (f0_2, 0)
		f0_3$ = fixed$ (f0_3, 0)
		
		#lo escribe 
		appendFile ("'txtName$'.txt", "'n'	", "'label$'	", "'duration$'	", "'f0_1$'	", "'f0_2$'	", "'f0_3$'	")

		
	endfor
	if numberOfIntervals < 14
		resto = 14 - numberOfIntervals 
			for i to resto
				appendFile ("'txtName$'.txt", "-	", "-	", "-	", "-	", "-	", "-	")
			endfor
		endif
	######################	BUCLE DE PUNTOS	TIER 4	BI ######################
	select TextGrid 'base$'
	numberOfPoints = Get number of points: 4
	
	for n to numberOfPoints
		select TextGrid 'base$'
		label$ = Get label of point... 4 n
		point_time = Get time of point... 4 n
		select PitchTier 'base$'
		f0 = Get value at time... point_time
		f0$ = fixed$ (f0, 0)
		
		
		#lo escribe 
		appendFile ("'txtName$'.txt", "'label$'	", "'f0$'	")
		
		

	endfor
	if numberOfPoints < 5
			resto = 5 - numberOfPoints 
			for i to resto
				appendFile ("'txtName$'.txt", "-	", "-	")
			endfor
		endif
		
	######################	BUCLE DE PUNTOS	TIER 5	######################
	select TextGrid 'base$'
	numberOfPoints = Get number of points: 5
	
	for n to numberOfPoints
	
		label$ = Get label of point... 5 n
		point_time = Get time of point... 5 n
		select PitchTier 'base$'
		f0 = Get value at time... point_time
		f0$ = fixed$ (f0, 0)
		
		####### donde están situados los puntos máximos y mínimos de f0
		select TextGrid 'base$'
		segmento = Get interval at time... 2 point_time
		silaba = Get interval at time... 3 point_time
		segmento$ = Get label of interval... 2 segmento
		silaba$ = Get label of interval... 3 silaba
		
		startdelsegmento = Get start point... 2 segmento
		enddelsegmento = Get end point... 2 segmento
		durationsegmento = enddelsegmento - startdelsegmento
		ptorelseg = point_time - startdelsegmento
		porcentajedelsegmento = (ptorelseg *100) / durationsegmento
		
		porcentajedelsegmento$ = fixed$ (porcentajedelsegmento, 2)
		
		
		startdelasilaba = Get start point... 3 silaba
		enddelasilaba = Get end point... 3 silaba
		durationsilaba = enddelasilaba - startdelasilaba
		ptorelsil = point_time - startdelasilaba
		porcentajedelasilaba = (ptorelsil*100) / durationsilaba
		porcentajedelasilaba$ = fixed$ (porcentajedelasilaba, 2)
		#lo escribe 
		
		appendFile ("'txtName$'.txt", "'label$'	", "'f0$'	","'segmento$'	", "'porcentajedelsegmento$'	", "'silaba$'	", "'porcentajedelasilaba$'	")
	
	endfor
	
		if numberOfPoints < 3
			resto = 3 - numberOfPoints 
			for i to resto
				appendFile ("'txtName$'.txt", "-	", "-	")
			endfor
		endif
	
	appendFile ("'txtName$'.txt", newline$) 
	
	############# GUARDA ############# 
	# escribe una linea por cada fichero
endfor
	############# LIMPIA ############# 
