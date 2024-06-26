Function Dash {
    Clear

    $d = Get-Date
    $w = weather -n
    

    while ($true) {
        $span = New-TimeSpan -Start $d -End (Get-Date)
        switch ($true) {
            (($span).Hours -gt 1) {
                $d = Get-Date
                $w = weather -n
                $message = $d, $w
                Write-Host -NoNewLine `r$d $w
                Sleep 1
            }
            Default {
                Write-Host -NoNewLine `r$d $w
                Sleep 1
            }
        }
    }
}
