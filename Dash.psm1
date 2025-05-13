# Clear console and start a clock with weather info
Function time {
    clear
    [System.Console]::CursorVisible = $false
    $nowHour = (Get-Date).Hour
    $nowMinute = (Get-Date).Minute
    $dateTime = Get-Date
    $weather = Invoke-RestMethod https://wttr.in?0Q
    #$news = Reddit -d
    #$index = 0
    while($true) {
        #if ($index -ge $news.Length-2) {
        #    $index = 0
        #}
        if ($dateTime.hour -gt $nowHour) {
            $nowHour = (Get-Date).Hour
            $nowMinute = (Get-Date).Minute
            $weather = Invoke-RestMethod https://wttr.in?0Q
            $news = Reddit -d
            clear
        }
        [System.Console]::SetCursorPosition(0, 0)
        $dateTime = Get-Date
        Write-Host "$($(Get-Date).DateTime)`n`n$weather" -NoNewLine
        #$index += 1
        Sleep 1
    }
}
