$url = "https://www.texaslottery.com/export/sites/lottery/Games/Lotto_Texas/index.html"
$lotto = Invoke-WebRequest($url) -UseBasicParsing
$content = $lotto.Content.Substring($lotto.Content.IndexOf("LOTTO TEXAS"), 422)

# Regex patterns
$jackpotDate     = [regex]::Match($content, 'Est\. Annuitized Jackpot for (\d{2}/\d{2}/\d{4})').Groups[0].Value
$jackpotAmount   = [regex]::Match($content, '<h1>\$(.*?.\w+)</h1>').Groups[0].Value
$cashValue       = [regex]::Match($content, 'Cash Value: <strong>\$(.*?)</strong>').Groups[1].Value

# Output results
$message = "$jackpotDate`n"
$message += "Jackpot Amount: $($jackpotAmount -replace '<.*?>', '')`n"
$message += "Cash Value: $cashValue`n"

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

close

Write-Host "Sending..."
Send-Email -Subject "Lotto Texas $(Get-Date)" -Body $message
Write-Host "Sent..."
