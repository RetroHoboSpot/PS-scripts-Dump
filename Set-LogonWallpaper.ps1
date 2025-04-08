# Set the path to the image
$ImagePath = "C:\PATH-TO-IMG"

# Ensure the image exists
if (!(Test-Path $ImagePath)) {
    Write-Host "Image file not found at $ImagePath"
    exit
}

# Set registry key to enable custom lock screen image
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Create the registry key if it doesn't exist
if (!(Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Set the registry value for lock screen image
Set-ItemProperty -Path $RegistryPath -Name "LockScreenImage" -Value $ImagePath

# Optional: Disable fun facts, tips, and more on the lock screen
Set-ItemProperty -Path $RegistryPath -Name "NoLockScreen" -Value 1 -Type DWord

Write-Host "Lock screen wallpaper set to $ImagePath"
