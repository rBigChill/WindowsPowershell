# Personal Shell Functions
Function off {shutdown /s /t 0}
Function restart {Restart-Computer}
Function clear-bin {Clear-Recyclebin -Force}
Function su {start-process powershell -verb runas}
Function ll($esto) {Get-ChildItem $esto -Force | more}
Function lf {Get-Command -Module Functions, Github, Internet, outlook}
Function cc {Set-Location $home}
Function me {Set-Location "$home\Documents\WindowsPowerShell"}
Function work {Set-Location "$home\OneDrive\Work"}
Function open($esto) {Start-Process $esto}
Function wait([int]$time) {Start-Sleep -Seconds $time}
Function www([string]$esto) {open "www.$esto"}
Function objects {
    $file = Get-ChildItem HKLM:\Software\Classes -ErrorAction SilentlyContinue
    $file | Where-Object {
        $_.PSChildName -match '^\w+\.\w+$' -and (Test-Path -Path "$($_.PSPath)\CLSID")
        } | Select-Object -ExpandProperty PSChildName
}
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

# Startup
Function leggo {
    $apps = @($OUTLOOK, $ONENOTE)
    foreach ($app in $apps) {
        open $app; wait 1
    }
}

# Start Minecraft server
Function mine {
    cd $HOME\Minecraft
    java -jar server.jar --nogui
}
