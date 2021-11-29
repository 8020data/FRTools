@echo off
 
  set aFormRdir=%1
  set aRepoDir=%2

  cd  %aFormRdir%
  echo.
  echo    _2\CMDs\makLink.cmd _2 %aRepoDir%  
: echo    "%aRepoDir%\_2\CMDs\makLink.cmd"  _2  %aRepoDir%  
: call    "%aRepoDir%\_2\CMDs\makLink.cmd"  _2  %aRepoDir%\_2  
:                      "%~dp0\makLink.cmd"  _2  %aRepoDir%\_2  
 
: set RunAsAdmin=%~dp0%..\bin\nirCmdc.exe elevatecmd execmd
:    %RunAsAdmin%  mkLink /D  _2  %aRepoDir%\_2

:  echo    Filename     Date     Time     Size
:  echo   --------- ------------------- -----
:  dir    _2\bin | awk 'NF == 6 { printf "   %-9s %10s ^%8s ^%4d\n", $6, $2, $3" "$4, $5 }'
:  dir    _2\bin | awk '$3 ~ /[AP]M/ { printf "%-20s %7d  %18s\n", $5, $4, $1"  "$2" "$3 }'    

   echo. 
   echo    Run Cmd:  FRT (may require restarting this console)
   echo. 
           frt 
   echo.         

