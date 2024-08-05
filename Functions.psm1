# Start Powershell as Admin
Function su {start-process powershell -verb runas}

# Shut down machine
Function off {shutdown /s /t 0}

# Restart machine
Function restart {Restart-Computer}

# Get process sorted by highest CPU activity
Function cpu {ps | sort -Descending CPU | more}

# List all current diretory items
Function ll ($esto) {Get-ChildItem $esto -Force}

# Lust available personal functions
Function lf {Get-Command -Module Functions, Github, Internet, Outlook, Work}

# Set current directory to home
Function cc {Set-Location $home}

# Set current directory to profile folder
Function me {Set-Location "$home\Documents\WindowsPowerShell"}

# Set current directory to coding files location
Function work {Set-Location "$home\OneDrive\Work"}

# Lock machine
Function lock {clear; rundll32.exe user32.dll,LockWorkStation}

# Clear user recycle bin
Function bin {Clear-Recyclebin -Force}

# Start the task manager
Function task {Start-Process taskmgr}

# Create symbolic link
Function link {
    param(
        [string]$path,
        [string]$target
    )
    New-Item -ItemType SymbolicLink -Path $path -Target $target
}

# Print to screen all currently available COM objects
Function objects {
    Get-ChildItem HKLM:\Software\Classes -ErrorAction SilentlyContinue | Where-Object {
            $_.PSChildName -match '^\w+\.\w+$' -and (Test-Path -Path "$($_.PSPath)\CLSID")
    } | Select-Object -ExpandProperty PSChildName
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
            $apps = @($EMAIL, $ONENOTE)
            foreach ($app in $apps) {
                start $app; sleep 1
            }
        }
        Default {
            $apps = @($EMAIL, $ONENOTE, $TEXT)
            foreach ($app in $apps) {
                start $app; sleep 1
            }
            finance; sleep 1
            fav
        }
    }
}

# Start Minecraft server
Function mine {
    cd $HOME\Minecraft
    java -jar server.jar --nogui
}

# Shell timer
Function timer {
    param(
        [int]$time
    )
    Add-Type -AssemblyName PresentationFramework
    $min = $time * 60
    Clear
    while ($min -gt 0) {
        $var = [math]::Ceiling($min / 60)
        Write-Host -NoNewLine `r$var Minutes
        $min--
        sleep 1
    }
    [System.Windows.MessageBox]::Show("Timers Done!")
    Clear
}
