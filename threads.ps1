Function ItIs($hour, $min){
	$now = Get-Date
	if ($now.Hour -eq $hour -and $now.Minute -eq $min -and $now.DayOfWeek -ne "Saturday" -and $now.DayOfWeek -ne "Sunday") {
		[system.media.systemsounds]::Beep.play()
		return $true
	}
	return $false
}

while ($true) {
	if (ItIs 8 55){
		Write-Host Fuck Yes!!
		Start-Sleep 60
	}
	else {
		Start-Sleep -Seconds 1
	}
}