 
#  $aDir = (Get-Item -Path ".").Path
   $aDir  = $MyInvocation.MyCommand.Path
   $aDir  = ${aDir}.replace( [regex] 'setFRT.ps1', '')
   $aDoit = "dont"; if ($args[0] -gt "") { $aDoit = $args[0] };

#  Write-Host "aRun: ${aDir}..\PS1s\setFRT_u4.ps1 ""${aDoit}"""  

   cmd.exe "/C ${aDir}\..\PS1s\setFRT_u4.ps1  ""${aDoit}"""   

