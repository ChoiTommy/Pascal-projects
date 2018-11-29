@echo off
"d:\programme files\fps\fpk106\bin\win32\ldw.exe"     -o "e:\noughts and crosses\NoughtAndCrosses.exe" "link.res" exp.$$$
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
