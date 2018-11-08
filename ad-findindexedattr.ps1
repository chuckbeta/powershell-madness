#You won't believe how often this is needed, damn audit teams.

Import-Module ActiveDirectory
Write-Host "Tuple Index Enabled Attributes"
Get-ADObject -SearchBase ((Get-ADRootDSE).schemaNamingContext)  -SearchScope OneLevel -LDAPFilter "(searchFlags:1.2.840.113556.1.4.803:=32)" -Property objectClass, name, whenChanged,  whenCreated, LDAPDisplayNAme  | Out-GridView
Write-Host "ANR Enabled Attributes"
Get-ADObject -SearchBase ((Get-ADRootDSE).schemaNamingContext)  -SearchScope OneLevel -LDAPFilter "(searchFlags:1.2.840.113556.1.4.803:=4)" -Property objectClass, name, whenChanged,  whenCreated, LDAPDisplayNAme | Out-GridView
Write-Host "Indexed Enabled Attributes"
Get-ADObject -SearchBase ((Get-ADRootDSE).schemaNamingContext)  -SearchScope OneLevel -LDAPFilter "(searchFlags:1.2.840.113556.1.4.803:=1)" -Property objectClass, name, whenChanged,  whenCreated, LDAPDisplayNAme  | Out-GridView
