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
    $outlook.Quit()
}

function Get-Meetings {
    $today = Get-Date
    $month = $today.Month
    $day = $today.Day
    $year = $today.Year

    $properties = @(
        'Subject',
        'Start',
        'Duration',
        'Location',
        'Body'
    )
    
    $outlook = New-Object -ComObject Outlook.Application
    $namespace = $outlook.GetNamespace('MAPI')
    $folder = $namespace.Folders('cisneros.jorge@outlook.com')
    $calendar = $folder.Folders('Calendar')
    $meetings = $calendar.Items | Select-Object -Property $properties 
    $meetings | Where-Object {$_.Start.Month -eq $month -and $_.Start.Day -eq $day -and $_.Start.Year -eq $year}
    $outlook.Quit()
}
