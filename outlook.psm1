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

function Get-Meetings {
    $today = Get-Date
    $month = $today.Month
    $day = $today.Day
    $year = $today.Year
    
    $outlook = New-Object -ComObject Outlook.Application
    $namespace = $outlook.GetNamespace('MAPI')
    $folder = $namespace.Folders('cisneros.jorge@outlook.com')
    $calendar = $folder.Folders('Calendar')
    $meetings = $calendar.Items | Select-Object -Property Subject, Start, Duration, Location, Body
    $meetings | Where-Object {$_.Start.Month -eq $month -and $_.Start.Day -eq $day -and $_.Start.Year -eq $year}
}
