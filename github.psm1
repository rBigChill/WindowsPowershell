# Import Variables module
Import-Module $home\Documents\WindowsPowerShell\Variables

# Open github
Function github {open($GITHUB)}

# Initialize git repository
Function init {
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

# Git Status
Function status {git status}

# Git Push
Function push {
    param(
        [string]$esto
    )
    git add -A;
    wait(1);
    git commit -m "$esto";
    wait(1);
    git push -u origin main;
}

# Git Pull
Function pull {git pull}

# Git Clone
Function clone {
    param (
        [string]$esto
    )
    git clone https://github.com/$esto.git
}
