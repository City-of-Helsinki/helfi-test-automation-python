*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Content_Cards.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		ARTICLE   CONTENTCARDS



*** Test Cases ***
Small Cards
	[Tags]  CRITICAL
	Given User Goes To New Article Site
	And User Starts Creating Article With Small Content Card For Link examples Content Page
	And User Adds New ContentCard For Esimerkkisivu Content
	When User Submits The New Article
	Then Layout Should Not Have Changed
	And ContentCards Should Work Correctly
	
Large Cards
	[Tags]  
	Given User Goes To New Article Site
	And User Starts Creating Article With Large Content Card For Link examples Content Page
	And User Adds New ContentCard For Esimerkkisivu Content
	When User Submits The New Article
	Then Layout Should Not Have Changed
	And ContentCards Should Work Correctly
	
Small Grey Cards
	[Tags] 
	Given User Goes To New Article Site
	And User Starts Creating Article With Small Grey Content Card For Link examples Content Page
	And User Adds New ContentCard For Esimerkkisivu Content
	When User Submits The New Article
	Then Layout Should Not Have Changed
	And ContentCards Should Work Correctly
	
Large Grey Cards
	[Tags]
	Given User Goes To New Article Site
	And User Starts Creating Article With Large Grey Content Card For Link examples Content Page
	And User Adds New ContentCard For Esimerkkisivu Content
	When User Submits The New Article
	Then Layout Should Not Have Changed
	And ContentCards Should Work Correctly
	
*** Keywords ***
User Starts Creating Article With ${cardsize} Content Card For ${contentname} Content Page
	Create Article With ${cardsize} Cards For ${contentname} Content	
	
User Adds New ContentCard For ${contentname} Content
	Add New ContentCard For ${contentname} Content

ContentCards Should Work Correctly
	ContentCards Are Working Correctly
	
User Goes To New Article Site  Go To New Article Site
User Submits The New Article
	Submit The New Article
	 
Layout Should Not Have Changed
	Wait Until Keyword Succeeds  5x   200ms     Accept Cookies
	Take Screenshot Of Content
	${originalpic} =  Set Variable   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_LANDINGPAGE_CONTENTCARDS_${cardsize}_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}