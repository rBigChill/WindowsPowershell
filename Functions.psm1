# Personal Shell Functions
Function off {shutdown /s /t 0}
Function restart {Restart-Computer}
Function cpu {ps | sort -Descending CPU | more}
Function l {clear; rundll32.exe user32.dll,LockWorkStation}
Function bin {Clear-Recyclebin -Force}
Function su {start-process powershell -verb runas}
Function ll ($esto) {Get-ChildItem $esto -Force}
Function lf {Get-Command -Module Functions, Github, Internet, outlook, Work}
Function cc {Set-Location $home}
Function me {Set-Location "$home\Documents\WindowsPowerShell"}
Function work {Set-Location "$home\OneDrive\Work"}
Function open ($esto) {Start-Process $esto}
Function c {clear}
Function link {
    param(
        [string]$path,
        [string]$target
    )
    New-Item -ItemType SymbolicLink -Path $path -Target $target
}

# Open files
Function finance {open $FINANCE}

# Open Apps
Function edge {open $EDGE}
Function chrome {open $CHROME}
Function outlook {open $OUTLOOK}
Function onenote {open $ONENOTE}
Function crd {open $CRD}
Function text {open $TEXT}

# Startup
Function leggo {
    $apps = @($OUTLOOK, $ONENOTE)
    foreach ($app in $apps) {
        open $app; sleep 1
    }
}

# Start Minecraft server
Function mine {
    cd $HOME\Minecraft
    java -jar server.jar --nogui
}

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

Function dash {
    Clear
    while ($true) {
        Write-Host -NoNewLine `r(Get-Date -DisplayHint Time)
        sleep 1
    }
}
