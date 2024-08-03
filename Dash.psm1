# Author: Jorge Cisneros
#
# Purpose: Shell dashboard showing date, time, local weather, and current news articles headlines and url's.

# Function Dash prints date, time, local weather, and current news articles to shell screen.
Function Dash {
    # Start by clearing the screen
    Clear

    # Get current date and time
    $d = Get-Date

    # Run weather, reddit, hacker, and newsapi python scripts.
    #   saved returned values to variables
    $w = weather -n
    $r = reddit -d
    $h = hacker -d
    $n = newsapi -d

    # Function header handles printing date, time, and weather to screen
    Function header {
        # Clear the screen
        Clear

        # Get date, modify it and write to host with no new lines
        $d = Get-Date
        $date = $d.ToString("dddd, MMMM dd, yyyy HH:mm")
        Write-Host $date`n
        Write-Host "Weather: $w`n"
    }

    # Main while loop
    while ($true) {
        # Check last time variables were loaded/re-loaded
        # if longer than 1 hour, reload variables with current data
        $span = New-TimeSpan -Start $d -End (Get-Date)
        switch ($true) {
            (($span).Hours -gt 1) {
                $w = weather -n
                $r = reddit -d
                $h = hacker -d
                $n = newsapi -d
            }
            # Main printing function. Prints information to screen
            # 1 page at 60 second intervals.
            Default {
                header
                ForEach ($a in $r) {Write-Host $a}
                Sleep 60

                header
                ForEach ($a in $h) {Write-Host $a}
                Sleep 60

                header
                ForEach ($a in $n) {Write-Host $a}
                Sleep 60
            }
        }
    }
}
