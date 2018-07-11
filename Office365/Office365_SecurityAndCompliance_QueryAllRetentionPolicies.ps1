$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession -Session $Session



$RetentionComplianceRule = Get-RetentionComplianceRule
foreach($obj in $RetentionComplianceRule)
{
   if($obj.name -like "*ptr-*") 
   {
      $obj.name = (get-labelpolicy | ? { $_.UPELabelRules -like "*$obj" }).Name
   }
}

clear

$RetentionComplianceRule.name
Write-host $RetentionComplianceRule.Count Retention Policies found
Write-host 'Use variable "$RetentionComplianceRule" to see more configuration settings'
