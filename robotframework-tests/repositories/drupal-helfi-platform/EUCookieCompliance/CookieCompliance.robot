*** Settings ***
Documentation   For these testcases to work, 'helfi_example_content' should be enabled.
Resource        ../../../../robotframework-keywords/platform/Others/CookieCompliance.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser
Force Tags		COOKIECOMPLIANCE

*** Test Cases ***
Essential Cookies
	[Tags]
	Given User Opens Content With Title Esimerkkisivu
	When User Accepts Essential Cookies
	Then Essential Cookies Are Created	

All Cookies
	[Tags]
	Given User Opens Content With Title Esimerkkisivu
	When User Accepts All Cookies
	Then All Cookies Are Created




*** Keywords ***

User Opens Content With Title ${contenttitle}
    Go To   ${URL_content_page}
    Wait Until Keyword Succeeds  5x   200ms   Click Link   ${contenttitle}

User Accepts ${selection} Cookies
	Accept ${selection} Cookies
	
${consent_option} Cookies Are Created 
		${cookies}=   Get All Currently Used Cookies
		${agreed}=  Get From Dictionary   ${cookies}   cookie-agreed-categories
		Log  ${consent_option}
		${consent_option}=   Remove String   ${consent_option}   Then
		${consent_option}=   Strip String   ${consent_option}
		IF    '${consent_option}'=='Essential'
        	Should Be Equal   ${agreed}     ["essential"]
    	ELSE
    		Should Be Equal   ${agreed}     ["essential","performance_ux"]
   		END