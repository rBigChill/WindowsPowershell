# Import modules...
Import-Module $home\Documents\WindowsPowerShell\X
Import-Module $home\Documents\WindowsPowerShell\github

# Start my threads
Start-Job -FilePath $home\Documents\WindowsPowerShell\threads.ps1

# Personal Functions
Function off {shutdown /s /t 0}
Function restart {Restart-Computer}
Function su {start-process powershell -verb runas}
Function ll($esto) {Get-ChildItem $esto -Force | more}
#Function Prompt {"`n:)~ "}
Function lf {Get-Command -Module X}
Function cc {Set-Location $home}
Function me {Set-Location "$home\Documents\WindowsPowerShell"}
Function work {Set-Location "$home\OneDrive\Work"}

Function open($esto) {Start-Process $esto}
Function wait([int]$time) {Start-Sleep -Seconds $time}
Function print($esto) {Write-Host $esto}
Function printFile {
    param(
        [string]$esto
    )
    Get-Content $esto
}

# Open www website
Function www {
  param(
      [string]$esto
  )
  open "www.$esto"
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function upgradechoc {choco upgrade all -y}
