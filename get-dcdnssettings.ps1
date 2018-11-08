#Gets all DCs in Forest
$Forest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()

#Saves to Variable
$dc = $Forest.Sites | % { $_.Servers } | Select Name,Domain

#Queries each DC for DNS Server
$dc | ForEach-Object {Invoke-Command -ComputerName $_.SamAccountName -ScriptBlock {Get-NetAdapter | Get-DnsClientServerAddress}} | Select-Object -Property PSComputerName,ServerAddresses | Where-Object {$_.ServerAddresses -ne ''}
