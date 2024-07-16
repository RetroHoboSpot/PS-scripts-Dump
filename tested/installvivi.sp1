# Define the URL of the MSI package
$msiUrl = "https://api.vivi.io/windows-msi64"

# Define the path where you want to save the MSI file
$msiPath = "$env:TEMP\ViviInstaller.msi"

# Download the MSI file
Invoke-WebRequest -Uri $msiUrl -OutFile $msiPath

# Perform the silent installation
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $msiPath /quiet /qn /norestart" -Wait
