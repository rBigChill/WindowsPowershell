# Author: Jorge Cisneros
#
# Purpose: Shell dashboard showing date, time, local weather, and current news articles headlines and url's.

# Function Dash prints date, time, local weather, and current news articles to shell screen.
Function Dash {
    # Clear the screen
    Clear

    # Get current date, time, and weather
    $d = Get-Date
    $w = weather -n

    # Function header handles printing date, time, and weather to screen
    Function header {
        # Get date, modify it and write to host with no new lines
        $date = (Get-Date).ToString("dddd, MMMM dd, yyyy HH:mm:ss")
        $message = "$date - Weather: $w"
        Write-Host $message -NoNewline `r
    }

    # Main while loop
    while ($true) {
        # Check last time variables were loaded
        $span = New-TimeSpan -Start $d -End (Get-Date)

        switch ($true) {
            # if longer than 1 hour, reload variables with current data
            (($span).Hours -gt 1) {
                $d = Get-Date
                $w = weather -n
            }
            # Print information to screen
            Default {
                header
            }
        }
    }
}
