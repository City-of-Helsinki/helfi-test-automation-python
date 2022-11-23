*** Settings ***
Documentation   Tests login and logout process in different environments and instances.
Library           SeleniumLibrary
Library           OperatingSystem
Force Tags   LOGIN

*** Variables ***
@{INSTANCES}	etusivu
...				sosiaali-ja-terveyspalvelut
...				asuminen
...				kasvatus-ja-koulutus
...				kulttuuri-ja-vapaa-aika
...				yritykset-ja-tyo
...				paatoksenteko-ja-hallinto
...				kaupunkiymparisto-ja-liikenne

*** Test Cases ***

Login And Logout With Tunnistamo In Stage Environment
	Login And Logout User   staging

Login And Logout With Tunnistamo In Test Environment
	Login And Logout User   test

Login And Logout With Tunnistamo In Production Environment
	Login And Logout User

*** Keywords ***

Login And Logout User
	[Documentation]   Logs in and out in every instance listed on this page.
	[Arguments]   ${environment}=${EMPTY}
	FOR    ${INSTANCE}    IN    @{INSTANCES}
		Open Browser  browser=${BROWSER}
		Login User   ${environment}    ${INSTANCE}
		Logout User   ${environment}    ${INSTANCE}
		Close Browser
	END
	

Login User
	[Arguments]    ${environment}   ${INSTANCE}
	IF   ('${environment}'=='${EMPTY}')&('${INSTANCE}'!='etusivu')	# PRODUCTION URLS
		Go To   https://www.hel.fi/fi/${environment}${INSTANCE}/user/login
	ELSE IF   ('${environment}'=='${EMPTY}')&('${INSTANCE}'=='etusivu')		# ETUSIVU PRODUCTION URL
		Go To   https://www.hel.fi/fi/user/login
	ELSE
		Go To   https://www.hel.fi/fi/${environment}-${INSTANCE}/user/login
	END	
	
	Wait Until Keyword Succeeds  5x   200ms   Click Button   css:#edit-openid-connect-client-tunnistamo-login
	Run Keyword And Ignore Error   Accept Cookies
	Run Keyword And Ignore Error    Wait Until Keyword Succeeds  2x   500ms   Input Text   name:loginfmt   test-drupal@hel.fi
	Wait Until Keyword Succeeds  5x   400ms   Press Next -Button         
	Wait Until Keyword Succeeds  10x   500ms   Input Text      css:#userNameInput   helsinki1\\test-drupal
	Set Log Level    NONE
	Wait Until Keyword Succeeds  5x   200ms   Input Text      css:#passwordInput   %{TUNNISTAMO_PASSWORD}   
	Set Log Level    INFO
	Wait Until Keyword Succeeds  5x   200ms   Click Element   css:#submitButton
	Run Keyword And Ignore Error    Wait Until Keyword Succeeds  2x   500ms   Click Element   css:#idBtn_Back
	Wait Until Keyword Succeeds  5x   400ms   Page Should Contain Link   css:a[href*="/user/logout"]

Press Next -Button
	Run Keyword And Ignore Error    Click Element   css:#idSIButton9
	Wait Until Keyword Succeeds  5x   400ms   Page Should Not Contain Button   css:#idSIButton9

Accept Cookies
	Wait Until Keyword Succeeds  6x  400ms  Click Button  //button[@class='agree-button eu-cookie-compliance-default-button hds-button hds-button--secondary']
	
Logout User
	[Arguments]    ${environment}   ${INSTANCE} 
	${drupal_page}=   Get Location
	IF   ('${environment}'=='${EMPTY}')&('${INSTANCE}'!='etusivu')	# PRODUCTION URLS
		Go To   https://www.hel.fi/fi/${environment}${INSTANCE}/user/logout
	ELSE IF   ('${environment}'=='${EMPTY}')&('${INSTANCE}'=='etusivu')		# ETUSIVU PRODUCTION URL
		Go To   https://www.hel.fi/fi/user/logout
	ELSE
		Go To   https://www.hel.fi/fi/${environment}-${INSTANCE}/user/logout
	END	
	Run Keyword And Ignore Error    Wait Until Keyword Succeeds  5x   200ms   Click Element  css:#tilesHolder > div > div > div
	Go To   ${drupal_page}
	Wait Until Keyword Succeeds  5x   400ms   Page Should Not Contain Link   css:a[href*="/user/logout"]
