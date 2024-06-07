Function here {
    script
    #while ((Get-Date -Format "HH") -ne "17") {
    while ($true) {
        Clear
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
                (ItIs 11 55) {[System.Windows.MessageBox]::Show("WORKING OUT?"); Start-Sleep -Seconds 60}
                (ItIs 12 00) {[System.Windows.MessageBox]::Show("LUNCH"); Start-Sleep -Seconds 60}
                (ItIs 16 55) {[System.Windows.MessageBox]::Show("GET READY TO LEAVE"); Start-Sleep -Seconds 60}
                (ItIs 17 00) {[System.Windows.MessageBox]::Show("GO HOME"); Start-Sleep -Seconds 60}
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
