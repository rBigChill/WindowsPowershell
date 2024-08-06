# Set shell prompt
Function prompt {"`n$(gl)`n`n:)~ "}

# Import personal modules
Import-Module $home\Documents\WindowsPowerShell\Internet
Import-Module $home\Documents\WindowsPowerShell\Github
Import-Module $home\Documents\WindowsPowerShell\Functions
Import-Module $home\Documents\WindowsPowerShell\Outlook
Import-Module $home\Documents\WindowsPowerShell\Work
Import-Module $home\Documents\WindowsPowerShell\Variables
Import-Module $home\Documents\WindowsPowerShell\Dash

# Pull the most recent files from github for profile
cd $home\Documents\WindowsPowerShell\
pull
cc

# Update applications 
Function update {
    winget upgrade --silent --all --include-unknown --accept-package-agreements --accept-source-agreements --force --disable-interactivity
}

# Update choco application
Function cupdate {
    choco upgrade all -y -f
}

# Start personal threads
#Start-Job -FilePath $home\Documents\WindowsPowerShell\Threads.ps1

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
