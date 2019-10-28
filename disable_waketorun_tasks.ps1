# This script obtains all tasks whose "Wake To Run" property is enabled, and disables that property while keeping the rest of the task intact. This is done every 10 seconds, indefinitely.
while($true) {
	Get-ScheduledTask | ? {$_.Settings.WakeToRun -eq $true -and $_.State -ne "Disabled"} | % {$_.Settings.WakeToRun = $false; Set-ScheduledTask $_}
	Start-Sleep -s 10
}