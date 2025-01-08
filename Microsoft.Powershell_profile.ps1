# Set Window Title
[System.Console]::Title = "Jorge Fucken Cisneros"

# Set shell prompt
Function prompt {"`n$(gl)`n`n:)~ "}

# Import personal modules
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

# Update applications 
Function update {
    wsl --update
    winget upgrade --silent --all --include-unknown --accept-package-agreements --accept-source-agreements --force --disable-interactivity
}

# Find COM Objects
Function Get-ComObjects {
    Get-ChildItem HKLM:\Software\Classes -ErrorAction SilentlyContinue | Where-Object {
            $_.PSChildName -match '^\w+\.\w+$' -and (Test-Path -Path "$($_.PSPath)\CLSID")
    } | Select-Object -ExpandProperty PSChildName
}
