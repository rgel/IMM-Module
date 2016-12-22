#requires -version 3.0 -Modules 'IMM-Module','DnsServer'

<#
.SYNOPSIS
	Create IMM subnet report.
.DESCRIPTION
	The Report-IMMSubnetScan script creates IMM subnet report.
.EXAMPLE
	PS C:\scripts> .\Report-IMMSubnetScan.ps1 '10.98.1.0' 103 112 -DNS $DnsServer -Zone 'domain.com' -IMMReport 'C:\reports\IMMReport.csv'
.EXAMPLE
	PS C:\> (ipcsv C:\reports\IMMReport.csv).Where{$_.ServerModel}
	Filter from the report the live IMM only.
.EXAMPLE
	PS C:\> (ipcsv C:\reports\IMMReport.csv).Where{$_.ServerModel -and $_.DNSRecordsCount -gt 1} |ft -au
	Filter from the report the live IMM with duplicate DNS records.
.NOTES
	Author      :: Roman Gelman
	Version 1.0 :: 19-Dec-2016 :: [Release]
.LINK
	http://www.ps1code.com/single-post/2015/08/11/PowerShell-module-for-IBM-servers%E2%80%99-management
#>

[CmdletBinding()]

Param (
	[Parameter(Mandatory,Position=1,HelpMessage="Class C network subnet, must end by zero")]
		[ValidatePattern("^(?<A>2[0-4]\d|25[0-5]|[01]?\d\d?)\.(?<B>2[0-4]\d|25[0-5]|[01]?\d\d?)\.(?<C>2[0-4]\d|25[0-5]|[01]?\d\d?)\.(?<D>0)$")]
		[Alias("Network")]
	[string]$Subnet
	,
	[Parameter(Mandatory=$false,Position=2,HelpMessage="First IP address in range")]
		[ValidateRange(1,253)]
		[Alias("FirstIP")]
	[int32]$StartIP = 1
	,
	[Parameter(Mandatory=$false,Position=3,HelpMessage="Last IP address in range")]
		[ValidateRange(2,254)]
		[Alias("LastIP")]
	[int32]$EndIP = 254
	,
	[Parameter(Mandatory,Position=4,HelpMessage='DNS server name')]
		[Alias("DNS")]
	[string]$DNSServer
	,
	[Parameter(Mandatory,Position=5,HelpMessage='DNS zone name')]
		[Alias("Zone")]
	[string]$DNSZone
	,
	[Parameter(Mandatory,Position=6,HelpMessage='Csv report file full path')]
		[ValidateScript({Test-Path -Path (Split-Path -Path $_) -PathType Container})]
		[ValidatePattern('\.csv$')]
		[Alias("IMMReportCsv")]
	[string]$IMMReport
)

### Create subnet IP collection ###
$IPcol = Get-IMMSubnet -Subnet $Subnet -StartIP $StartIP -EndIP $EndIP

#region Scan and query IMM subnet

$colIMM = @()
Foreach ($IP in $IPcol) {
	$objIMM = Get-IMMInfo -IMM $IP -IMMCred (Get-IMMSupervisorCred -PSCredential)
	If ($objIMM.Serial -eq '') {$objIMM = Get-IMMInfo -IMM $IP}
	$colIMM += $objIMM
}

#endregion

#region Query DNS zone ###

$dnsSubnet = $Subnet -replace '0$','*'

$dnsARecords = Get-DnsServerResourceRecord `
-ZoneName $DNSZone -ComputerName $DNSServer -RRType 'A' |
select HostName,@{N='IPv4';E={($_ |select -expand RecordData).IPv4Address}} |
? {$_.IPv4 -like "$dnsSubnet" -and $_.HostName -notmatch '\.'}

If ($dnsARecords) {
	$colDNS = @()
	$colDNS = $dnsARecords |sort IPv4 |group IPv4 |
	select @{N='ARIP';E={$_.Name}},Count,@{N='ARName';E={($_ |select -expand Group).HostName}}	
} Else {
	Throw "No DNS records found"
}

#endregion

#region Consolidate IMM & DNS collections ###

Foreach ($imm in $colIMM) {
	Foreach ($dns in $colDNS) {
		If ($imm.IMM -eq $dns.ARIP) {
			$Properties = [ordered]@{
				IP              = $imm.IMM
				IMMDisplayName  = $imm.DisplayName
				IMMHostName     = $imm.HostName
				ServerType      = $imm.Server
				ServerModel     = $imm.Model
				ServerSerial    = $imm.Serial
				IMMContact      = $imm.Contact
				IMMLocation     = $imm.Location
				DNSRecordsCount = $dns.Count
				DNSRecords      = $dns.ARName
			}
			$obj = New-Object -TypeName PSObject -Property $Properties
			$obj |Export-Csv -NoTypeInformation -Path $IMMReport -Append
		}
	}
}

#endregion

### Show the report ###
If (Test-Path -Path $IMMReport -PathType Leaf) {Invoke-Item $IMMReport -ErrorAction SilentlyContinue}
