#	prosodic_data_extraction (2.2- April 2016)
#
# 	Reads sound files and its TextGrid tier for each of the sounds and it can get:
#		a) labels form a interval tier, 
#		b) labels from a point tier, 
# 		c) the tonicity of the syllable (for this you will need to previously have written a tonicity mark in your TextGrid, 
# 		d) duration, 
#		e) intensity (maximum or at the mean point you can change it on the script) 
#		f) F0 in Hz at 3 time points per syllable (onset, medium and offset). 
#		g) F0 in St at 3 time points per syllable (onset, medium and offset), the St reference can be the mean pitch of the sentence or the pitch of the centre of previous interval
# 		h) The difference in St between the highest point of the last stressed syllable and the last boundary tone in the syllable (for this option you will need a tonicity mark in your TextGrids)	
#
#
#	The data are written down in a tab-separated txt which can be organised:
# 	
#		a) One line for each Soundfile and all values in groups right aligned (you must specify your maximum number of intervals that the script 
#			will find in a TextGrid for this option). 
#		b) One line for each interval	
#		
#	
# 		The pitch settings can be given by the researcher. But the script is also prepared to carry out the speaker's range setting automatically.
#	
#	
# 
# 								INSTRUCTIONS
#	0. You need a .wav with its Textgrid saved in the same folder and with at least 1 interval tier.
#	1. Run
#	2. FORM EXPLANATIONS:
#		In the first field you must write the path of the folder where your files are kept
#		The second allows you to choose the name of the txt that will be created
#		In the following fields mark the data you want to extract
#			for some of them you must supply complementary information such as the number of the tier, or the tonicity mark (if any)
#
#		Finally, choose how do you want your data file to be display: (by file or interval) 
#		If you have chosen any data which involves a Pitch object, a new window will appear in it you will be asked wither to provide your speaker's voice parameters or choose the automatic detection
# 		of the previous interval.
#		You will also be asked for the St referencle in case you have choose it (centre of the previous syllable or mean). 
#
#	Any feedback is welcome, please if you notice any mistakes or come up with anything that can improve this script, let me know!
#	
#	Wendy Elvira-García (2014). Prosodic-data-extration v2.2. [Praat script] (Retrieved from http://stel.ub.edu/labfon/en/praat-scripts) Distributed under GNU General Public License.
#
#		Wendy Elvira-García
#		Laboratory of Phonetics (University of Barcelona)
#		wendyelviragarcia @ g m a i l . c o m
#		
#		
##############################################################################################################





#Limpia los objetos que te has olvidado en el Praat antes de empezar, sí, tb los que no guardaste.
select all
if numberOfSelected() > 0
	pause There are objects in the list, the script will remove them
	Remove
endif

if praatVersion < 5363
exit This script works only in Praat 5363 or higher
endif

#folder$ = chooseDirectory$ ("Elige la carpeta donde están los archivos que quieres analizar:")

form Prosodic_data_extraction
	comment In which folder are your files? (with \ or / at the end)	
	text Folder /Users/YourUserHere/Desktop/myWavsAndTextGrids/
	comment txt name (it will be created in the same folder where the files are kept): 
	text txtname results_file
	comment ¿Which data do you want to extract?
	boolean interval_tier_labels 1
	comment Tier number for interval tier labels (usually syllable transcription):
	integer tier_interval 1
	boolean point_tier_labels 1
	comment Tier number for point tier labels (usually ToBI):
	integer point_tier 5
	comment Do you mark anyhow the stressed syllable? If you do, how do you do it?
	text tonic ˈ
	
	boolean duration 0
	boolean intensity 0
	boolean F0_Hz 0
	boolean F0_St 0
	boolean last_difference 1
	
	comment How do you want the data to be collected?
	choice Sort_data 1
		option One row per file
		option One row per interval
	comment Maximum number of intervals TextGrid? (only used for one row per file condtion, alignment to the right purposes)
	integer maxint 30
	

endform


