$oldSC = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "ScreenConnect Client (fb98db3d174b2c73)"}
$oldSC.Uninstall()