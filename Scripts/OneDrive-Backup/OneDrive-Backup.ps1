# Log
$emailLog = "$HOME\Scripts\OneDrive-Backup\OneDrive-EmailLog.txt"

# Drive locations
$oneDrive = "$HOME\OneDrive"
$netDrive = "D:\OneDriveBackup"

# Write-Log appends log service messages to file
function Write-Log {
    param(
        [string]$message
    )
    $currentTime = Get-Date
    $logMessage = "$currentTime : $message"
    Add-Content $emaillog $logMessage
}

# Log
function Log-This {
    param(
        [string]$message
    )
    Write-Host $message
    Write-Log $message
}

# Send-Email sends email
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

function Get-DriveContents {
    $message = "Verifying updated files from OneDrive"
    Log-This $message
    
    $message = "Inspecting OneDrive Content"
    Log-This $message
    $oneDriveContents = Get-ChildItem -LiteralPath $oneDrive -Recurse

    $message = "Inspecting Network Drive Content"
    Log-This $message
    $netDriveContents = Get-ChildItem -LiteralPath $netDrive -Recurse

    return $oneDriveContents, $netDriveContents
}

# Update older files on network drive using write time differences
function Update-BackupDrive {

    $oneDriveContents, $netDriveContents = Get-DriveContents

    # Keep track
    $memory = @{}

    # Save files from one drive to memory
    ForEach ($file in $oneDriveContents) {
        # Add file to memory
        $memory[$file.Name] = $file.FullName, $file.LastWriteTime
        
        # Trim C:\ Root path
        $cutPath = $file.FullName.Remove(0, $oneDrive.Length+1)
        # Add D:\ Root Path
        $filePath = $netDrive + "\" + $cutPath
        $testPath = Test-Path -LiteralPath $filePath
    
        if (!$testPath) {
            # Copy file to network drive
            $message = "Copying to Backup Drive: $filePath"
            Log-This $message
            if ($file.PSIsContainer) {
                Copy-Item -Path $file.FullName -Destination $filePath -Recurse -Force
            } else {
                Copy-Item -Path $file.FullName -Destination $filePath -Force
            }
        }
    }

    # Save files from one drive to network drive
    ForEach ($file in $netDriveContents) {
        # if one drive last write time -gt network drive last write time
        if (!$file.PSIsContainer -and $memory.ContainsKey($file.Name) -and $memory[$file.Name][1] -gt $file.LastWriteTime) {
            # Copy file from one drive to network drive
            $message = "Updating: ", $file.FullName
            Log-This $message
            Copy-Item -Path $memory[$file.Name][0] -Destination $file.FullName -Force
        }
        
        # Trim D:\ Root path
        $cutPath = $file.FullName.Remove(0, $netDrive.Length+1)
        # Add C:\ Root Path
        $filePath = $oneDrive + "\" + $cutPath
        $testPath = Test-Path -LiteralPath $filePath
        
        if (!$testPath) {
            # Delete file from network drive
            $message = "Deleting from Backup Drive: " + $file.FullName
            Log-This $message
            if ($file.PSIsContainer) {
                Remove-Item -Path $file.FullName -Recurse -Force
            } else {
                Remove-Item -Path $file.FullName -Force
            }
        }
    }
    Log-This "Update Complete..."
}

# Main
try {
    Update-BackupDrive
    $date = Get-Date
    $body = Get-Content -Path $emailLog -Encoding UTF8 -Raw
    Send-Email -subject "Log File: $date" -body "$body"
    Clear-Content -Path $emailLog
} catch {
    $message = $_
    Log-This $message
    $date = Get-Date
    $body = Get-Content -Path $emailLog -Encoding UTF8 -Raw
    Send-Email -subject "Log File: $date" -body "$body"
    Clear-Content -Path $emailLog
}
