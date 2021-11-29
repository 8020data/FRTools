

#                .\setFRT_u4.ps1
#     powershell .\setFRT_u4.ps1 doit 

#   -----------------------------------------------------------------------------------------------------------

      $aFormRdir =  "C:\WEBs\8020\VMs\et218t\webs\nodeapps\FormR"
      $aRepoDir  =  "..\FRTools\dev01-suzee"

#     ----------------------------------------------------------------

function getFormRdir() {
Begin { 
      $aFormRdir = "" 
      cd "${aRepoDir}"
      }
Process {

     For ($i = 0; $i -lt 4; $i++) {
          $aDir = "$( ( Get-Item -Path "." ).Fullname )\FormR"
#         Write-Host "aDir: ${aDir}" 
      if (Test-Path "${aDir}") { 
          $aFormRdir = "${aDir}" 
          } 
          cd ".." 
        }
      } # eob Process
End { 
      cd "${aRepoDir}"
      return ${aFormRdir} 
      }
    } # eof getFormRdir 
#     ----------------------------------------------------------------

function getRepoDir() {
Process {
         $nPos = ${aFormRdir}.indexof("FormR") - 1   
     if (${aFormRdir}.substring( 0, ${nPos} ) -eq ${aRepoDir}.substring( 0, ${nPos} )) { 
         $aDir = ${aRepoDir}.substring( ${nPos} + 1)
     } else { 
         $aDir = ""
         } 
      } # eob Process
End { 
      return "..\${aDir}" 
      }
    } # eof getRepoDir
#     ----------------------------------------------------------------

 if ((Get-Item -Path "." ).Fullname -match [regex] 'PS1s$' ) { cd .. }
 if ((Get-Item -Path "." ).Fullname -match [regex] '_2$'   ) { cd .. }
      
#     cd            "C:\WEBs\8020\VMs\et218t\webs\nodeapps\FRTools\dev01-suzee"
      $aRepoDir  =  (Get-Item -Path ".").Fullname; $aRepoDirFull = ${aRepoDir}
      $aFormRdir =   getFormRdir
      $aRepoDir  =   getRepoDir

#     Start-Transcript -Path "${aRepoDirFull}\setFRT.log"

#   -----------------------------------------------------------------------------------------------------------

 if ((Test-Path     "${aFormRdir}") -eq $false) { 
      Write-Host "** Error:     FormR dir, ${aFormRdir}, does not exist"
      exit
      }

 if ((Test-Path     "_2") -eq $false) { 
      Write-Host "** Error:     Repo dir, ${aRepoDir}\_2, does not exist"
      exit
      }
#     ----------------------------------------------------------------

      cd            "$aFormRdir"

      $aDoit     =  "dont"; if ($args[0] -gt "") { $aDoit = $args[0] };
      $aNotReally=  ""; if ("$aDoit"  -ne  "doit") { $aNotReally = " ( not really )" }

      Write-Host ""
      Write-Host "   Doit:     $aDoit"
      Write-Host "   Running:  setFRT_u4.ps1"

#   -----------------------------------------------------------------------------------------------------------
#    Link FormR/_2  to ${aRepoDir}/_2 
#   -----------------------------------------------------------------------------------------------------------

  if (Test-Path     "${aFormRdir}\_2") { 

      Write-Host " * Warning:  ${aFormRdir}\_2 is already linked"
 if ("$aDoit"  -eq  "doit") {   
#     Get-ChildItem       "${aFormRdir}\_2" -Attributes ReparsePoint | % { $_.Delete() }
#     Remove-Item   -Path "${aFormRdir}\_2" -Recurse -Force
      cmd.exe       "/C rmdir /s /q ""${aFormRdir}\_2"""
      } 
      Write-Host "   Deleting: ${aFormRdir}\_2 ${aNotReally}"
    } # eif $bLinked    
 
 if ("$aDoit"  -eq  "doit") {   
#     Start-Process -Verb runas  cmd.exe -ArgumentList @("/c mklink", "_2", "${aRepoDir}\_2")
      Start-Process -Verb runas  cmd.exe "/C mklink _2 ${aRepoDir}\_2"  
      }

      Write-Host "   Linking: .\FormR\_2  to  ${aRepoDir}\_2 ${aNotReally}"
    
