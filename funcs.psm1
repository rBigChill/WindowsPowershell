# Personal Functions
Function off {shutdown /s /t 0}
Function restart {Restart-Computer}
Function su {start-process powershell -verb runas}
Function ll($esto) {Get-ChildItem $esto -Force | more}
Function lf {Get-Command -Module X}
Function cc {Set-Location $home}
Function me {Set-Location "$home\Documents\WindowsPowerShell"}
Function work {Set-Location "$home\OneDrive\Work"}
Function open($esto) {Start-Process $esto}
Function wait([int]$time) {Start-Sleep -Seconds $time}
Function print($esto) {Write-Host $esto}
Function printFile([string]$esto) {Get-Content $esto}
Function www([string]$esto) {open "www.$esto"}
Function Get-ComObject {
    Get-ChildItem HKLM:\Software\Classes -ErrorAction SilentlyContinue | Where-Object {
            $_.PSChildName -match '^\w+\.\w+$' -and (Test-Path -Path "$($_.PSPath)\CLSID")
    } | Select-Object -ExpandProperty PSChildName
}
