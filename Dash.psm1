# Clear console and start a clock with weather info
Function time {
    [System.Console]::CursorVisible = $false
    clear
    $nowHour = (Get-Date).Hour
    $nowMinute = (Get-Date).Minute
    $dateTime = Get-Date
    $weather = weather -n
    $news = Reddit -d
    $news += hacker -d
    $news += newsapi -d
    $index = 0
    while($true) {
        if ($dateTime.Second -eq 59) {
            $index += 1
            clear
        }
        if ($index -ge $news.Length - 2) {
            $index = 0
            clear
        }
        if ($dateTime.hour -gt $nowHour) {
            clear
            $nowHour = (Get-Date).Hour
            $nowMinute = (Get-Date).Minute
            $dateTime = Get-Date
            $weather = weather -n
            $news = Reddit -d
            $news += hacker -d
            $news += newsapi -d
            $index = 0
        }
        [System.Console]::SetCursorPosition(0, 0)
        $dateTime = Get-Date
        Write-Host "$($(Get-Date).DateTime)`n`n$weather`n`n$($news[$index].ToString().Trim())" -NoNewLine
        Sleep 1
    }
}
