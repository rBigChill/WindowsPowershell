# Personal Shell Functions
Function su {start-process powershell -verb runas}
Function off {shutdown /s /t 0}
Function restart {Restart-Computer}
Function cpu {ps | sort -Descending CPU | more}
Function ll ($esto) {Get-ChildItem $esto -Force}
Function lf {Get-Command -Module Functions, Github, Internet, Outlook, Work}
Function cc {Set-Location $home}
Function me {Set-Location "$home\Documents\WindowsPowerShell"}
Function work {Set-Location "$home\OneDrive\Work"}
Function lock {clear; rundll32.exe user32.dll,LockWorkStation}
Function bin {Clear-Recyclebin -Force}
Function task {Start-Process taskmgr}
Function link {
    param(
        [string]$path,
        [string]$target
    )
    New-Item -ItemType SymbolicLink -Path $path -Target $target
}

# start files
Function finance {start $FINANCE}

# start Apps
Function edge {start $EDGE}
Function chrome {start $CHROME}
Function outlook {start $EMAIL}
Function onenote {start $ONENOTE}
Function crd {start $CRD}
Function text {start $TEXT}

# Startup
Function leggo {
    $apps = @($EMAIL, $ONENOTE)
    foreach ($app in $apps) {
        start $app; sleep 1
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
