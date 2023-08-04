# Variables
Import-Module $home\Documents\WindowsPowerShell\Var

# Longview Weather
Function weather() {
    open($WEATHER)
}

# Repeated functions
Function open($esto) {Start-Process $esto}
Function wait([int]$time) {Start-Sleep -Seconds $time}
Function print($esto) {Write-Host $esto}
Function printFile {
    param(
        [string]$esto
    )
    Get-Content $esto
}

Function su() {start-process powershell -verb runas}

Function pi() {ssh -l kali 192.168.0.43}

Function wifi() {open($ROUTER)}

Function github() {open($GITHUB)}

# Git functions
# Initialize git
Function init() {
    param(
        [string]$esto
    )
    git init; wait(1);
    git add -A; wait(1);
    git commit -m "first commit"; wait(1);
    git branch -M main; wait(1);
    git remote add origin https://github.com/rBigChill/$esto.git; wait(1);
    git push -u origin main; wait(1);
}
# Get status
Function status() {git status}
# Git push
Function push() {
    param(
        [string]$esto
    )
    git add -A;
    wait(1);
    git commit -m "$esto";
    wait(1);
    git push -u origin main;
}
# Git pull
Function pull {git pull}
Function clone {
    param (
        [string]$esto
    )
    git clone https://github.com/$esto.git
}

# Google search
Function google {
    param(
        [string]$esto,
        [string]$all
    )
    switch($all.ToLower()) {
        "y"{
            open("$GOOGLE$esto"); wait(1);
            open("$BING$esto"); wait(1);
            open("$YOU$esto"); wait(1);
            open("$YAHOO$esto"); wait(1);
            open("$DUCK$esto"); wait(1);
    } Default {
        open("$GOOGLE$esto"); wait(1);
    }
    }
}

# Open www website
Function www($esto) {open("www.$esto")}

# Open youtube
Function youtube {
    param(
        [string]$esto
    )
    if ([string]::IsNullOrEmpty($esto)) {
        open("www.youtube.com")
    }else{
        open("$YOUTUBE$esto")
    }
}

# Open Blackboard
Function black {
    open("https://kilgore.blackboard.com")
}

# Open Favs
Function fav {
    open("www.youtube.com"); wait(1);
    open("www.dev.to"); wait(1);
    open("www.instagram.com"); wait(1);
    open("www.facebook.com"); wait(1);
    open("www.linkedin.com"); wait(1);
    open("https://news.ycombinator.com/"); wait(1);
    open("www.reddit.com"); wait(1);
    open("https://news.google.com/"); wait(1);
    open("https://news.yahoo.com/"); wait(1);
}

# Open files
Function finance {open($FINANCE)}

# Basic loop
Function loop { 
    for ($i = 1; $i -lt 11; $i++) { 
        print($i)
        wait(1)
    }
}
