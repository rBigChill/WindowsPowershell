function prompt {"`n$(get-location)`n`n:)~ "}

# Import modules...
Import-Module $home\Documents\WindowsPowerShell\Internet
Import-Module $home\Documents\WindowsPowerShell\Github
Import-Module $home\Documents\WindowsPowerShell\Functions
Import-Module $home\Documents\WindowsPowerShell\Outlook
Import-Module $home\Documents\WindowsPowerShell\Work
Import-Module $home\Documents\WindowsPowerShell\Variables

# Pull the most recent files from github for profile
cd $home\Documents\WindowsPowerShell\
pull
cc

# Start my threads
Start-Job -FilePath $home\Documents\WindowsPowerShell\Threads.ps1

# Chocolatey autocomplete
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
# Update Chocolatey
function update {
    choco upgrade all -y
    wsl --update
    wsl
}
