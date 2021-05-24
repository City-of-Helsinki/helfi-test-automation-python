*** Settings ***
Resource        ../../../robotframework-keywords/platform/Paragraphs/Content_Cards.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PAGE   CONTENTCARDS



*** Test Cases ***
Small Cards
	[Tags]  CRITICAL
	Given User Goes To New Page -Site
	And User Starts Creating Page With Small Content Card For Linkkiesimerkit Content Page
	And User Adds New ContentCard For Esimerkkisivu Content
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And ContentCards Should Work Correctly
	
Large Cards
	[Tags]  
	Given User Goes To New Page -Site
	And User Starts Creating Page With Large Content Card For Linkkiesimerkit Content Page
	And User Adds New ContentCard For Esimerkkisivu Content
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And ContentCards Should Work Correctly
	
Small Grey Cards
	[Tags] 
	Given User Goes To New Page -Site
	And User Starts Creating Page With Small Grey Content Card For Linkkiesimerkit Content Page
	And User Adds New ContentCard For Esimerkkisivu Content
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And ContentCards Should Work Correctly
	
Large Grey Cards
	[Tags]
	Given User Goes To New Page -Site
	And User Starts Creating Page With Large Grey Content Card For Linkkiesimerkit Content Page
	And User Adds New ContentCard For Esimerkkisivu Content
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And ContentCards Should Work Correctly
	
*** Keywords ***
User Starts Creating Page With ${cardsize} Content Card For ${contentname} Content Page
	Create Page With ${cardsize} Cards For ${contentname} Content	
	
User Adds New ContentCard For ${contentname} Content
	Add New ContentCard For ${contentname} Content

ContentCards Should Work Correctly
	ContentCards Are Working Correctly
	
User Goes To New Page -Site		Go To New Page Site
User Submits The New Page
	Submit The New Page
	
User Opens Created Content
	 Open Created Content
	 Take Screenshot Of Content
	 
Layout Should Not Have Changed
	${originalpic} =  Set Variable   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_PAGE_CONTENTCARDS_${cardsize}_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}