#requires -version 3.0 -Modules 'IMM-Module'

<#
.SYNOPSIS
	Create/set IMM Logins.
.DESCRIPTION
	The Set-IMMSupervisor script creates a new Supervisor Login in the IMM
	or sets the default `USERID` Login to `ReadOnly` authority level.
.PARAMETER IMM
	IMM IP or hostname.
.EXAMPLE
	PS C:\scripts> ((ipcsv 'C:\reports\IMM_Supervisor.csv').Where{$_.LoginId1,$_.LoginId2 -notcontains $Login}).IMM |.\Set-IMMSupervisor.ps1 -NewSupervisor $Login -NewSupervisorPwd $Pwd
.EXAMPLE
	PS C:\scripts> (ipcsv 'C:\reports\IMM_Supervisor.csv').IMM |.\Set-IMMSupervisor.ps1 -SetUSERIDReadOnly
.LINK
	http://www.ps1code.com/single-post/2015/08/11/PowerShell-module-for-IBM-servers%E2%80%99-management
#>



[CmdletBinding(DefaultParameterSetName='NEW')]

Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$IMM
	,
	[Parameter(Mandatory=$false,ParameterSetName='NEW')]
		[ValidateNotNullorEmpty()]
	[string]$NewSupervisor = (Get-IMMSupervisorCred -ClearText UserName)
	,
	[Parameter(Mandatory=$false,ParameterSetName='NEW')]
		[ValidateNotNullorEmpty()]
	[string]$NewSupervisorPwd = (Get-IMMSupervisorCred)
	,
	[Parameter(Mandatory,ParameterSetName='SET')]
	[switch]$SetUSERIDReadOnly
)

Begin {}

Process {
	If ($PSCmdlet.ParameterSetName -eq 'NEW') {
		Set-IMMParam -IMM $IMM -Confirm:$false -Param 'LoginId.2' -Value $NewSupervisor
		Set-IMMParam -IMM $IMM -Confirm:$false -Param 'Password.2' -Value $NewSupervisorPwd
		Set-IMMParam -IMM $IMM -Confirm:$false -Param 'AuthorityLevel.2' -Value Supervisor
	} Else {
		Set-IMMParam -IMM $IMM -IMMCred (Get-IMMSupervisorCred -PSCredential) -Confirm:$false -Param 'AuthorityLevel.1' -Value ReadOnly
	}
}