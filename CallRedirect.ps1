<#
Non answered call redirect
Verion 0.1
OCWS
CSV file path C:\Users\deploylnc\Desktop\users.csv
#>

param([string]$userCsv = "C:\Sources\users.csv")

#User CSV loading
$usersList = $null
$usersList = Import-Csv $userCsv
$count = $usersList.count
Write-Host "User count within CSV file=" $count
Write-Host ""

foreach ($user in $usersList)
{
    if ($user.UnansweredCallForwardPolicy -match '^.\d+$') {
    SEFAUtil.exe /server:LyncSadm2.groupe.generali.fr sip:$user.SipAddress /enablefwdnoanswer /callanswerwaittime:30 /setfwddestination:$user.UnansweredCallForwardPolicy
    Write-Host "user" + $user.upn + "unanswered calls sent to" + $user.UnansweredCallForwardPolicy +  "after 30 seconds"
  }
  elseif ($user.UnansweredCallForwardPolicy -eq 'MeVo') {
      Write-Host "user" + $user.upn + "unanswered calls sent to voicemail after 30 seconds"

  }
}