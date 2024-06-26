# Threads

Add-Type -AssemblyName PresentationFramework

Function ItIs($hour, $min){
	$now = Get-Date
	if ($now.Hour -eq $hour -and $now.Minute -eq $min) {
		return $true
	}
	return $false
}

while ($true) {
    Switch ($true) {
        (ItIs 21 00) {[System.Windows.MessageBox]::Show("Stop Working"); Start-Sleep -Seconds 60}
    }
    Start-Sleep -Seconds 1
}