if f0_Hz=1 or f0_St= 1 or last_difference = 1
 beginPause ("Data for F0 analysis")
	
	comment ("Which interval tier do you want to use for the F0 extraction")
	integer ("extraction_tier", 1)
	choice ("range_obtention_method", 2)
		option ("Manual")
		option ("Hirst's_method")
	comment (" ")
	if f0_St = 1
	comment ("How do you want the St to be calculated?")
		choice ("St_reference", 1)
		option ("The mean of each file")
		option ("The previous syllable")
	endif		
	comment ("You can change here the way how Praat finds the F0 path")
	comment ("If you are choosing to obtain the range of the speaker automatically the f0min and f0max here won't be taken on account")
			positive ("f0min", 75)
			positive ("f0max", 600)
			positive ("voicing_threshold", 0.45)
			positive ("octave_cost", 0.01)
			positive ("octave_jump_cost", 0.35) 
			positive ("voiced_unvoiced_cost", 0.14)
 
 endPause ("OK", 1)
endif


		
#########################		CREA ARCHIVO DE TABLA Y ENCABEZADOS	#########################################





# Crea el archivo txt y dejo preparados 2 encabezados.
arqout$ = folder$ + txtname$ + ".txt"
if fileReadable (arqout$)
	pause There is already a file with that name, you will overwrite it
	deleteFile: arqout$
endif



# encabezados para una linea por fichero, alineado a la derecha
if sort_data = 1

	appendFile: arqout$, "filename", tab$
	if interval_tier_labels = 1
		for 1 to maxint
			appendFile: arqout$, "AFI", tab$
		endfor
	endif

	if tonic$ <> ""
		for 1 to maxint
			appendFile: arqout$, "Tonicity", tab$
		endfor
	endif
	
	if point_tier_labels = 1
		for 1 to maxint
			appendFile: arqout$, "ToBI", tab$
		endfor
	endif
	
	if duration = 1
		for 1 to maxint
			appendFile: arqout$, "duration[ms]", tab$ 
		endfor
	endif

	if intensity = 1
		for 1 to maxint
			appendFile: arqout$, "intensity", tab$
		endfor
	endif

	if f0_Hz = 1
		for 1 to maxint
			appendFile: arqout$, "fo1[Hz]", tab$, "fo2[Hz]", tab$, "fo3[Hz]", tab$
		endfor
	endif

	if f0_St = 1
		for 1 to maxint
			appendFile: arqout$, "fo1[St]", tab$, "fo2[St]", tab$, "fo3[St]", tab$
		endfor
	endif

	if last_difference =1
	appendFile: arqout$, "Difference between max F0 in the stressed and last point of the sentence [St]", tab$
	endif
	
	appendFile: arqout$, newline$
endif

if sort_data = 2
	appendFileLine: arqout$, "Filename", tab$, "n interval", tab$, "AFI", tab$, "Tonicity", tab$, "ToBI", tab$, "Duration [ms]", tab$, "Intensity", tab$, "fo1", tab$, "fo2", tab$, "fo3[Hz]", tab$, "fo1", tab$, "fo2", tab$, "fo3[St]", tab$, "Difference between max F0 in the stressed and last point of the sentence [St]", tab$
endif
##################################	BUCLE	#####################################


