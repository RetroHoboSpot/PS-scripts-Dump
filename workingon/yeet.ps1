
# Function to check and elevate to Administrator if needed
function Check-Admin {
    param(
        [switch]$Quiet
    )

    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

    if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        if (-not $Quiet) {
            Write-Warning "You do not have Administrator rights. Attempting to elevate..."
        }

        # Create new process that runs PowerShell as Administrator
        $newProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell"
        $newProcess.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
        $newProcess.Verb = "RunAs"

        # Start the new process
        [System.Diagnostics.Process]::Start($newProcess)

        # Exit the current script
        Exit
    }
}

# Call the function to check and elevate to Administrator if needed
Check-Admin -Quiet

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
