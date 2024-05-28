# Define the function to install Chocolatey
function Install-Chocolatey {
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
    Write-Output "Chocolatey installed successfully."
}

# Define the function to install specific Chocolatey applications
function Install-ChocoApps {
    param (
        [string[]]$apps
    )
    foreach ($app in $apps) {
        choco install $app -y
        if ($?) {
            Write-Output "$app installed successfully."
        } else {
            Write-Output "Failed to install $app."
        }
    }
}

# Define the function to upgrade all installed Chocolatey applications
function Upgrade-AllChocoApps {
    choco upgrade all -y
    if ($?) {
        Write-Output "All applications upgraded successfully."
    } else {
        Write-Output "Failed to upgrade some applications."
    }
}

# Main menu
function Main-Menu {
    Clear-Host
    Write-Output "Chocolatey Management Script"
    Write-Output "1. Install Chocolatey"
    Write-Output "2. Install Chocolatey Applications"
    Write-Output "3. Upgrade All Installed Applications"
    Write-Output "4. Exit"
    
    $choice = Read-Host "Please select an option (1-4)"

    switch ($choice) {
        1 {
            Install-Chocolatey
        }
        2 {
            $apps = Read-Host "Enter the applications to install (comma separated)"
            $appList = $apps -split ","
            Install-ChocoApps -apps $appList
        }
        3 {
            Upgrade-AllChocoApps
        }
        4 {
            Write-Output "Exiting script."
            Exit
        }
        default {
            Write-Output "Invalid selection. Please try again."
            Main-Menu
        }
    }
}

# Run the main menu
Main-Menu
