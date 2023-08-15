Function ItIs($hour, $min){
	$now = Get-Date
	if ($now.Hour -eq $hour -and $now.Minute -eq $min) {
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
