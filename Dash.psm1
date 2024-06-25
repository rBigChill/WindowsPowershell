Function Dash {
    Clear
    while ($true) {
        $w = weather -n
        $d = Get-Date -DisplayHint Time
        Write-Host -NoNewLine `r$d $w
        sleep 60
    }
}
