*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Unit_Search.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		LANDINGPAGE   UNITSEARCH

*** Test Cases ***

Landingpage-Two Units
	[Tags]   CRITICAL
	When User Goes To New LandingPage -Site
	And User Starts Creating UnitSearch Paragraph
	And User Submits The New LandingPage
	Then Layout Should Not Have Changed
	And Unit Links Are Working Correctly
	And The Search Bar Is Working Correctly
	And Unit Address and Phone Data Is Correct

*** Keywords ***
	
User Starts Creating UnitSearch Paragraph
	Create Unit Search Paragraph   LandingPage
	

	
User Goes To New LandingPage -Site		Go To New LandingPage Site

User Submits The New LandingPage	Submit The New LandingPage

Layout Should Not Have Changed
	Take Screenshot Of Content
	${originalpic} =  Set Variable  ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_UNITSEARCH_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${BROWSER}_TESTRUN-${SUITE}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}