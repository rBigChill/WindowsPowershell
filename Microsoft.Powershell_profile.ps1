#Function Prompt {"`n:)~ "}

# Import modules...
Import-Module $home\Documents\WindowsPowerShell\X
Import-Module $home\Documents\WindowsPowerShell\github
Import-Module $home\Documents\WindowsPowerShell\funcs
Import-Module $home\Documents\WindowsPowerShell\outlook

# Start my threads
Start-Job -FilePath $home\Documents\WindowsPowerShell\threads.ps1

# Chocolatey autocomplete
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
# Update Chocolatey
function update {choco upgrade all -y}
