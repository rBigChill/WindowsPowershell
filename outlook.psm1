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
    #$outlook.Quit()
}

function day {
    Date

    # Grab Today
    $rangeStart = [DateTime]::Now.Date
    $rangeEnd = [DateTime]::Now.Date.AddHours(24)
    
    $outlook = New-Object -ComObject Outlook.Application
    $namespace = $outlook.GetNamespace('MAPI')
    $folder = $namespace.Folders('cisneros.jorge@outlook.com')
    $calendar = $folder.Folders('Calendar').Items
    $calendar.Sort("Start")
    $calendar.IncludeRecurrences = $true

    $restriction = "[End] >= '{0}' AND [Start] <= '{1}'" -f $rangeStart.ToString("g"), $rangeEnd.ToString("g")

    $meetings = $calendar.Restrict($restriction)

    Write-Host ""
    foreach($appt in $meetings) {
        "{0:HH:mm}-{1:HH:mm}: {2}" -f [DateTime]$appt.Start, [DateTime]$appt.End, $appt.Subject
    }
    Write-Host ""
}

<<<<<<< HEAD
function week {
=======
function week{
>>>>>>> 95efbdef94d084bf28a86eae4e0067625369b3bc
    Date

    # Grab Today
    $rangeStart = [DateTime]::Now.Date
    $rangeEnd = [DateTime]::Now.AddDays(7)
    
    $outlook = New-Object -ComObject Outlook.Application
    $namespace = $outlook.GetNamespace('MAPI')
    $folder = $namespace.Folders('cisneros.jorge@outlook.com')
    $calendar = $folder.Folders('Calendar').Items
    $calendar.Sort("Start")
    $calendar.IncludeRecurrences = $true

    $restriction = "[End] >= '{0}' AND [Start] <= '{1}'" -f $rangeStart.ToString("g"), $rangeEnd.ToString("g")

    $meetings = $calendar.Restrict($restriction)

    Write-Host ""
    foreach($appt in $meetings) {
        "{0:ddd: MM/dd: HH:mm}-{1:HH:mm}: {2}" -f [DateTime]$appt.Start, [DateTime]$appt.End, $appt.Subject
    }
    Write-Host ""
}
