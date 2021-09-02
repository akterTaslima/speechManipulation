form Insert silence
positive start_of_silence 0.0001
positive duration_of_silence 1.00
#change the following line if the directory changes
sentence Directory /Users/takter/Desktop/emotion_files/Actor_01
endform

Create Strings as file list... list 'directory$'/*.wav
numberOfFiles = Get number of strings
for ifile to numberOfFiles
   Create Strings as file list... list 'directory$'/*.wav
   select Strings list
   fileName$ = Get string... ifile 
   print 'fileName$'
   Read from file... 'directory$'/'fileName$'
   mySound = selected("Sound")
   sampling_frequency = Get sampling frequency
   duration = Get total duration
   myStart = Extract part... 0 start_of_silence rectangular 1 no
   mySilence = Create Sound from formula... silence 1 0 duration_of_silence sampling_frequency 0
   select mySound
   myEnd = Extract part... start_of_silence duration rectangular 1 no
   select myStart
   plus mySilence
   plus myEnd
   myNewSound = Concatenate
   select myStart
   plus mySilence
   plus myEnd
   Remove
   select myNewSound
   # change the following line if the directory changes
   Save as WAV file... /Users/takter/Desktop/emotion_files/'fileName$'
   select all
   Remove
endfor
