@echo off

: echo    "/C .\_2\bin\setFRT.ps1  ""%1""" 
  cmd.exe "/C .\_2\bin\setFRT.ps1  ""%1"""    

 echo    Need to run it with the "doit" option in PowerShell:
 echo. 
 echo       _2\PS1s\setFRT_u4.ps1  doit
 echo.
 echo    And if that doesn't work, try something like this:
 echo.
 echo       bash  2/CMDs/setFRT_link.sh  "C:/WEBs/8020/VMs/et218t/webs/nodeapps/FormR" "../FRTools/dev01-suzee"
 echo.
