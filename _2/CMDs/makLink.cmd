@echo off

:if     "%1" == ""     makLink hello
:if     "%1" == ""     makLink C:                           # No Workie
:if     "%1" == ""     makLink C:\                          # No Workie
:if     "%1" == ""     makLink C:\WEBs
:if     "%1" == ""     makLink C:\WEBs\SCN2\                # No Workie
:if     "%1" == ""     makLink C:\Shared\Users\R.M\_\LNKs
:if     "%1" == ""     makLink C:\Shared\Users\R.M\_\LNKs\Current\rdir.@tmp1
:if     "%1" == ""     makLink rdir  C:\Shared\Users\R.M\_\LNKs\Current\rdir.@tmp1
:if     "%1" == ""     makLink rdir  C:\Shared\Users\R.M\_\LNKs\Current\rdir.@tmp
:if     "%1" == ""     makLink Links C:\Shared\Users\R.M\_\LNKs

:if     "%1" == ""     makLink C:\Home\_0\bin\makProjDirs_  C:\Home\_\CFGs\MT-ProjWSs\makProjDirs.sh

:----------------------------------------------------------------------

                       set aCmd=
 if     "%1" == ""     set aCmd=help
 if     "%1" == """"   set aCmd=help
 if     "%1" == "help" set aCmd=help
 if "%aCmd%" == "help" goto HELP
                       goto BEG

:----------------------------------------------------------------------
:HELP

 echo.
 echo   Syntax: makLink  [{aName}] {aPath}  -- Creates a Symbolic link named: {aName}
 echo                                                    to a file or folder: {aPath}
:mklink /?
:echo.
 echo       The command being called is:
 echo           mklink    {aName}  {aFile}  -- Symbolic link to a file
 echo           mklink /H {aName}  {aPath}  -- Hard link to a file
 echo           mklink /D {aName}  {aPath}  -- Symbolic link to a folder
 echo           mklink /J {aName}  {aFile}  -- Hard link to a folder
 goto END

:----------------------------------------------------------------------
:BEG
                   set aName=%~1
                   set aPath=%~2
     if "%2" == "" set aName=%~nx1%
     if "%2" == "" set aPath=%~1

     if "%aPath:~0,3%" == "/C/" set aPath=C:\%aPath:~3%
     if "%aName:~0,3%" == "/C/" set aName=C:\%aName:~3%
     if "%aPath:~0,3%" == "/c/" set aPath=C:\%aPath:~3%
     if "%aName:~0,3%" == "/c/" set aName=C:\%aName:~3%
     if "%aPath:~0,3%" == "/D/" set aPath=D:\%aPath:~3%
     if "%aName:~0,3%" == "/D/" set aName=D:\%aName:~3%
     if "%aPath:~0,3%" == "/d/" set aPath=D:\%aPath:~3%
     if "%aName:~0,3%" == "/d/" set aName=D:\%aName:~3%

:    call set str=%%str:%original%=%replacement%%%
:    call set str=%%str:goo=foo%%
     call set aPath=%%aPath:/=\%%
     call set aName=%%aName:/=\%%

 if "sho" == "not" (
     echo.
     echo       {bFile}: %bFile%   1] It's a File, 0] It's a Dir
     echo From: {aPath}: %aPath%
     echo   To: {aName}: %aName%
     goto END
     )

:----------------------------------------------------------------------

:     set RunAsAdmin=%~dp0%..\exes\nirCmdc.exe elevatecmd execmd
      set RunAsAdmin=%~dp0%..\bin\nirCmdc.exe elevatecmd execmd

      set bFile=1&pushd "%aPath%" 2>nul&&(popd&set bFile=0)||(if not exist "%aPath%" set bFile=0)

     if "%bFile%" == "0" if     "%2" == "" set aName=%~n1
     if "%bFile%" == "0" if not "%2" == "" set aName=%~1

     if "%bFile%" == "0" set aOpt=/D
     if "%bFile%" == "1" set aOpt=

:    if "%bFile%" == "0" set aOpt=/H
:    if "%bFile%" == "1" set aOpt=/J

                            echo.
     if not exist "%aPath%" echo ** %aPath% does NOT exist
     if     exist "%aName%" echo ** Cannot create %aName%, it already exists
     if     exist "%aName%" goto END

     if     exist "%aPath%" echo    mkLink %aOpt%  "%aName%"  "%aPath%"
:    if     exist "%aPath%"         mkLink %aOpt%  "%aName%"  "%aPath%" | awk '{ print ""; print " " $0 }'
     if     exist "%aPath%" %RunAsAdmin%  mkLink %aOpt%  "%aName%"  "%aPath%" | awk '{ print ""; print " " $0 }'

:----------------------------------------------------------------------
:END
:----------------------------------------------------------------------
     echo.

:set "filename=C:\Folder1\Folder2\File.ext"
:For %%A in ("%filename%") do (
:    echo full path:        %%~fA
:    echo directory:        %%~dA
:    echo path:             %%~pA
:    echo file name only:   %%~nA
:    echo extension only:   %%~xA
:    echo attributes:       %%~aA
:    echo date and time:    %%~tA
:    echo size:             %%~zA
:    echo drive + path:     %%~dpA
:    echo name.ext:         %%~nxA
:    echo full path + short name: %%~fsA)