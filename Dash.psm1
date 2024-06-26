Function Dash {
    Clear

    $d = Get-Date
    $w = weather -n
    $r = reddit -d
    $h = hacker -d
    $n = newsapi -d

    while ($true) {
        $span = New-TimeSpan -Start $d -End (Get-Date)
        switch ($true) {
            (($span).Hours -gt 1) {
                Clear
                $d = Get-Date
                $w = weather -n
                $r = reddit -d
                $h = hacker -d
                $n = newsapi -d
                $date = $d.ToString("dddd, MMMM dd, yyyy HH:mm")
                Write-Host $date`n; Sleep 2
                Write-Host "Weather: $w`n"; Sleep 2
                ForEach ($a in $r) {Write-Host $a; Sleep 1}
                ForEach ($a in $h) {Write-Host $a; Sleep 2}
                ForEach ($a in $n) {Write-Host $a; Sleep 2}
                Sleep 1
            }
            Default {
                Clear
                $d = Get-Date
                $date = $d.ToString("dddd, MMMM dd, yyyy HH:mm")
                Write-Host $date`n; Sleep 2
                Write-Host "Weather: $w`n"; Sleep 2
                ForEach ($a in $r) {Write-Host $a; Sleep 2}
                ForEach ($a in $h) {Write-Host $a; Sleep 2}
                ForEach ($a in $n) {Write-Host $a; Sleep 2}
                Sleep 1
            }
        }
    }
}
