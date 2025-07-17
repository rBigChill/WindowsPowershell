# Set Window Title
[System.Console]::Title = "Welcome to the Jungle!"

# Set shell prompt
Function prompt {"`n$(gl)`n`n:)~ "}

# Import personal modules
Import-Module $home\Documents\WindowsPowerShell\Dash
Import-Module $home\Documents\WindowsPowerShell\Github
Import-Module $home\Documents\WindowsPowerShell\Internet
Import-Module $home\Documents\WindowsPowerShell\Outlook
Import-Module $home\Documents\WindowsPowerShell\Variables
Import-Module $home\Documents\WindowsPowerShell\Work

# Startup favorite applications to work with
Function leggo {
    param(
        [switch]$a
    )
    switch ($true) {
        $a {
            $apps = @($ONENOTE, $EMAIL, $TEXT, $FINANCE)
            foreach ($app in $apps) {
                start $app; sleep 1
            }
        }
        Default {
            $apps = @($ONENOTE, $EMAIL, $TEXT, $FINANCE)
            foreach ($app in $apps) {
                Write-host "Opening $app..."
                start $app
                Read-host "Press Enter..."
            }
        }
    }
}

# Update applications 
Function update {
    wsl --update
    winget upgrade --silent --all --include-unknown --accept-package-agreements --accept-source-agreements --force --disable-interactivity
}

# Find COM Objects
Function Get-ComObject {
    Get-ChildItem HKLM:\Software\Classes -ErrorAction SilentlyContinue | Where-Object {
            $_.PSChildName -match '^\w+\.\w+$' -and (Test-Path -Path "$($_.PSPath)\CLSID")
    } | Select-Object -ExpandProperty PSChildName
}

# Find all assemblies
Function Get-Assemblies {
    [AppDomain]::CurrentDomain.GetAssemblies().getname() | select name | sort name
}

# Find all modules
Function Get-Mods {
    Get-Module -ListAvailable -All | Select-Object Name | Sort-Object Name
}

# Find CimClasses
Function Get-Cims {
    Get-CimClass | select CimClassName | Sort CimClassName
}

# Get all personal scheduled task
Function task {
    Get-ScheduledTask | get-scheduledtaskinfo | where {$_.TaskPath -eq "\Personal\"}
}

# Run Missed Run Task
Function runem {
    foreach ($task in (task).taskname) {
        start-scheduledtask -taskname \Personal\$task
        sleep 15
    }
}

# Close outlook
Function close {ps Outlook | select id | kill}

# Close all open windows
Function closeall {ps | where MainWindowTitle -ne "" | select id | kill}

# List personal module functions
Function lf {Get-Command -Module Functions, Github, Internet, Outlook}

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

# Start Google Messenger appication
Function text {start $TEXT}

# Autolpull the most recent files from github for profile when shell starts
cd $home\Documents\WindowsPowerShell\
pull
cc
