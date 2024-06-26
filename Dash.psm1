Function Dash {
    Clear

    $d = Get-Date
    $w = weather -n
    $r = reddit -d

    while ($true) {
        $span = New-TimeSpan -Start $d -End (Get-Date)
        switch ($true) {
            (($span).Hours -gt 1) {
                Clear
                $d = Get-Date
                $w = weather -n
                $date = $d.ToString("dddd, MMMM dd, yyyy HH:mm")
                Write-Host $date`n; Sleep 2
                Write-Host "Weather: $w`n"; Sleep 2
                ForEach ($a in $r) {Write-Host $a; Sleep 1}
                Sleep 60
            }
            Default {
                Clear
                $date = $d.ToString("dddd, MMMM dd, yyyy HH:mm")
                Write-Host $date`n; Sleep 2
                Write-Host "Weather: $w`n"; Sleep 2
                ForEach ($a in $r) {Write-Host $a; Sleep 2}
                Sleep 60
            }
        }
    }
}
