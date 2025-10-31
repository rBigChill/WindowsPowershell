python $HOME\Documents\WindowsPowershell\Scripts\Weather\emailWeather.py > $HOME\Documents\WindowsPowershell\Scripts\Weather\weather.txt

function Send-Email {
    param(
        [string]$subject,
        [string]$body
    )
    $outlook = New-Object -ComObject Outlook.Application
    $mail = $outlook.CreateItem(0)
    $mail.to = "cisneros.jorge.a@gmail.com"
    $mail.Subject = $subject
    $mail.Body = $body
    $mail.Send()
    $namespace = $outlook.GetNameSpace("MAPI")
    $outbox = $namespace.GetDefaultFolder(4)
    while ($outbox.Items.Count -gt 0) {Write-Host "Sending..."; sleep 1}

    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($mail)  | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($namespace)  | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($outbox)  | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($outlook)  | Out-Null
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()
}

$message = Get-Content -Path $HOME\Documents\WindowsPowershell\Scripts\Weather\weather.txt -Encoding UTF8 -Raw
Send-Email -Subject "Weather" -Body $message
Clear-Content $HOME\Documents\WindowsPowershell\Scripts\Weather\weather.txt
