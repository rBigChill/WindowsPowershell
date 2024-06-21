python .\emailWeather.py > weather.txt

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
}

$message = Get-Content -Path weather.txt -Encoding Unicode -Raw
Send-Email -Subject "Weather" -Body $message
