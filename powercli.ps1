﻿# https://github.com/dforge/VMware.git
#

####################################################
clear

####################################################
$vModule     = "C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Modules\"
$vCenter     = ""
$vDC         = ""
$currentDate = get-date -uformat '%d.%m.%y %T'
$vLogs       = "C:\Docs\logs\$vCenter.$date.log"
$vWorkPath   = "C:\Docs\data"

####################################################
$moduleList = @(
    "VMware.VimAutomation.Core",
    "VMware.VimAutomation.Vds",
    "VMware.VimAutomation.Cloud",
    "VMware.VimAutomation.PCloud",
    "VMware.VimAutomation.Cis.Core",
    "VMware.VimAutomation.Storage",
    "VMware.VimAutomation.HorizonView",
    "VMware.VimAutomation.HA",
    "VMware.VimAutomation.vROps",
    "VMware.VumAutomation",
    "VMware.DeployAutomation",
    "VMware.ImageBuilder",
    "VMware.VimAutomation.License"
    )

####################################################
function LoadModules() {
   
   $loaded     = Get-Module -Name $moduleList -ErrorAction Ignore | % {$_.Name}
   $registered = Get-Module -Name $moduleList -ListAvailable -ErrorAction Ignore | % {$_.Name}
   $notLoaded  = $registered | ? {$loaded -notcontains $_}
   
   
   foreach ($module in $registered) {
      if ($loaded -notcontains $module) {
		 Import-Module $module
      }
   }
}

####################################################
cd $vModule
LoadModules
Connect-VIServer -Server $vCenter | Out-Null
cd $vWorkPath

#///////////////////////////////////////////////////





#///////////////////////////////////////////////////

####################################################
disconnect-viserver -confirm:$false -Server $vCenter