# Author: Jorge Cisneros
#
# Purpose: Functions to use at work

# Main script creates pop up boxes for work reminders
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

# Start script function and handle weather hourly update
Function here {
    script
    Clear
    $count = 0
    $w = weather -n
    while ((Get-Date -Format "HH:mm") -ne "17:01") {
        if ($count * 60 -eq 3600) {
            $w = weather -n
            $count = 0
        }
        Write-Host -NoNewLine `r(Get-Date -DisplayHint Time) ~ "Weather:"$w
        $count++
        Start-Sleep -Seconds 1
    }
    out
    exit
}

# Stop job/script when leaving for the day
Function out {
    $job = Get-Job
    foreach ($jobNumber in $job) {
        Stop-Job -ID $jobNumber.Id
        Remove-Job -ID $jobNumber.Id
    }
}

# Print to screen all Active Directory computers on network
Function Get-Computers {
    get-adcomputer -Filter * | select-object Name | sort Name
}

# Print to screen uptime from selected machine
Function utime {
    $info = get-computerinfo
    new-timespan -start $info.OsLastBootUpTime -end $info.OsLocalDateTime
}

# Print to screen running servcies on selected machine
Function running {
    service | where {$_.Status -eq "Running"}
}

# Print to screen stopped services from selected machine
Function stopped {
    service | where {$_.Status -eq "Stopped"}
}
