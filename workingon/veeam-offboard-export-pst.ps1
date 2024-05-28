# Prompt user for Veeam server credentials
$VeeamServer = "<server>"


# Veeam server connection details


# Connect to Veeam server
 #$creds = Get-Credential

Connect-VBRServer -Server $VeeamServer -port 9392

# Prompt user to select a mailbox from Veeam
$SelectedMailbox = Get-VBRMailbox | Out-GridView -Title "Select a mailbox to export" -PassThru

# Export mailbox to .pst
$ExportPath = "C:\Temp\$($SelectedMailbox.DisplayName).pst"
Start-VBRMailboxRestore -Server $VeeamServer -Mailbox $SelectedMailbox -Path $ExportPath

# File share details
$FileSharePath = '\\server\sds\sds\sds\'

# Move .pst file to file share
if (-not (Test-Path $FileSharePath)) {
    New-Item -Path $FileSharePath -ItemType Directory
}
Move-Item -Path $ExportPath -Destination "$FileSharePath\$($SelectedMailbox.DisplayName).pst" -Force

# Disconnect from Veeam server
Disconnect-VBRServer -Server $VeeamServer
