#requires -version 3.0 -Modules 'IMM-Module'

<#
.SYNOPSIS
	Get IMM with USERID/PASSW0RD Supervisor.
.DESCRIPTION
	The Get-IMMSupervisor script gets IMM with default credentials and `Supervisor` authority level.
.PARAMETER IMM
	IMM IP or hostname.
.EXAMPLE
	PS C:\scripts> $rep1 = Get-IMMSubnet '10.98.1.0' |.\Get-IMMSupervisor.ps1
	PS C:\scripts> $rep1 |epcsv -notype C:\reports\IMM_Supervisor.csv
	PS C:\scripts> $rep2 = Get-IMMSubnet '10.99.1.0' |.\Get-IMMSupervisor.ps1
	PS C:\scripts> $rep2 |epcsv -notype C:\reports\IMM_Supervisor.csv -Append
.NOTES
	Author      :: Roman Gelman
	Version 1.0 :: 19-Dec-2016 :: [Release]
.LINK
	http://www.ps1code.com/single-post/2015/08/11/PowerShell-module-for-IBM-servers%E2%80%99-management
#>

[CmdletBinding()]

Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$IMM
)

Begin {}

Process {

		$Properties = [ordered]@{
			IMM             = $IMM[0]
			LoginId1        = (Get-IMMParam -IMM $IMM -Param 'LoginId.1').Value
			AuthorityLevel1 = (Get-IMMParam -IMM $IMM -Param 'AuthorityLevel.1').Value
			LoginId2        = (Get-IMMParam -IMM $IMM -Param 'LoginId.2').Value
			AuthorityLevel2 = (Get-IMMParam -IMM $IMM -Param 'AuthorityLevel.2').Value
		}
		$Object = New-Object PSObject -Property $Properties
		If (($Object.LoginId1 -eq 'USERID' -and $Object.AuthorityLevel1 -eq 'Supervisor') -or ($Object.LoginId2 -eq 'USERID' -and $Object.AuthorityLevel2 -eq 'Supervisor')) {$Object}
}
