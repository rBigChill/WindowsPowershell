Function ItIs($hour, $min){
	$now = Get-Date
	if ($now.Hour -eq $hour -and $now.Minute -eq $min) {
		return $true
	}
	return $false
}

while ($true) {
<<<<<<< HEAD
	if (ItIs 12 56){
		Write-Host "Fuck Yes!"
=======
	if (ItIs 16 59){
		Write-Host "GO HOME!"
>>>>>>> c040663e309612a8278c5110442efdcd99c44c56
		Start-Sleep -Seconds 60 
	}
	else {
		Start-Sleep -Seconds 1
	}
}
