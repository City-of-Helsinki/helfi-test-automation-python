*** Settings ***
Documentation   Tests login and logout process in different environments and instances.
Library           SeleniumLibrary
Library           OperatingSystem
Force Tags   LOGIN
Suite Setup   Open Browser  browser=${BROWSER}
Suite Teardown   Close Browser

*** Variables ***
@{INSTANCES}	kaupunkiymparisto-ja-liikenne
#...				sosiaali-ja-terveyspalvelut
#...				asuminen
#...				kasvatus-ja-koulutus
#...				kulttuuri-ja-vapaa-aika
#...				yritykset-ja-tyo
#...				paatoksenteko-ja-hallinto

*** Test Cases ***
#Login With Tunnistamo In Test Environment
#	Login User   test
#	Logout User  

Login And Logout With Tunnistamo In Stage Environment
	Login And Logout User   staging

*** Keywords ***

Login And Logout User
	[Documentation]   Logs in and out in every instance listed on this page.
	[Arguments]   ${environment}
	FOR    ${INSTANCE}    IN    @{INSTANCES}
		Login User   ${environment}    ${INSTANCE}
		Logout User   ${environment}    ${INSTANCE}
	END
	

Login User
	[Arguments]    ${environment}   ${INSTANCE}
	Go To   https://www.hel.fi/fi/${environment}-${INSTANCE}/user/login
	Wait Until Keyword Succeeds  5x   200ms   Click Button   css:#edit-openid-connect-client-tunnistamo-login
	Wait Until Keyword Succeeds  5x   200ms   Input Text      css:#userNameInput   helsinki1\\test-drupal
	Set Log Level    NONE
	Wait Until Keyword Succeeds  5x   200ms   Input Text      css:#passwordInput   %{TUNNISTAMO_PASSWORD}   
	Set Log Level    INFO
	Wait Until Keyword Succeeds  5x   200ms   Click Element   css:#submitButton
	Wait Until Keyword Succeeds  5x   400ms   Page Should Contain Link   css:a[href*="/user/logout"]

	
	
Logout User
	[Arguments]    ${environment}   ${INSTANCE}  
	Go To   https://www.hel.fi/fi/${environment}-${INSTANCE}/user/logout
	Wait Until Keyword Succeeds  5x   400ms   Page Should Not Contain Link   css:a[href*="/user/logout"]
	
Accept Cookies
	Wait Until Keyword Succeeds  6x  400ms  Click Button  //button[@class='agree-button eu-cookie-compliance-default-button hds-button hds-button--primary']