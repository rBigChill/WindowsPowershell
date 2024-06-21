# start github
Function github {start($GITHUB)}

# Initialize git repository
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

# Git Status
Function status {git status}

# Git Push
Function push {
    param(
        [string]$esto
    )
    git add -A; sleep 1;
    git commit -m "$esto"; sleep 1;
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
