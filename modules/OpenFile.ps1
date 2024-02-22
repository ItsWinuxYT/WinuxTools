Add-Type -as System.windows.forms
$open = New-Object Windows.Forms.OpenFileDialog
$open.initialDirectory = $pwd.path
$open.filter = "Select the game location (*.exe)|*.exe"
$open.ShowHelp = $false
[void]$open.ShowDialog()
$open.filename