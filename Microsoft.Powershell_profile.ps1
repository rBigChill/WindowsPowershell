Import-Module $home\Documents\WindowsPowerShell\X

Start-Job -FilePath $home\Documents\WindowsPowerShell\threads.ps1

# Alias
Function ll {ls | more}

#Function Prompt {"`n:)~ "}
Function lf {Get-Command -Module X}
Function cc {Set-Location $home}
Function me {Set-Location "$home\Documents\WindowsPowerShell"}
Function work {Set-Location "$home\OneDrive\Work"}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
