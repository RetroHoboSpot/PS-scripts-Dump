# Function to check if the script is running as admin and relaunch if not
function Ensure-RunAsAdmin {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Output "Restarting script with administrative privileges..."
        Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        Exit
    }
}

# Ensure the script is running as admin
Ensure-RunAsAdmin

# Function to install Chocolatey
function Install-Chocolatey {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Output "Chocolatey installed successfully."
}

# Install Chocolatey if not already installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Install-Chocolatey
} else {
    Write-Output "Chocolatey is already installed."
}

# Install packages using Chocolatey
$packages = @(
    "vlc",
    "adobereader",
    "winrar",
    "microsoft-teams.install",
    "microsoft-edge"
    # Add more package names here
)

foreach ($package in $packages) {
    choco install $package -y
    if ($?) {
        Write-Output "$package installed successfully."
    } else {
        Write-Output "Failed to install $package."
    }
}

Write-Output "Holy Cow it worked!."
