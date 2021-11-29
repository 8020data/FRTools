#!/bin/sh
 
  aFormRdir=$1
  aRepoDir=$2

  cd  ${aFormRdir}

  echo ""
  echo "   _2\CMDs\makLink.cmd _2 ${aRepoDir}"  
# echo "   \"${aRepoDir}/_2/CMDs/makLink.cmd\"  _2  ${aRepoDir}"  
            "${aRepoDir}/_2/CMDs/makLink.cmd"   _2  ${aRepoDir}/_2  
#                        "${~dp0/makLink.cmd\"  _2  ${aRepoDir}/_2"  
# echo ""  
# RunAsAdmin=%~dp0%..\bin\nirCmdc.exe elevatecmd execmd
#    ${RunAsAdmin}  mkLink /D  _2  ${aRepoDir}\_2

  if [ -f _2/bin/frt ]; then 

  echo "   Filename             Size   Date    Time"
  echo "   -------------------  -----  ------------"
# ls -l  _2/bin | awk 'NF == 6 { printf "   %-9s %10s ^%8s ^%4d\n", $6, $2, $3" "$4, $5 }'
# ls -l  _2/bin | awk '$3 ~ /[AP]M/ { printf "%-20s %7d  %18s\n", $5, $4, $1"  "$2" "$3 }'    
  ls -l  _2/bin | awk 'NR > 1 { printf "   %-18s %7d  %12s\n", $9, $5, $6" "$7" "$8 }' 

  echo "" 
  echo "   Run Cmd:  FRT (may require restarting this console)"
  echo "" 
           frt 

  else 
  echo "" 
  echo "** The folder, FormR/_2, has not been linked"
    fi          
  echo ""         

