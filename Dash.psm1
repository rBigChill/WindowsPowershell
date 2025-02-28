# Clear console and start a clock with weather info
Function time {
    clear
    [System.Console]::CursorVisible = $false
    $weather = weather -n
    $hour = (Get-Date).Hour
    while($true) {
        $now = (Get-Date).Hour
        if ($now -gt $hour) {
            $weather = weather -n
            $hour = (Get-Date).Hour
            clear
        }
        [System.Console]::SetCursorPosition(0, 0)
        Write-Host "$(date) $weather" -NoNewLine
        Sleep 1
    }
}