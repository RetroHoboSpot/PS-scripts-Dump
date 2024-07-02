# Check if running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script! Please re-run this script as an Administrator."
    Pause
    Exit
}

# Uninstall Outlook for Windows app package for all users
try {
    Get-AppxPackage -AllUsers | Where-Object {$_.Name -like '*OutlookForWindows*'} | Remove-AppxPackage -AllUsers -ErrorAction Stop
    Write-Output "Outlook for Windows app package successfully uninstalled for all users."
} catch {
    Write-Error "Failed to uninstall Outlook for Windows app package: $_"
    Pause
    Exit 1
}

# Remove Microsoft Teams app package for all users
try {
    Get-AppxPackage -AllUsers | Where-Object {$_.Name -like 'MicrosoftTeams*'} | Remove-AppxPackage -AllUsers -ErrorAction Continue
    Write-Output "Microsoft Teams app package successfully uninstalled for all users."
} catch {
    Write-Error "Failed to uninstall Microsoft Teams app package: $_"
    Pause
    Exit 1
}

# Remove provisioned Microsoft Teams app package
try {
    Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like '*MicrosoftTeams*'} | Remove-AppxProvisionedPackage -Online -Verbose
    Write-Output "Provisioned Microsoft Teams app package successfully removed."
} catch {
    Write-Error "Failed to remove provisioned Microsoft Teams app package: $_"
    Pause
    Exit 1
}
