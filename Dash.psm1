# Clear console and start a clock with weather info
Function time {
    clear
    [System.Console]::CursorVisible = $false
    $news = Reddit -d
    $weather = Invoke-RestMethod https://wttr.in?0Q
    $hour = (Get-Date).Hour
    while($true) {
        $now = (Get-Date).Hour
        if ($now -gt $hour) {
            $weather = Invoke-RestMethod https://wttr.in?0Q
            $hour = (Get-Date).Hour
            clear
        }
        [System.Console]::SetCursorPosition(0, 0)
        $now = (date).DateTime
        Write-Host "$now`n$($news[0])`n`n$weather" -NoNewLine
        Sleep 1
    }
}
