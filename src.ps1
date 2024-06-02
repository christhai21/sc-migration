#!ps
#Timeout=10000

$Name = "Chris"
$Site = "NCS"
$DeviceType = "Workstation"

$FileUri = "https://ncs.screenconnect.com/Bin/ScreenConnect.ClientSetup.exe?e=Access&y=Guest&t=$Name&c=$Site&c=$Site&c=sales&c=$DeviceType&c=&c=&c=&c="
$Destination = "C:\ConnectWiseControl.ClientSetup.exe"

$bitsJobObj = Start-BitsTransfer $FileUri -Destination $Destination

switch ($bitsJobObj.JobState) {

    'Transferred' {
        Complete-BitsTransfer -BitsJob $bitsJobObj
        break
    }

    'Error' {
        throw 'Error downloading'
    }
}

$exeArgs = '/verysilent /tasks=addcontextmenufiles,addcontextmenufolders,addtopath'

Start-Process -Wait $Destination
# -ArgumentList $exeArgs

Remove-Item "C:\ConnectWiseControl.ClientSetup.exe"

$oldSC = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "ScreenConnect Client (fb98db3d174b2c73)"}
$oldSC.Uninstall()
