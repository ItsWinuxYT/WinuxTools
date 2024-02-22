Add-Type -as System.windows.forms
$shell = New-Object -ComObject Shell.Application
$shell.BrowseForFolder( 0, 'Select a folder', 16, $shell.NameSpace( 17 ).Self.Path ).Self.Path