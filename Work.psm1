Function here {
    script
    Clear
    while ((Get-Date -Format "HH:mm") -ne "17:01") {
        Write-Host -NoNewLine `r(Get-Date -DisplayHint Time)
        Start-Sleep -Seconds 1
    }
    out
    exit
}

Function script {
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
                (ItIs 11 58) {[System.Windows.MessageBox]::Show("Working Out?"); Start-Sleep -Seconds 60}
                (ItIs 12 00) {[System.Windows.MessageBox]::Show("Lunch"); Start-Sleep -Seconds 60}
                (ItIs 16 58) {[System.Windows.MessageBox]::Show("Get Ready to Leave"); Start-Sleep -Seconds 60}
                (ItIs 17 00) {[System.Windows.MessageBox]::Show("Go Home"); Start-Sleep -Seconds 60}
                (ItIs 21 00) {[System.Windows.MessageBox]::Show("Stop Working"); Start-Sleep -Seconds 60}
            }
            Start-Sleep -Seconds 1
        }
    }
}

Function out {
    $job = Get-Job
    foreach ($jobNumber in $job) {
        Stop-Job -ID $jobNumber.Id
        Remove-Job -ID $jobNumber.Id
    }
}

Function Get-Computers {
    get-adcomputer -Filter * | select-object Name | sort Name
}
