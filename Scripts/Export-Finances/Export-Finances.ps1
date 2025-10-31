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

function Export-Finances {
    $excel = New-Object -ComObject Excel.Application
    $excel.Visible = $true

    $wb = $excel.Workbooks.Open("$home\OneDrive\Documents\Finances.xlsx")
    $file = "$home\OneDrive\Work\Export-Finances\Finances.pdf"
    $wb.Worksheets['Dash'].ExportAsFixedFormat(0, $file)

    $excel.DisplayAlerts = $false
    $excel.Quit()
    
    Send-Email -subject "Finances" -body "Update..." -file $file
}

Export-Finances
