*** Settings ***
Documentation   For these testcases to work, 'helfi_example_content' should be enabled.
Resource        ../../../../robotframework-keywords/platform/Others/CookieCompliance.robot
Test Setup      Resolve Login
Test Teardown   Cleanup and Close Browser
Force Tags		COOKIECOMPLIANCE

*** Test Cases ***
Essential Cookies
	[Tags]
	When User Accepts Essential Cookies
	Then Essential Cookies Are Created	

All Cookies
	[Tags]
	When User Accepts All Cookies
	Then All Cookies Are Created




*** Keywords ***
User Opens Content With Title ${contenttitle}
    Go To   ${URL_content_page}
    Search And Click Content From Content Pages   ${contenttitle}

User Accepts ${selection} Cookies
	Run Keyword Unless   (${CI}) | (${CI_LOCALTEST})  User Opens Content With Title Esimerkkisivu
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
    		Should Be Equal   ${agreed}     ["essential","preference","statistics","marketing"]
   		END
