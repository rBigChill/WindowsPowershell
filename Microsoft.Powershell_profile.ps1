# Set Window Title
[System.Console]::Title = "Welcome to the Jungle!"

# Set shell prompt
Function prompt {"`n$(gl)`n`n:)~ "}

# Import personal modules
Import-Module $home\Documents\WindowsPowerShell\Dash
Import-Module $home\Documents\WindowsPowerShell\Github
Import-Module $home\Documents\WindowsPowerShell\Internet
Import-Module $home\Documents\WindowsPowerShell\Outlook
Import-Module $home\Documents\WindowsPowerShell\Variables
Import-Module $home\Documents\WindowsPowerShell\Work
Import-Module $home\Documents\WindowsPowerShell\Windows
