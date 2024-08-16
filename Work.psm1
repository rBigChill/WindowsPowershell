# Author: Jorge Cisneros
#
# Purpose: Functions to use at work

# Main script creates pop up boxes for work reminders
Function script {
    Start-Job -ScriptBlock {

        Add-Type -AssemblyName PresentationFramework

        Function ItIs($hour, $min) {
            $now = Get-Date
            if ($now.Hour -eq $hour -and $now.Minute -eq $min) {
                return $true
            }
            return $false
        }

        while ($true) {
            Switch ($true) {
                (ItIs 11 58) {[System.Windows.MessageBox]::Show("Working Out?"); Start-Sleep -Seconds 60}
                (ItIs 12 00) {[System.Windows.MessageBox]::Show("Lunch"); Start-Sleep -Seconds 60}
                (ItIs 16 58) {[System.Windows.MessageBox]::Show("Get Ready to Leave"); Start-Sleep -Seconds 60}
                (ItIs 17 00) {[System.Windows.MessageBox]::Show("Go Home"); Start-Sleep -Seconds 60}
                (ItIs 21 00) {[System.Windows.MessageBox]::Show("Stop Working"); Start-Sleep -Seconds 60}
            }
            Start-Sleep -Seconds 1
        }
    }
}

# Start script function and handle weather hourly update
Function here {
    script
    Clear
    $count = 0
    $w = weather -n
    while ((Get-Date -Format "HH:mm") -ne "17:01") {
        if ($count * 60 -eq 3600) {
            $w = weather -n
            $count = 0
        }
        Write-Host -NoNewLine `r(Get-Date -DisplayHint Time) ~ "Weather:"$w
        $count++
        Start-Sleep -Seconds 1
    }
    out
    exit
}

# Stop job/script when leaving for the day
Function out {
    $job = Get-Job
    foreach ($jobNumber in $job) {
        Stop-Job -ID $jobNumber.Id
        Remove-Job -ID $jobNumber.Id
    }
}

Function stu {
    param(
        [int]$ID
    )

    if (Get-Module -ListAvailable SqlServer) {
        Import-Module -Name SqlServer
    } else {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Install-PackageProvider -Name NuGet -Force
        Install-Module -Name SqlServer -Scope CurrentUser -Force
        Import-Module -Name SqlServer
    }

    $SqlServer = "KCL-SQL01"
    $SqlDBName = "TmsEPrd"
    $SchemaName = "dbo"

    function Student-Master {
        param(
            [int]$ID
        )
        Invoke-Sqlcmd -ServerInstance $SqlServer -Encrypt Optional -Query "
            SELECT
                'ID' = SM.ID_NUM,
                'Last' = NM.LAST_NAME,
                'First' = NM.FIRST_NAME,
                'Middle' = NM.MIDDLE_NAME,
                'Active' = IS_STUDENT_ACTIVE,
                'Start Year' = SM.ENTRANCE_YR,
                'Start Term' = SM.ENTRANCE_TRM
            FROM $SqlDBName.$SchemaName.STUDENT_MASTER SM
                JOIN $SqlDBName.$SchemaName.NameMaster NM ON SM.ID_NUM = NM.ID_NUM
            WHERE SM.ID_NUM = $ID"
    }

    function Student-Courses {
        param(
            [int]$ID
        )
        Invoke-Sqlcmd -ServerInstance $SqlServer -Encrypt Optional -Query "
            SELECT
                Top 4
                'ID' = ID_NUM,
                'Year' = YR_CDE,
                'Term' = TRM_CDE,
                'Course' = CRS_TITLE,
                'Add' = ADD_DTE,
                'Start' = BEGIN_DTE,
                'End' = END_DTE
            FROM $SqlDBName.$SchemaName.STUDENT_CRS_HIST
            WHERE ID_NUM = $ID
            ORDER BY YR_CDE DESC"
    }

    function Lookup {
        param(
            [int]$ID
        )
        Write-Host "AD Info"
        Get-ADUser $ID
        Write-Host "Master Info"
        Student-Master -ID $ID
        Write-Host "Courses"
        Student-Courses -ID $ID
    }

    try {
        Lookup -ID $ID
    }
    catch {
        $errorMessage = "Error occurred: $_"
        Write-Host $errorMessage
    }
}

Function emp {
    param(
        [string]$first,
        [string]$last
    )

    if (Get-Module -ListAvailable SqlServer) {
        Import-Module -Name SqlServer
    } else {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Install-PackageProvider -Name NuGet -Force
        Install-Module -Name SqlServer -Scope CurrentUser -Force
        Import-Module -Name SqlServer
    }

    $SqlServer = "KCL-SQL01"
    $SqlDBName = "TmsEPrd"
    $SchemaName = "dbo"

    function Name-Master {
        param(
            [string]$first,
            [string]$last
        )
        Invoke-Sqlcmd -ServerInstance $SqlServer -Encrypt Optional -Query "
            SELECT
	            'ID' = NM.ID_NUM,
	            'Last' = LAST_NAME,
	            'First' = FIRST_NAME,
	            'Middle' = MIDDLE_NAME,
	            'Active' = ACT_INACT_STS,
	            'Confirmed' = DTE_CONFIRMED,
	            'Hired' = ORIG_HIRE_DTE,
	            'Start' = FULLTIME_START_DTE,
	            'Group' = GRP_CDE,
	            'Termed' = TERMINATION_DTE
	        FROM $SqlDBName.$SchemaName.NameMaster NM
		        JOIN $SqlDBName.$SchemaName.EMPL_MAST EM ON EM.ID_NUM = NM.ID_NUM
	        WHERE NM.FIRST_NAME = '$first' AND NM.LAST_NAME = '$last'"
    }

    function OnGoing-Load {
        param(
            [string]$first,
            [string]$last
        )
        Invoke-Sqlcmd -ServerInstance $SqlServer -Encrypt Optional -Query "
            SELECT
	            'Operation' = OperationDate,
	            'Type' = OperationType,
	            'Last' = LastName,
	            'First' = FirstName,
	            'Middle' = MiddleName,
	            'Email' = WorkEmailID,
	            'Phone' = WorkPhone,
	            'Code' = AgencyCode,
	            'User' = AgencyUserID,
	            'Add' = AddApplicationAccess,
	            'Remove' = RemoveApplicationAccess
            FROM $SqlDBName.$SchemaName.KCT_003580_ONGOING_LOAD
	        WHERE FirstName = '$first' AND LastName = '$last'"
    }

    function Lookup {
        param(
            [string]$first,
            [string]$last
        )
        $initial = $first[0]
        Write-Host "AD Info"
        Get-ADUser $initial$last
        Write-Host "Master Info"
        Name-Master -first $first -last $last
        Write-Host "Load Info"
        OnGoing-Load -first $first -last $last
    }

    try {
        Lookup -first $first -last $last
    }
    catch {
        $errorMessage = "Error occurred: $_"
        Write-Host $errorMessage
    }
}

# Print to screen all Active Directory computers on network
Function Computers {
    get-adcomputer -Filter * | select-object Name | sort Name
}

# Print to screen uptime from selected machine
Function utime {
    $info = get-computerinfo
    new-timespan -start $info.OsLastBootUpTime -end $info.OsLocalDateTime
}

# Print to screen running servcies on selected machine
Function running {
    service | where {$_.Status -eq "Running"}
}

# Print to screen stopped services from selected machine
Function stopped {
    service | where {$_.Status -eq "Stopped"}
}

