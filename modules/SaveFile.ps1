Add-Type -as System.windows.forms
$save = New-Object Windows.Forms.SaveFileDialog
$save.initialDirectory = $pwd.path
$save.filter = "Backup packages (*.zip)|*.zip"
$save.ShowHelp = $false
[void]$save.ShowDialog()
$save.filename