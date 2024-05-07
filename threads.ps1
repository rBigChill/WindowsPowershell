Function ItIs($hour, $min){
	$now = Get-Date
	if ($now.Hour -eq $hour -and $now.Minute -eq $min) {
		return $true
	}
	return $false
}

while ($true) {
	if (ItIs 11 25){
        Write-Host "Working..."
		Start-Sleep -Seconds 60 
	}
	else {
		Start-Sleep -Seconds 1
	}
}

