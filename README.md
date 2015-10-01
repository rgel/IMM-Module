# IMM-Module
### PowerShell module for IBM servers’ management

<http://goo.gl/VCjjFI> <i>Blog Article</i>

To install this module, drop the entire '<b>IMM-Module</b>' folder into one of your module directories.

The default PowerShell module paths are listed in the `$env:PSModulePath` environment variable.

The default per-user module path is: `"$env:HOMEDRIVE$env:HOMEPATH\Documents\WindowsPowerShell\Modules"`.

The default computer-level module path is: `"$env:windir\System32\WindowsPowerShell\v1.0\Modules"`.

To use the module, type the following: `ipmo IMM-Module -Force -Verbose`.

To see the commands imported, type `gc -Module IMM-Module`.

For help on each individual cmdlet or function, run `Get-Help CmdletName -Full [-Online][-Examples]`.

##### <ins>IMM-Module CHANGELOG</ins>

VERSION|DATE|CHANGE|AFFECTED FUNCTIONS|DESCRIPTION
----|----|----|----|----|
1.3|25/08/2015|Function Improvements|Get-IMMSubnet|Added new parameter -ExcludeIP
1.2|23/07/2015|Content-based help Improvements|ALL|".PARAMETER" tags edited
1.2|23/07/2015|Bugfix|All functions that support '-Confirm' parameter|'$IMM' variable replaced by '$module' in $PSCmdlet.ShouldProcess($module,"") method
1.1|27/05/2015|Function Improvements|Get-IMMISO, Mount-IMMISO|Added 'rdmount' running process check in the 'Begin' scope before function call
1.1|27/05/2015|Function Improvements|Set-IMMServerBootOrder|Added 'Windows Boot Manager' entry in [ValidateSet()] statement for all Boot devices
1.0|17/05/2015|Initial release|21 Functions|
