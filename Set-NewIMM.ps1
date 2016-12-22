#requires -version 3.0 -Modules 'IMM-Module'

<#
.SYNOPSIS
	Set new IMM.
.DESCRIPTION
	This script sets a brand new IMM to apply enterprise settings.
.PARAMETER IMM
	IMM IP or Hostname.
.EXAMPLE
	PS C:\scripts> .\Set-NewIMM.ps1 -IMM $IMM
.EXAMPLE
	PS C:\scripts> .\Set-NewIMM.ps1 $IMM1,$IMM2
.NOTES
	Author      :: Roman Gelman
	Version 1.0 :: 19-Dec-2016 :: [Release]
.LINK
	http://www.ps1code.com/single-post/2015/08/11/PowerShell-module-for-IBM-servers%E2%80%99-management
#>

[CmdletBinding()]

Param (
	[Parameter(Mandatory,Position=0)][string[]]$IMM
)

Begin {
	$Settings = ipcsv "$PSScriptRoot\immSettings.csv"
}

Process {

	$Settings |% {Set-IMMParam -IMM $IMM -Param $_.IMMKey -Value $_.IMMValue -Confirm:$false}

	If ($IMM -match "^[a-zA-Z]") {
		Set-IMMParam -IMM $IMM -Param 'IMMInfo_Name' -Value $IMM -Confirm:$false
		Set-IMMParam -IMM $IMM -Param 'HostName1' -Value $IMM -Confirm:$false
	}

	Set-IMMParam -IMM $IMM -Confirm:$false -Param 'LoginId.2' -Value (Get-IMMSupervisorCred -ClearText UserName)
	Set-IMMParam -IMM $IMM -Confirm:$false -Param 'Password.2' -Value (Get-IMMSupervisorCred)
	Set-IMMParam -IMM $IMM -Confirm:$false -Param 'AuthorityLevel.2' -Value Supervisor
	Set-IMMParam -IMM $IMM -IMMCred (Get-IMMSupervisorCred -PSCredential) -Confirm:$false -Param 'AuthorityLevel.1' -Value ReadOnly
}