#   -----------------------------------------------------------------------------------------------------------
#    Pur FormR/_2/bin  into PATH 
#   -----------------------------------------------------------------------------------------------------------

      $aNewPath  =  "${aFormRdir}\_2\bin"
      $aOldPath  =   [Environment]::GetEnvironmentVariable( 'PATH', 'Machine' ); $aOldPath = $aOldPath.trim() 

#     Write-Host "   PATH:   $aNewPath  ;  $aOldPath";
#     Write-Host "   contains: " $aOldPath.Contains($aNewPath)
  if ($aOldPath.Contains($aNewPath)) { 
      Write-Host " * Warning:  ${aFormRdir}\_2\bin is already in the PATH"
  } else {

 if ("$aDoit"  -eq  "doit") {   
      $aCmd      =  "[Environment]::SetEnvironmentVariable( 'PATH', '$aOldPath;$aNewPath', 'Machine' )";

#     Start-Sleep   -Seconds 1
#     $oldPath  +=   @";$newPath"
#     Start-Process -verb runas [Environment]::SetEnvironmentVariable( 'PATH', "$newPath;$oldPath", 'Machine' );
#                   [Environment]::SetEnvironmentVariable( 'PATH', "$newPath;$oldPath", 'Machine' );
#                    System.Environment.SetEnvironmentVariable( 'PATH',"$newPath;$oldPath", 'Machine' );
#     Start-Process  System.Environment.SetEnvironmentVariable -ArgumentList @( 'PATH', "$newPath;$oldPath", 'Machine' );

      Start-Process -FilePath "powershell" -Verb RunAs -wait -ArgumentList "$aCmd"; 
      } 
      
      Write-Host "   Adding:   ${aFormRdir}\_2\bin  to  PATH ${aNotReally}"

    } # eif not $aOldPath.Contains($aNewPath))  
#   -----------------------------------------------------------------------------------------------
    
 if ("$aDoit"  -eq  "doit") {   

  if (Test-Path     "${aFormRdir}\_2") { 

      Write-Host ""
      Write-Host "   Filename     Date     Time     Size"
      Write-Host "   --------- ------------------- ----"
                     dir "${aFormRdir}/_2/bin/*" | awk 'NF == 6 { printf ""   %-9s %10s %8s %4d\n"", $6, $2, $3"" ""$4, $5 }'

      Write-Host ""
      Write-Host "   Run Cmd:  FRT (requires console restart)"
      
#     Start-Process -FilePath "${aFormRdir}\${aRepoDir}\_2\bin\frt.cmd" -RedirectStandardOutput $true
#     Start-Process -FilePath "${aFormRdir}\${aRepoDir}\_2\bin\frt.cmd"  -verb Print # print to printer  
#     Write-Host "   cmd.exe ""/C ${aFormRdir}\_2\bin\frt.cmd""" 
                     cmd.exe  "/C ${aFormRdir}\${aRepoDir}\_2\bin\frt.cmd"

    } else {
      Write-Host "** Error:    The folder, ..\..\FormR\_2, was not linked"
      Write-Host "   Fails:    cmd.exe ""/C ${aFormRdir}\_2\bin\frt.cmd""" 
      Write-Host "" 
      Write-Host "   Try:      cd ..\..\FormR"
#     Write-Host "             cmd.exe ""/C  mklink  _2  ${aRepoDir}\_2"""
      Write-Host "             Start-Process -Verb runas  cmd.exe ""/C mklink _2 ${aRepoDir}\_2"""  
      Write-Host "             cd ${aRepoDir}"
      Write-Host "" 
      Write-Host "   Or:       _2\CMDs\setFRT_link.cmd  ""${aFormRdir}"" ""${aRepoDir}"""
      Write-Host "   Or:  bash _2/CMDs/setFRT_link.sh   ""${aFormRdir}"" ""${aRepoDir}"""  

      } # eif mklink failed 
    } # eif Do Display Results
    
#   -----------------------------------------------------------------------------------------------------------

      Write-Host ""
#     Stop-Transcript 

      cd  "${aFormRdir}\${aRepoDir}"
