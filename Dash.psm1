# Clear console and start a clock with weather info
Function time {
    clear
    [System.Console]::CursorVisible = $false
    $nowHour = (Get-Date).Hour
    $nowMinute = (Get-Date).Minute
    $dateTime = Get-Date
    $weather = Invoke-RestMethod https://wttr.in?0Q
    #$news = Reddit -d
    while($true) {
        if ($dateTime.hour -gt $nowHour) {
            $nowHour = (Get-Date).Hour
            $nowMinute = (Get-Date).Minute
            $weather = Invoke-RestMethod https://wttr.in?0Q
            #$news = Reddit -d
            clear
        }
        [System.Console]::SetCursorPosition(0, 0)
        $dateTime = Get-Date
        Write-Host "$($(Get-Date).DateTime)`n`n$weather" -NoNewLine
        Sleep 1
    }
}

# Grab seconds. Every 00; print new article
