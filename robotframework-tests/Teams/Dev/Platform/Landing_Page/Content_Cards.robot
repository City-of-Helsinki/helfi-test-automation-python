*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Content_Cards.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		LANDINGPAGE   CONTENTCARDS

*** Test Cases ***
Small Cards
	[Tags]  CRITICAL
	Given User Goes To New LandingPage Site
	And User Starts Creating Landingpage With Small Content Card For Linkkiesimerkit Content Page
	And User Adds New ContentCard For Esimerkkisivu Content
	When New Landingpage is Submitted
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And ContentCards Should Work Correctly
	
Large Cards
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating Landingpage With Large Content Card For Linkkiesimerkit Content Page
	And User Adds New ContentCard For Esimerkkisivu Content
	When New Landingpage is Submitted
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And ContentCards Should Work Correctly
	
Small Grey Cards
	[Tags]
	Given User Goes To New LandingPage Site
	And User Starts Creating Landingpage With Small Grey Content Card For Linkkiesimerkit Content Page
	And User Adds New ContentCard For Esimerkkisivu Content
	When New Landingpage is Submitted
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And ContentCards Should Work Correctly
	
Large Grey Cards
	[Tags]
	Given User Goes To New LandingPage Site
	And User Starts Creating Landingpage With Large Grey Content Card For Linkkiesimerkit Content Page
	And User Adds New ContentCard For Esimerkkisivu Content
	When New Landingpage is Submitted
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And ContentCards Should Work Correctly
	
*** Keywords ***
User Starts Creating Landingpage With ${cardsize} Content Card For ${contentname} Content Page
	Create Landingpage With ${cardsize} Cards For ${contentname} Content	
	
User Adds New ContentCard For ${contentname} Content
	Add New ContentCard For ${contentname} Content

ContentCards Should Work Correctly
	ContentCards Are Working Correctly
	
User Goes To New LandingPage Site   Go To New LandingPage Site
New Landingpage is Submitted	Submit The New Landingpage
	
User Opens Created Content
	 Open Created Content
	 Take Screenshot Of Content
	 
Layout Should Not Have Changed
	${originalpic} =  Set Variable   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_LANDINGPAGE_CONTENTCARDS_${cardsize}_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}
 