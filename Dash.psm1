# Clear console and start a clock with weather info
Function time {
    clear
    [System.Console]::CursorVisible = $false
    $weather = Invoke-RestMethod https://wttr.in
    $hour = (Get-Date).Hour
    while($true) {
        $now = (Get-Date).Hour
        if ($now -gt $hour) {
            $weather = Invoke-RestMethod https://wttr.in
            $hour = (Get-Date).Hour
            clear
        }
        [System.Console]::SetCursorPosition(0, 0)
        Write-Host "$(date)`n`n$weather" -NoNewLine
        Sleep 1
    }
}
