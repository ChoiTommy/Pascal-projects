@echo off
"c:\program files (x86)\fps\fpk106\bin\win32\ldw.exe"     -o "e:\recursion\Recursion.exe" "link.res" exp.$$$
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
