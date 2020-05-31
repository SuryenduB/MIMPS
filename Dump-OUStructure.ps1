
#Dummp OU Structure
function Get-ADOUHirearchy ([string]$dn, $level = 1)
{
    if ($level -eq 1) { $dn }
    Get-ADOrganizationalUnit -filter * -SearchBase $dn -SearchScope OneLevel | 
        Sort-Object -Property distinguishedName | 
        ForEach-Object {
            $components = ($_.distinguishedname).split(',')
            "$('--' * $level) $($components[0])"
            Get-ADOUHirearchy -dn $_.distinguishedname -level ($level+1)
        }
}

Get-ADOUHirearchy -dn (Get-ADDomain).DistinguishedName
