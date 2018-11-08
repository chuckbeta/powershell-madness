#Needed a way to grab all the DNS client settings on the DCs for a project where we were moving external DNS providers
#The ops team was still logging into servers to grab the config and the SCCM team was using wmi calls
#The below worked to get the info required. Problem was I didn't have permissions across entire forest, so needed to run on 
#root domain

#Gets all DCs in Forest
$Forest = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest()

#Saves to Variable
$dc = $Forest.Sites | % { $_.Servers } | Select Name,Domain

#Queries each DC for DNS Server
$dc | ForEach-Object {Invoke-Command -ComputerName $_.SamAccountName -ScriptBlock {Get-NetAdapter | Get-DnsClientServerAddress}} | Select-Object -Property PSComputerName,ServerAddresses | Where-Object {$_.ServerAddresses -ne ''} | export-csv .\dc_dnssettings.csv -nti
