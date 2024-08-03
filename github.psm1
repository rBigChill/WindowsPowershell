# Author: Jorge Cisneros
#
# Purpose: The "I'm lazy, so here are the github commands set up as functions"

# Open the github website
Function github {start($GITHUB)}

# Initialize git repository in current location
Function init {
    param(
        [string]$esto
    )
    git init; sleep 1;
    git add -A; sleep 1;
    git commit -m "first commit"; sleep 1;
    git branch -M main; sleep 1;
    git remote add origin https://github.com/rBigChill/$esto.git; sleep 1;
    git push -u origin main; sleep 1;
}

# Git Status for current location
Function status {git status}

# Git Push work in current location
Function push {
    param(
        [string]$esto
    )
    git add -A; sleep 1;
    git commit -m "$esto"; sleep 1;
    git push -u origin main;
}

# Git Pull current files to current location
Function pull {git pull}

# Git Clone selected repository to current location
Function clone {
    param (
        [string]$esto
    )
    git clone https://github.com/$esto.git
}
