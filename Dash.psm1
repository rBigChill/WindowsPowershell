# Clear console and start a clock with weather info
Function time {
    clear
    [System.Console]::CursorVisible = $false
    $nowHour = (Get-Date).Hour
    $nowMinute = (Get-Date).Minute
    $dateTime = (date).DateTime
    $weather = Invoke-RestMethod https://wttr.in?0Q
    $news = Reddit -d
    while($true) {
        if ($dateTime.hour -gt $hour) {
            $weather = Invoke-RestMethod https://wttr.in?0Q
            $nowHour = (Get-Date).Hour
            $nowMinute = (Get-Date).Minute
            $news = Reddit -d
            clear
        }
        [System.Console]::SetCursorPosition(0, 0)
        $dateTime = (date).DateTime
        Write-Host "$dateTime`n`n$weather$($news[0])" -NoNewLine
        Sleep 1
    }
}
