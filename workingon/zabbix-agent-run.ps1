# Prompt for user input
$ZabbixServer = Read-Host "Enter the Zabbix Server IP or hostname"
$Metadata = Read-Host "Enter host metadata (optional)"

# Download Zabbix agent MSI package
$AgentUrl = "https://cdn.zabbix.com/zabbix/binaries/stable/7.0/7.0.0/zabbix_agent2-7.0.0-windows-amd64-openssl.msi"
$AgentInstaller = "$env:TEMP\zabbix_agent.msi"

Invoke-WebRequest -Uri $AgentUrl -OutFile $AgentInstaller

# Install Zabbix agent
Start-Process msiexec.exe -ArgumentList "/i `"$AgentInstaller`" /quiet" -Wait

# Configure Zabbix agent
$ConfigFile = "C:\Program Files\Zabbix Agent 2\conf\zabbix_agent2.conf"

# Add metadata and Zabbix server IP to configuration file
@"
# Custom Host Metadata
HostMetadata=$Metadata

# Zabbix Server IP or Hostname
Server=$ZabbixServer

# Zabbix Server Active (if needed)
ServerActive=$ZabbixServer
"@ | Out-File -FilePath $ConfigFile -Force

# Restart Zabbix agent service to apply changes
Restart-Service -Name "Zabbix Agent 2"

Write-Output "Zabbix Agent 2 installation and configuration completed."
