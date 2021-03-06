form Read all files of the given type from the given directory
   sentence Source_directory /Users/takter/Desktop/emotion_files/input/Actor_12
   sentence Destination_directory /Users/takter/Desktop/emotion_files/fast_speech/Actor_12
   sentence File_name_or_initial_substring 
   sentence File_extension .wav
endform

## Below: collect all the files that match the search criteria and save them

Create Strings as file list... list 'source_directory$'/'file_name_or_initial_substring$'*'file_extension$'
head_words = selected("Strings")
file_count = Get number of strings

## Below: loop through the list of files, extracting each name and reading it into the Objects list

for current_file from 1 to file_count
   	select Strings list
   	filename$ = Get string... current_file
	print 'filename$'
   	##To Manipulation... 0.01, 75, 600
   
	##Read from file... 'source_directory$'/'filename$'
   	sound = Read from file... 'source_directory$'/'filename$'
	endtime = Get end time
	endtimems = endtime*1000
	print 'endtimems'
	To Manipulation... 0.01 75 600
	Rename... aa1
	selectObject: sound
	Create DurationTier: "aa1", 0, endtime
	Add point: 0.000, 875/endtimems
	selectObject: "Manipulation aa1" 
	plusObject: "DurationTier aa1"
	Replace duration tier
	minusObject: "DurationTier aa1"
	Get resynthesis (overlap-add)
	removeObject: sound
	removeObject: "Manipulation aa1"
	removeObject: "DurationTier aa1"
	Save as WAV file... 'destination_directory$'/'filename$'
   	
	print "Sound Saved"

endfor
