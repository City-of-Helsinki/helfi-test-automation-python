*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***
Accept ${selection} Cookies
	IF    '${selection}'=='Essential'
        Wait Until Keyword Succeeds  5x   200ms   Accept Essential Cookies
    ELSE
    	Wait Until Keyword Succeeds  5x   200ms   Accept All Cookies
    END
	
Get All Currently Used Cookies
	${cookies}=   Get Cookies   as_dict=True
	[Return]   ${cookies}

Accept All Cookies
	Wait Until Keyword Succeeds  6x  400ms  Click Button  //button[@class='agree-button eu-cookie-compliance-default-button hds-button hds-button--primary']	

Accept Essential Cookies
	Wait Until Keyword Succeeds  6x  400ms  Click Button  //button[@class='eu-cookie-compliance-save-preferences-button hds-button hds-button--secondary']
	
Resolve Login
	IF    (${CI}) | (${CI_LOCALTEST})
        Open Browser  ${URL_login_page}  ${BROWSER}
    ELSE
    	Login And Go To Content Page
    END
	