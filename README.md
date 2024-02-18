# ![cover](https://cloud.githubusercontent.com/assets/6964549/21469926/c1dded38-ca78-11e6-961f-e89d4acffa68.png)$${\color{blue}IMM-Module}$$

### [<ins>PowerShell module for IBM/LENOVO servers management</ins>](https://ps1code.com/2015/08/11/imm-module)

To install this module, drop the entire `IMM-Module` folder into one of your module directories

The default PowerShell module paths are listed in the `$env:PSModulePath` environment variable

To make it look better, split the paths in this manner: `$env:PSModulePath -split ';'`

The default per-user module path is: `"$env:HOMEDRIVE$env:HOMEPATH\Documents\WindowsPowerShell\Modules"`

The default computer-level module path is: `"$env:windir\System32\WindowsPowerShell\v1.0\Modules"`

To use the module, type following command: `Import-Module IMM-Module -Force -Verbose`

To get the module version type following command: `Get-Module -ListAvailable |? {$_.Name -eq 'IMM-Module'}`

To see the commands imported, type `Get-Command -Module IMM-Module`

For help on each individual cmdlet or function, run `Get-Help CmdletName -Full [-Online][-Examples]`

##### <ins>IMM-Module CHANGELOG</ins>

VERSION|DATE|CHANGE|AFFECTED FUNCTIONS|DESCRIPTION
----|----|----|----|----|
1.5|21/11/2017|Function Improvements|Get-IMMSystemEventLogEntry|Changed data type of `Num` and `Date` properties
1.4|22/12/2016|New Function and Bugfixes|ALL|Added new function `Get-IMMSupervisorCred`
1.3|25/08/2015|Function Improvements|Get-IMMSubnet|Added new parameter `-ExcludeIP`
1.2|23/07/2015|Content-based help Improvements|ALL|`.PARAMETER` tags edited
1.2|23/07/2015|Bugfix|All functions that support `-Confirm` parameter|`$IMM` variable replaced by `$module` in `$PSCmdlet.ShouldProcess($module,"")` method
1.1|27/05/2015|Function Improvements|Get-IMMISO, Mount-IMMISO|Added `rdmount` running process check in the `Begin` scope before function call
1.1|27/05/2015|Function Improvements|Set-IMMServerBootOrder|Added `Windows Boot Manager` entry in `[ValidateSet()]` statement for all Boot devices
1.0|17/05/2015|Release||
