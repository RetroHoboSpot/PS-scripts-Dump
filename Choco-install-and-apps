# Install Chocolatey
#installs choco and the below apps 
#spot 
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install packages using Chocolatey
$packages = @(
    "VLC",
    "adobereader",
    "winrar",
    "microsoft-teams.install",
    "microsoft-edge"  #last Item
    # Add more package names here
)

foreach ($package in $packages) {
    choco install $package -y
}
