python $HOME\Scripts\Weather\emailWeather.py > $HOME\Scripts\Weather\weather.txt

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
    #ps outlook | select id | kill
}

$message = Get-Content -Path $HOME\Scripts\Weather\weather.txt -Encoding UTF8 -Raw
Send-Email -Subject "Weather" -Body $message
Clear-Content $HOME\Scripts\Weather\weather.txt
