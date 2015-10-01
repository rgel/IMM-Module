# IMM-Module

http://rgel75.wix.com/blog

http://goo.gl/VCjjFI

To install this module, drop the entire 'IMM-Module' folder into one of your module directories.

The default PowerShell module paths are listed in the `$env:PSModulePath` environment variable.

The default per-user module path is:       `"$env:HOMEDRIVE$env:HOMEPATH\Documents\WindowsPowerShell\Modules"`.

The default computer-level module path is: `"$env:windir\System32\WindowsPowerShell\v1.0\Modules"`.

To use the module, type the following:     `ipmo IMM-Module -Force -Verbose`.

To see the commands imported, type         `gc -Module IMM-Module`.

For help on each individual cmdlet or function, run `Get-Help CmdletName -Full [-Online][-Examples]`.

IMM-Module CHANGELOG

1.3 - 25/08/2015

	CHANGE:					Function Improvements.
	AFFECTED FUNCTIONS:		Get-IMMSubnet.
	DESCRIPTION:			Added new parameter -ExcludeIP.
	
1.2 - 23/07/2015

	CHANGE:			      	Content-based help Improvements.
	AFFECTED FUNCTIONS:		ALL.
	DESCRIPTION:	    	".PARAMETER" tags edited.
	
	CHANGE:			      	Bugfix.
	AFFECTED FUNCTIONS:		All functions that support '-Confirm' parameter.
	DESCRIPTION:    		'$IMM' variable replaced by '$module' in $PSCmdlet.ShouldProcess($module,"") method.

1.1 - 27/05/2015
	
	CHANGE:		      		Function Improvements.
	AFFECTED FUNCTIONS:		Get-IMMISO, Mount-IMMISO.
	DESCRIPTION:	    	Added 'rdmount' running process check in the 'Begin' scope before function call.
	
	CHANGE:			      	Function Improvements.
	AFFECTED FUNCTIONS:		Set-IMMServerBootOrder.
	DESCRIPTION:    		Added 'Windows Boot Manager' entry in [ValidateSet()] statement for all Boot devices.

1.0 - 17/05/2015        Initial release
