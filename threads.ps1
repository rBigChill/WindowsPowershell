Function ItIs($hour, $min){
	$now = Get-Date
	if ($now.Hour -eq $hour -and $now.Minute -eq $min) {
		return $true
	}
	return $false
}

while ($true) {
	if (ItIs 16 59){
		Write-Host "GO HOME!"
		Start-Sleep -Seconds 60 
	}
	else {
		Start-Sleep -Seconds 1
	}
}