#  bucle principal ciérrame al final del script
# Crea la lista de objetos desde el string
Create Strings as file list... list 'folder$'/*.wav
#Hace el bucle con ello
numberOfFiles = Get number of strings
for ifile to numberOfFiles
	select Strings list
	file$ = Get string... ifile
	base$ = file$ - ".wav"
	fil$ = folder$ + file$
	

	#lee el archivo de sonido
	Read from file... 'folder$'/'file$'
	base$ = selected$ ("Sound")

	#lee el texgrid
	filegrid$ = base$ + ".TextGrid"
	Read from file... 'folder$'/'filegrid$'

	# Crea objetos intensity y pitch si son necesarios
	if intensity = 1
	select Sound 'base$'
			To Intensity... 100 0.0 no
	endif
	
	if f0_Hz=1 or f0_St= 1 or last_difference = 1
		if range_obtention_method = 1
			select Sound 'base$'
			To Pitch (ac)... 0.005 'f0min' 15 no 0.03 'voicing_threshold' 'octave_cost' 'octave_jump_cost' 'voiced_unvoiced_cost' 'f0max'
		else
			select Sound 'base$'
			#To Pitch (ac)... 0.005 50 15 no 0.03 'voicing_threshold' 'octave_cost' 'octave_jump_cost' 'voiced_unvoiced_cost' 650
			#f0min = Get minimum... 0 0 Hertz Parabolic
			#f0max = Get maximum... 0 0 Hertz Parabolic
			#f0min = f0min - 50
			#f0max = f0max + 50
			#Rename: "pitch_viejo"
			#select Sound 'base$'
			#To Pitch (ac)... 0.005 'f0min' 15 no 0.03 'voicing_threshold' 'octave_cost' 'octave_jump_cost' 'voiced_unvoiced_cost' 'f0max'
			@determine_pitch_floor_hirst
			
			procedure determine_pitch_floor_hirst
				mySound = selected("Sound")
				To Pitch... 0.01 60 700
				q1 = Get quantile... 0 0 0.25 Hertz
				q3 = Get quantile... 0 0 0.75 Hertz
				Remove
				select mySound
				floor = q1*0.75
				ceiling = q3*2
				myPitch = To Pitch... 0.01 floor ceiling
			endproc
		endif
	
	endif
	
	
	#condicion de 1 fila por fichero
	if sort_data = 1
		appendFile: arqout$, base$, tab$
		
		#################	BUSCA NOMBRES DE ETIQUETAS Y LOS EXTRAE ##################
		############################# 		ETIQUETAS SILABAS 		#############################

		if interval_tier_labels = 1

			select TextGrid 'base$'
			numerointervalos = Get number of intervals: tier_interval
			while numerointervalos < maxint
				appendFile: arqout$,  "x", tab$
				numerointervalos =numerointervalos+1
			endwhile
			
			numerointervalos = Get number of intervals: tier_interval
			i=1
			for i to numerointervalos
				etiquetaintervalo$ = Get label of interval: tier_interval, i
				appendFile: arqout$, etiquetaintervalo$, tab$
			endfor
			
		endif
		
		############################# 		TONICIDAD 		#############################
			if tonic$ <> ""
				select TextGrid 'base$'
				tonicidad$ = "0"
				numerointervalos = Get number of intervals: tier_interval
				while numerointervalos < maxint
					appendFile: arqout$,  "x", tab$
					numerointervalos =numerointervalos+1
				endwhile
				
				numerointervalos = Get number of intervals: tier_interval
				interval =1
				for interval to numerointervalos
					numberOfIntervals=  Get number of intervals: tier_interval
					if interval < (numberOfIntervals -1)
						etiquetasiguiente$= Get label of interval: tier_interval, interval+1
						primercaracter$ = left$ (etiquetasiguiente$, 1)
						if primercaracter$ = tonic$
							tonicidad$ = "pretonica"
						endif
					endif
					
					if interval < (numberOfIntervals -2)
						etiquetasiguiente$= Get label of interval: tier_interval, interval+2
						primercaracter$ = left$ (etiquetasiguiente$, 1)
						if primercaracter$ = tonic$
							tonicidad$ = "prepretonica"
						endif
					endif
					
					
					if (interval - 1) >= 1
						etiquetaanterior$= Get label of interval: tier_interval, interval-1
						primercaracter$ = left$ (etiquetaanterior$, 1)
						if primercaracter$ = tonic$
							tonicidad$ = "postonica"
						endif
					endif
					
					if (interval - 2) >= 1
						etiquetaanteanterior$= Get label of interval: tier_interval, interval-2
						primercaracter$ = left$ (etiquetaanteanterior$, 1)
						if primercaracter$ = tonic$
							tonicidad$ = "pospostonica"
						endif
					endif
					
					etiquetaintervalo$ = Get label of interval: tier_interval, interval
					primercaracter$ = left$ (etiquetaintervalo$, 1)
					if primercaracter$ = tonic$
						tonicidad$ = "tonica"
					endif
					
				
					appendFile: arqout$, tonicidad$, tab$
					
				endfor
				
				endif
		############################# 		ETIQUETAS ToBI 		#############################

		if point_tier_labels = 1
			select TextGrid 'base$'
			numeropuntos = Get number of points: point_tier

			while numeropuntos < maxint 
				appendFile: arqout$, "x", tab$
				numeropuntos = numeropuntos+1		
			endwhile	
			
			
			numeropuntos = Get number of points: point_tier
			i=1
			for i to numeropuntos
				etiquetapunto$ = Get label of point: point_tier, i
				appendFile: arqout$, etiquetapunto$, tab$
			endfor
			
		endif

		

		#############################		DURACION	################################################

		if duration = 1

			select TextGrid 'base$'
			numerointervalos = Get number of intervals: tier_interval
			while numerointervalos < maxint
				appendFile: arqout$, "x", tab$
				numerointervalos = numerointervalos+1
			endwhile	
			
			numerointervalos = Get number of intervals: tier_interval
			k=1
			for k from 1 to numerointervalos
				select TextGrid 'base$'
				label$ = Get label of interval: tier_interval, k
				if label$ <> ""
					# pto inicio y pto final
					onset = Get starting point: tier_interval, k
					offset = Get end point: tier_interval, k		
					dur = offset-onset
					durms = dur*1000
					dur$ = fixed$(durms,2)
					appendFile: arqout$, dur$, tab$
				else 	
					appendFile: arqout$, "x", tab$
				endif
			endfor
		
		endif

		############################	intensity	################################
		if intensity = 1
		
			

			select TextGrid 'base$'
			numerointervalos = Get number of intervals... tier_interval
			while numerointervalos < maxint
				appendFile: arqout$, "x", tab$
				numerointervalos = numerointervalos + 1
			endwhile
			
			
			numerointervalos = Get number of intervals... tier_interval
			k=1
			for k from 1 to numerointervalos
				select TextGrid 'base$'
				label$ = Get label of interval: tier_interval, k
				if label$ <> ""			
					onset = Get starting point: tier_interval, k
					offset = Get end point: tier_interval, k		
					dur = offset-onset			
					ptomediointervalo  = onset + (dur/2)
					select Intensity 'base$'
					#Activa esta si quieres la intensity en el pto central del interval
					#int = Get value at time... 'ptomediointervalo' Cubic
					#Activa esta si quieres la maxima intensity en el interval
					int= Get maximum... onset offset Parabolic
					int$ = fixed$(int,0)
					appendFile: arqout$, int$, tab$
				else 
					appendFile: arqout$, "x", tab$
				endif
			endfor

		endif
		
		#####################			F0	Hz	##################################

		if f0_Hz = 1
			select TextGrid 'base$'
			numerointervalos = Get number of intervals: tier_interval
			while numerointervalos < maxint
				appendFile: arqout$, "x", tab$, "x", tab$, "x", tab$
				numerointervalos=numerointervalos+1	
			endwhile
			
			
			
			
			select TextGrid 'base$'
			numerointervalos = Get number of intervals: tier_interval
			k=1
			for k to numerointervalos
				select TextGrid 'base$'
				label$ = Get label of interval: tier_interval, k
				if label$ <> ""	
					onset = Get starting point: tier_interval, k
					offset = Get end point: tier_interval, k
					dur=offset-onset
					ptomediointervalo  = onset + (dur/2)
					select Pitch 'base$'
					pitch1 = Get value at time... onset Hertz Linear
					pitch2 = Get value at time... ptomediointervalo Hertz Linear
					pitch3 = Get value at time... offset Hertz Linear
					#si hay valores undefined hace un PtichTier
					if pitch1= undefined or pitch2= undefined or pitch3 = undefined
						select Pitch 'base$'
						do ("Down to PitchTier")
						if pitch1 = undefined
							pitch1 = Get value at time: onset 
						endif
						if pitch2=undefined
							pitch2 = Get value at time: ptomediointervalo 
						endif
						if pitch3 =undefined
							pitch3 = Get value at time: offset 
						endif
					endif
						
						
					pitch1$ = fixed$ (pitch1,0)
					pitch2$ = fixed$ (pitch2,0)
					pitch3$ = fixed$ (pitch3,0)
					appendFile: arqout$, pitch1$, tab$, pitch2$, tab$, pitch3$, tab$
				else 
					appendFile: arqout$, "x", tab$, "x", tab$, "x", tab$
				endif
			endfor
			
		endif

		#########################################

		#####################		F0	ST	##################################

		if f0_St = 1
			select TextGrid 'base$'
			numerointervalos = Get number of intervals: tier_interval
			while numerointervalos < maxint
				appendFile: arqout$, "x", tab$, "x", tab$, "x", tab$
				numerointervalos= numerointervalos+1
			endwhile
			
			
			if st_reference = 1
				select Pitch 'base$'
				referencia = do ("Get mean...", 0, 0, "Hertz")
			endif	
			
			
			select TextGrid 'base$'
			numerointervalos = Get number of intervals: tier_interval
			k=1
			for k to numerointervalos
				select TextGrid 'base$'
				label$ = Get label of interval: tier_interval, k
				if label$ <> ""	
					onset = Get starting point: tier_interval, k
					offset = Get end point: tier_interval, k	
					dur =offset-onset
					ptomediointervalo  = onset + (dur/2)
						
					select Pitch 'base$'
					pitch1 = Get value at time... onset Hertz Linear
					pitch2 = Get value at time... ptomediointervalo Hertz Linear
					pitch3 = Get value at time... offset Hertz Linear
						
					#si hay valores undefined hace un smooth y coge los valores smootheados
					if pitch1= undefined or pitch2= undefined or pitch3 = undefined
						select Pitch 'base$'
						do ("Down to PitchTier")
						if pitch1 = undefined
							pitch1 = Get value at time: onset 
						endif
						if pitch2=undefined
							pitch2 = Get value at time: ptomediointervalo 
						endif
						if pitch3 =undefined
							pitch3 = Get value at time: offset 
						endif
					endif
						



						
					#calculo de referencia por el centro de la sílaba precedente		
					if st_reference = 2
						previousInterval = k-1
					
						if previousInterval >= 1
							select TextGrid 'base$'
							onset = Get starting point: tier_interval, previousInterval
							offset = Get end point: tier_interval, previousInterval
							dur =offset-onset
							ptomediointervalo  = onset + (dur/2)
							select Pitch 'base$'
							referencia = Get value at time... ptomediointervalo Hertz Linear
							if referencia = undefined
								select Pitch 'base$'
								do ("Down to PitchTier")
								referencia = Get value at time: ptomediointervalo
							endif
						endif
						#si es la primera sílaba de la frase el valor de referencia es el onset de la sílaba
						if previousInterval < 1
							onsetk = Get starting point: tier_interval, k
							referencia = Get value at time: onsetk Hertz Linear
							if referencia = undefined
								select Pitch 'base$'
								do ("Down to PitchTier")
								referencia = Get value at time: onsetk
							endif
						endif		
					endif

								

						
					#calculos para saber los ST
					pitch1St = (12 / log10 (2)) * log10 ('pitch1'/'referencia')
					pitch2St = (12 / log10 (2)) * log10 ('pitch2'/'referencia')
					pitch3St = (12 / log10 (2)) * log10 ('pitch3'/'referencia')
				
					pitch1St$ = fixed$(pitch1St,2)
					pitch2St$ = fixed$(pitch2St,2)
					pitch3St$ = fixed$(pitch3St,2)
					
					
					appendFile: arqout$, pitch1St$, tab$, pitch2St$, tab$, pitch3St$, tab$
				else 
					appendFile: arqout$, "x", tab$, "x", tab$, "x", tab$
				endif		
			endfor
		endif
		
		
		
		
		
		
		
		
		
		#################	calcular la ultima bajada	########################
			if last_difference = 1
				
				
				select TextGrid 'base$'
				numberOfIntervals = Get number of intervals: tier_interval
				
			i=1
				for i to numberOfIntervals
					label$ = Get label of interval: tier_interval, i
					primercaracter$ = left$ (label$, 1)
						if primercaracter$ = tonic$ 
							ultimatonica = i
						endif		
				endfor
				
				
			
				onset_tonica = Get starting point: tier_interval, ultimatonica
				last_boundary = Get end point: tier_interval, numberOfIntervals-1
				select Pitch 'base$'
				maxima_f0_ultimo_movimiento = Get time of maximum: onset_tonica, last_boundary, "Hertz", "None"		
				pitch_max_last_movement = Get value at time... maxima_f0_ultimo_movimiento Hertz Linear
				pitch_final = Get value at time... last_boundary Hertz Linear
				
					
				#si hay valores undefined hace un smooth y coge los valores smootheados
				if pitch_max_last_movement= undefined or pitch_final= undefined
					select Pitch 'base$'
					do ("Down to PitchTier")
					if pitch_max_last_movement = undefined
						pitch_max_last_movement = Get value at time... maxima_f0_ultimo_movimiento
					endif
					if pitch_final=undefined
						pitch_final = Get value at time... last_boundary
					endif
				endif
						

				#calculos para saber los ST
				diferencia_ultima_bajada = (12 / log10 (2)) * log10 (pitch_final/pitch_max_last_movement)
				
				diferencia_ultima_bajada$ = fixed$ (diferencia_ultima_bajada,2)
				
				
				
				appendFile: arqout$, diferencia_ultima_bajada$, tab$
			else 
				appendFile: arqout$, "-", tab$
			endif
			
		
			#################
		##################################
		
	#acaba condicion de un archivo por fila
	endif
	
	
	
	#################
	#################
	#################
	##################################
	#################
	##################################
	#################
	#################
	
	
	
#################	PARA EXTRAER UNA FILA POR INTERVALO ##################
	if sort_data =2
		select TextGrid 'base$'
		numerointervalos = Get number of intervals: tier_interval
		for interval to numerointervalos
			appendFile: arqout$, base$, tab$, interval, tab$
			
			############################# 		ETIQUETAS SILABAS 		#############################

			if interval_tier_labels = 1

				select TextGrid 'base$'
				etiquetaintervalo$ = Get label of interval... tier_interval interval
				appendFile: arqout$, etiquetaintervalo$, tab$
			else		
				appendFile: arqout$, "-", tab$
			endif
			
			############################# 		TONICIDAD 		#############################
			if tonic$ <> ""
				select TextGrid 'base$'
				tonicidad$ = "0"
				
				
				numberOfIntervals=  Get number of intervals: tier_interval
				if interval < (numberOfIntervals -1)
					etiquetasiguiente$= Get label of interval: tier_interval, interval+1
					primercaracter$ = left$ (etiquetasiguiente$, 1)
					if primercaracter$ = tonic$
						tonicidad$ = "pretonica"
					endif
				endif
				
				if interval < (numberOfIntervals -2)
					etiquetasiguiente$= Get label of interval: tier_interval, interval+2
					primercaracter$ = left$ (etiquetasiguiente$, 1)
					if primercaracter$ = tonic$
						tonicidad$ = "prepretonica"
					endif
				endif
				
				
				if (interval - 1) >= 1
					etiquetaanterior$= Get label of interval: tier_interval, interval-1
					primercaracter$ = left$ (etiquetaanterior$, 1)
					if primercaracter$ = tonic$
						tonicidad$ = "postonica"
					endif
				endif
				
				if (interval - 2) >= 1
					etiquetaanteanterior$= Get label of interval: tier_interval, interval-2
					primercaracter$ = left$ (etiquetaanteanterior$, 1)
					if primercaracter$ = tonic$
						tonicidad$ = "pospostonica"
					endif
				endif
				
				etiquetaintervalo$ = Get label of interval: tier_interval, interval
				primercaracter$ = left$ (etiquetaintervalo$, 1)
				if primercaracter$ = tonic$
					tonicidad$ = "tonica"
				endif
				
			
				appendFile: arqout$, tonicidad$, tab$
			else
				appendFile: arqout$, "-", tab$
			endif
			############################# 		ETIQUETAS ToBI 		#############################
		
			if point_tier_labels = 1
				select TextGrid 'base$'
				#Tiene que sacar el punto de ese intervalo y si no hay ninguno que coincida pues en blanco
				startPointInterval = Get start point: tier_interval, interval
				endPointInterval = Get end point: tier_interval, interval
				centrodelintervalo = startPointInterval+ ((endPointInterval - startPointInterval)/2)
				punto = Get nearest index from time: point_tier, centrodelintervalo
				etiquetapunto$ = Get label of point: point_tier, punto
			
				appendFile: arqout$, etiquetapunto$, tab$
				
			else
				
				appendFile: arqout$, "-", tab$
			endif

		

			#############################		DURACION	################################################

			if duration = 1

				select TextGrid 'base$'
				label$ = Get label of interval: tier_interval, interval
				if label$ <> ""
					# pto inicio y pto final
					onset = Get starting point: tier_interval, interval
					offset = Get end point: tier_interval, interval
					dur = offset-onset
					durms = dur*1000
					dur$ = fixed$(durms,2)
					
					appendFile: arqout$, dur$, tab$
				else 	
					appendFile: arqout$, "-", tab$
				endif
			
			else
				appendFile: arqout$, "-", tab$
			endif

			############################	intensity	################################
			if intensity = 1
			
				select Sound 'base$'
				To Intensity... 100 0.0 no

				select TextGrid 'base$'
				label$ = Get label of interval: tier_interval, interval
				if label$ <> ""			
						onset = Get starting point: tier_interval, interval
						offset = Get end point: tier_interval, interval
						dur = offset-onset			
						ptomediointervalo  = onset + (dur/2)
						select Intensity 'base$'
						#Activa esta si quieres la intensity en el pto central del interval
						#int = Get value at time... 'ptomediointervalo' Cubic
						#Activa esta si quieres la maxima intensity en el interval
						int= Get maximum... onset offset Parabolic
						int$ = fixed$(int,0)
						appendFile: arqout$, int$, tab$
					else 
						appendFile: arqout$, "-", tab$
					endif
			else
				appendFile: arqout$, "-", tab$
			endif
			
			#####################			F0	Hz	##################################

			if f0_Hz = 1
				
				select TextGrid 'base$'
				label$ = Get label of interval: tier_interval, interval
				if label$ <> ""	
					onset = Get starting point: tier_interval, interval
					offset = Get end point: tier_interval, interval
					dur=offset-onset
					ptomediointervalo  = onset + (dur/2)
					
					select Pitch 'base$'
					pitch1 = Get value at time... onset Hertz Linear
					pitch2 = Get value at time... ptomediointervalo Hertz Linear
					pitch3 = Get value at time... offset Hertz Linear
					
					#si hay valores undefined hace un PtichTier
					if pitch1= undefined or pitch2= undefined or pitch3 = undefined
						select Pitch 'base$'
						do ("Down to PitchTier")
						if pitch1 = undefined
							pitch1 = Get value at time... onset 
						endif
						if pitch2=undefined
							pitch2 = Get value at time... ptomediointervalo 
						endif
						if pitch3 =undefined
							pitch3 = Get value at time... offset 
						endif
					endif
							
						
					pitch1$ = fixed$(pitch1,0)
					pitch2$ = fixed$(pitch2,0)
					pitch3$ = fixed$(pitch3,0)
					appendFile: arqout$, pitch1$, tab$, pitch2$, tab$, pitch3$, tab$
				else 
					appendFile: arqout$, "-", tab$, "-", tab$, "-", tab$
				endif
			else	
				appendFile: arqout$, "-", tab$, "-", tab$, "-", tab$
			endif

			#########################################

			#####################		F0	ST	##################################

			if f0_St = 1
				
				if st_reference = 1
					select Pitch 'base$'
					referencia = do ("Get mean...", 0, 0, "Hertz")
				endif	
				
				
				select TextGrid 'base$'
				label$ = Get label of interval: tier_interval, interval
					if label$ <> ""	
						onset = Get starting point: tier_interval, interval
						offset = Get end point: tier_interval, interval
						dur =offset-onset
						ptomediointervalo  = onset + (dur/2)
							
						select Pitch 'base$'
						pitch1 = Get value at time... onset Hertz Linear
						pitch2 = Get value at time... ptomediointervalo Hertz Linear
						pitch3 = Get value at time... offset Hertz Linear
							
						#si hay valores undefined hace un smooth y coge los valores smootheados
						if pitch1= undefined or pitch2= undefined or pitch3 = undefined
							select Pitch 'base$'
							do ("Down to PitchTier")
							if pitch1 = undefined
								pitch1 = Get value at time... onset 
							endif
							if pitch2=undefined
								pitch2 = Get value at time... ptomediointervalo 
							endif
							if pitch3 =undefined
								pitch3 = Get value at time... offset 
							endif
						endif
								

							
						#calculo de referencia por el centro de la sílaba precedente		
						if st_reference = 2
						previousInterval = interval-1
						
							if previousInterval >= 1
								select TextGrid 'base$'
								onset = Get starting point... 'tier_interval' 'previousInterval'
								offset = Get end point... 'tier_interval' 'previousInterval'	
								dur =offset-onset
								ptomediointervalo  = onset + (dur/2)
								select Pitch 'base$'
								referencia = Get value at time... ptomediointervalo Hertz Linear
								if referencia = undefined
									select Pitch 'base$'
									do ("Down to PitchTier")
									referencia = Get value at time... ptomediointervalo
								endif
							endif
							#si es la primera sílaba de la frase el valor de referencia es el onset de la sílaba
							if previousInterval < 1
								onsetinterval = Get starting point: tier_interval, interval
								referencia = Get value at time... onsetinterval Hertz Linear
								if referencia = undefined
									select Pitch 'base$'
									do ("Down to PitchTier")
									referencia = Get value at time... onsetinterval
								endif
							endif		
						endif

									

							
						#calculos para saber los ST
						pitch1St = (12 / log10 (2)) * log10 ('pitch1'/'referencia')
						pitch2St = (12 / log10 (2)) * log10 ('pitch2'/'referencia')
						pitch3St = (12 / log10 (2)) * log10 ('pitch3'/'referencia')
					
						pitch1St$ = fixed$ (pitch1St,2)
						pitch2St$ = fixed$ (pitch2St,2)
						pitch3St$ = fixed$ (pitch3St,2)
						
						
						appendFile: arqout$, pitch1St$, tab$, pitch2St$, tab$, pitch3St$, tab$
					else 
						appendFile: arqout$, "-", tab$, "-", tab$, "-", tab$
					endif
					
			else	

				appendFile: arqout$, "-", tab$, "-", tab$, "-", tab$
			endif
		
			#########################################
			
			
			#################	calcular la ultima bajada	########################
			if last_difference = 1
				
				select TextGrid 'base$'
				numberOfIntervals = Get number of intervals: tier_interval
				
		
				for i to numberOfIntervals
					label$ = Get label of interval: tier_interval, i
					primercaracter$ = left$ (label$, 1)
						if primercaracter$ = tonic$ 
							ultimatonica = i
						endif		
				endfor
				
				
				
				onset_tonica = Get starting point: tier_interval, ultimatonica
				last_boundary = Get end point: tier_interval, numberOfIntervals-1
				select Pitch 'base$'
				maxima_f0_ultimo_movimiento = Get time of maximum: onset_tonica, last_boundary, "Hertz", "None"		
				pitch_max_last_movement = Get value at time... maxima_f0_ultimo_movimiento Hertz Linear
				pitch_final = Get value at time... last_boundary Hertz Linear
				
					
				#si hay valores undefined hace un smooth y coge los valores smootheados
				if pitch_max_last_movement= undefined or pitch_final= undefined
					select Pitch 'base$'
					do ("Down to PitchTier")
					if pitch_max_last_movement = undefined
						pitch_max_last_movement = Get value at time... maxima_f0_ultimo_movimiento
					endif
					if pitch_final=undefined
						pitch_final = Get value at time... last_boundary
					endif
				endif
						

				#calculos para saber los ST
				diferencia_ultima_bajada = (12 / log10 (2)) * log10 ('maxima_f0_ultimo_movimiento'/'last_boundary')
				
				diferencia_ultima_bajada$ = fixed$ (diferencia_ultima_bajada,2)
				
				
				
				appendFile: arqout$, diferencia_ultima_bajada$, tab$
			else 
				appendFile: arqout$, "-", tab$
			endif
			
		
			#################
			#intro para después de cada intervalos
			appendFile: arqout$, newline$
		
		#fin bucle intervalos
		endfor
		
	#condición escribir un intervalo por linea
	endif
	
	
	select all
	minus Strings list
	Remove

	# salto linea para depsués de cada archivo
	if sort_data = 1
		appendFile: arqout$, newline$
	endif
#fin del bucle general
endfor

#limpieza final borra el Strings list
select all
Remove
echo You can open the txt file 
printline it has been saved in:
printline 'folder$'