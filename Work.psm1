Function count {
    while ((Get-Date -Format "HH") -ne "17") {
        Clear
        Get-Date -DisplayHint Time
        Start-Sleep -Seconds 1
    }
}

Function here {
    Start-Job -ScriptBlock {

        Add-Type -AssemblyName PresentationFramework

        Function ItIs($hour, $min) {
            $now = Get-Date
            if ($now.Hour -eq $hour -and $now.Minute -eq $min) {
                return $true
            }
            return $false
        }

        while ($true) {
            Switch ($true) {
                (ItIs 11 55) {[System.Windows.MessageBox]::Show("LUNCH"); Start-Sleep -Seconds 60}
                (ItIs 16 55) {[System.Windows.MessageBox]::Show("GO HOME"); Start-Sleep -Seconds 60}
            }
            Start-Sleep -Seconds 1
        }
    }
}
