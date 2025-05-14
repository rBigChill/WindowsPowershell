close

Write-Host "Downloading Reddit content.."
python $HOME\Documents\WindowsPowershell\Scripts\Email-News\Reddit.py >> $HOME\Documents\WindowsPowershell\Scripts\Email-News\News.txt

Write-Host "Downloading Hacker News content.."
python $HOME\Documents\WindowsPowershell\Scripts\Email-News\hackerNews.py >> $HOME\Documents\WindowsPowershell\Scripts\Email-News\News.txt

Write-Host "Downloading News API content.."
python $HOME\Documents\WindowsPowershell\Scripts\Email-News\newsAPI.py >> $HOME\Documents\WindowsPowershell\Scripts\Email-News\News.txt

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

$message = Get-Content -Path $HOME\Documents\WindowsPowershell\Scripts\Email-News\News.txt -Raw

Write-Host "Sending Email..."
Send-Email -Subject "News $(Get-Date)" -Body $message
Write-Host "Email Sent..."

Write-Host "Clearing News.txt file..."
Clear-Content $HOME\Documents\WindowsPowershell\Scripts\Email-News\News.txt
