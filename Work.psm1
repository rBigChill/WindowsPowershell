#Author: Jorge Cisneros

# Purpose: Functions to use at work

Function here {
    clear
    [System.Console]::CursorVisible = $false
    while ($true) {
        $h = 16 - (date).Hour
        $m = 60 - (date).Minute
        $s = 60 - (date).Second
        if ($h -le 1) {
            Write-Host "$h Hour  `n$m Minutes  `n$s Seconds  "
        } else {
            Write-Host "$h Hours  `n$m Minutes  `n$s Seconds  "
        }
        [System.Console]::SetCursorPosition(0, 0)
        Sleep 1
    }
}

Function stu {
    param(
        [int]$ID
    )

    if (Get-Module -ListAvailable SqlServer) {
        Import-Module -Name SqlServer
    } else {
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
        Get-ADUser -Filter "Name -Like '*$ID*'"
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
                'Phone' = EWL.PHONE_NUMBER,
	            'Termed' = TERMINATION_DTE
	        FROM $SqlDBName.$SchemaName.NameMaster NM
		        JOIN $SqlDBName.$SchemaName.EMPL_MAST EM ON EM.ID_NUM = NM.ID_NUM
                JOIN $SqlDBName.$SchemaName.EMPL_WRK_LOC EWL ON EWL.ID_NUM = NM.ID_NUM
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
        Write-Host "AD Info"
        Get-ADUser -Filter "Name -Like '*$first $last*'"
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
