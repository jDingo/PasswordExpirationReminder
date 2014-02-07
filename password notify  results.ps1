#Password Expiration Reminder
#Created By: jDingo
#Date Created:	6-17-2013

Import-Module ActiveDirectory
$UserName = get-ADUser -Filter * -Properties samAccountName, EmailAddress, PasswordLastSet | select *
$EmailFrom = "PasswordResetNotice@<#YOUR_DOMAIN#>.com"
$Subject = "Password Expiration Notification"
$x = 0
$Results= @()




foreach($User in $UserName){
	$Now = get-date

	
	if($User.PasswordLastSet){
		
		$UsernameDisplayed= $User.GivenName
		$PassExpirationDate = $User.PasswordLastSet.AddDays(60)
  		$Daystilexpire = ($PassExpirationDate - $Now | Select -ExpandProperty Days)
		if($DaysTilExpire -gt "0"){
		
			if($DaysTilExpire -le "5"){
				
				
$Body = "$UsernameDisplayed,
Your password will expire in $daystilexpire day(s).
To change your password now, please follow these steps:
		1)	Press 'Ctrl-Alt-Delete'
		2)	Select 'Change a password...'
		3)	Type in your current password
		4)	Type in your new password
		5)	Confirm your new password
						
Thank You, 
			
IT Department"


				Send-MailMessage -From $EmailFrom -To $User.EmailAddress -Subject $Subject -Body $Body -SmtpServer "10.8.24.40"
				$Results += @($User.EmailAddress)
				$x += 1
				$User.EmailAddress
        	}
		}
		
		
	}
	
}
#Results email
$Results= $Results | sort
$SubjectResults = "Password Expiration Notification Results"
$OFS = "`r`n"
$BodyResults= "Password Notification sent to $x users.
_________________________________________________________
$Results"


Send-MailMessage -From $EmailFrom -To <# YOUR_EMAIL#>  -Subject $SubjectResults -Body $BodyResults -SmtpServer "10.8.24.40"