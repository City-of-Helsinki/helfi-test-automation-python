*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Map.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PAGE   MAP



*** Test Cases ***
Kartta Map
	[Tags]  CRITICAL
	Given User Goes To New Page -Site
	User Adds Map Using kartta.hel.fi Map Location
	When User Submits The New Page
	Then Layout Should Not Have Changed
	And Map Paragraph Works Correctly
	
Palvelukartta Map
	[Tags]  CRITICAL
	Given User Goes To New Page -Site
	User Adds Map Using palvelukartta.hel.fi Map Location
	When User Submits The New Page
	Then Layout Should Not Have Changed
	And Map Paragraph Works Correctly
	
*** Keywords ***

User Goes To New Page -Site		Go To New Page Site
User Submits The New Page
	Sleep   3
	Submit The New Page
	
User Adds Map Using ${source} Map Location
	IF    ('${source}'=='kartta.hel.fi')
        Create Map With Given Url   https://kartta.hel.fi/#
    ELSE
    	Create Map With Given Url   https://palvelukartta.hel.fi/fi/?lat=60.173294226551846&lon=24.93106842041016
    END 
	 
Layout Should Not Have Changed
	Wait Until Keyword Succeeds  5x   200ms   Accept Cookies
	Sleep  4
	Take Screenshot Of Content
	${originalpic} =  Set Variable   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_GALLERY_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}	 