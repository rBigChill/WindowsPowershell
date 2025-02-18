# Clear console and start a clock with weather info
Function time {
    clear
    [System.Console]::CursorVisible = $false
    $weather = weather -n
    $hour = (Get-Date).Hour
    while($true) {
        $now = (Get-Date).Hour
        if ($now -gt $hour) {
            $weather = weather -n
            $hour = (Get-Date).Hour
            clear
        }
        [System.Console]::SetCursorPosition(0, 0)
        Write-Host "$(date) $weather" -NoNewLine
        Sleep 1
    }
}

# Get all personal scheduled task
Function task {
    Get-ScheduledTask | get-scheduledtaskinfo | where {$_.TaskPath -eq "\Personal\"}
}

# Close all open windows
Function close {ps | where MainWindowTitle -ne "" | select id | kill}

# List personal module functions
Function lf {Get-Command -Module Functions, Github, Internet, Outlook, Work}

# Start Powershell as Admin
Function su {start-process powershell -verb runas}

# Shut down machine
Function off {shutdown /s /t 0}

# Restart machine
Function restart {Restart-Computer}

# Get process sorted by highest CPU activity
Function cpu {ps | sort -Descending CPU | more}

# Lock machine
Function lock {clear; rundll32.exe user32.dll,LockWorkStation}

# Clear user recycle bin
Function bin {Clear-Recyclebin -Force}

# List all current diretory items
Function ll ($directory) {Get-ChildItem $directory -Force}

# Set current directory to home
Function cc {Set-Location $home}

# Set current directory to profile folder
Function me {Set-Location "$home\Documents\WindowsPowerShell"}

# Set current directory to coding files location
Function work {Set-Location "$home\OneDrive\Work"}

# Create symbolic link
Function link {
    param(
        [string]$path,
        [string]$target
    )
    New-Item -ItemType SymbolicLink -Path $path -Target $target
}

# Open Finance excel file 
Function finance {start $FINANCE}

# Start Edge web browser 
Function edge {start $EDGE}

# Start Chrome web browser
Function chrome {start $CHROME}

# Start Outlook application
Function outlook {start $EMAIL}

# Start Onenote application
Function onenote {start $ONENOTE}

# Start Chrome Remote Desktop application
Function crd {start $CRD}

# Start Google Messenger appication
Function text {start $TEXT}

# Startup
Function leggo {
    param(
        [switch]$w
    )
    switch ($true) {
        $w {
            $apps = @($ONENOTE, $EMAIL)
            foreach ($app in $apps) {
                start $app; sleep 1
            }
        }
        Default {
            $apps = @($ONENOTE, $EMAIL, $TEXT)
            foreach ($app in $apps) {
                start $app; sleep 1
            }
        }
    }
}
