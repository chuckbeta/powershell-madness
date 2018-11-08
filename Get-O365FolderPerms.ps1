#I started working on this script to try and get O365 folder permissions programatically
#This is a work in progress

$includedfolders = @("Root","Inbox","Calendar", "Contacts", "DeletedItems", "Drafts", "JunkEmail", "Journal", "Notes", "Outbox", "SentItems", "Tasks", "Clutter", "Archive")

$excludedfolders = @("News Feed","Quick Step Settings","Social Activity Notifications","Suggested Contacts", "SearchDiscoveryHoldsUnindexedItemFolder", "SearchDiscoveryHoldsFolder")

Import Mailboxes

$mbx = import-csv file.csv

$mbx | foreach {Get-MailboxFolderStatistics $using:MBSMTP | Select-Object Name,FolderType,Identity} | export-csv mbxfolders.csv -nti

$mbxfolders = import-csv mbxfolders.csv

$mbxfolders | ? {($_.FolderType -eq "User created" -or $_.FolderType -in $includedfolders) -and ($_.Name -notin $excludedfolders)} | export-csv mbxfoldersclean.csv -nti

$cleanfolders = import-csv mbxfoldersclean.csv

$foldername = $cleanfolders.Identity.ToString().Replace([char]63743,"/").Replace($_.identity,$Identity + ":")

$cleanfolders | foreach { Get-MailboxFolderPermission -Identity $_.Identity}


$Perms = Get-ManagementRole -Cmdlet 'get-mailboxpermission'

$Perms | foreach {Get-ManagementRoleAssignment -Role $_.Name -Delegating $false | Format-Table -Auto Role,RoleAssigneeType,RoleAssigneeName}
