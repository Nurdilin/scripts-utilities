cd\
@echo off
color a

REM -Write the USB Drive Letter
set /p drive=SET USB DRIVE LETTER:
%drive%: 
pause

dir /w/a
attrib -r -a -s -h /s /d *.*

if exist autorun.inf (
	del autorun.inf
	echo ...
	echo ...
	echo autorun.inf was deleted..
) else (
	echo ...
	echo ...
	echo The file autorun.inf was not found!
	)

echo ...
echo ...
echo The proccess has been completed.
echo Press any key to exit.. 
	
pause >null
exit
