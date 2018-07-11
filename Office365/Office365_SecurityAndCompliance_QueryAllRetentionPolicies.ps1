$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession -Session $Session

$RetentionPolicies = Get-LabelPolicyRule
foreach($obj in $RetentionPolicies)
{
   if($obj.name -like "*ptr-*") 
   {
      $obj.name = (get-labelpolicy | ? { $_.UPELabelRules -like "*$obj" }).Name
   }
}

clear

$RetentionPolicy.name
Write-host $RetentionPolicies.Count Retention Policies found
