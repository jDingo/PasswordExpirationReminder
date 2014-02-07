Added to GitHub: 2/7/2014

This powershell script pulls the date of the last time a user changed his/her password from Active Directory.
There is a 5 day warning period where it will send an email to the account notifying them to change passwords.  

The file should be set to run in Task Scheduler.  

**SETUP**
1) Insert your domain address for the $EmailFrom variable in line 7
2) Replace the comment in line 63 with your email address so that you will receive the results.
3) Replace the comment in line 43 and 63 with your SMTP Server address



Questions or recommendations, email me at jsagan423@gmail.com
