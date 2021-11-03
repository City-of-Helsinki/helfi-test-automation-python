*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Unit_Search.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PAGE   UNITSEARCH

*** Test Cases ***

Two Units
	[Tags]
	Given Units Are Published
	When User Goes To New Page -Site
	And User Starts Creating UnitSearch Paragraph
	And User Submits The New Page
	Then Layout Should Not Have Changed
	And Unit Links Are Working Correctly
	And The Search Bar Is Working Correctly
	And Unit Address and Phone Data Is Correct

*** Keywords ***

Units Are Published
	Publish Unit With Name   Lippulaivan kirjasto
	Publish Unit With Name   Otaniemen kirjasto
	
User Starts Creating UnitSearch Paragraph
	Create Unit Search Paragraph   Page
	

	
User Goes To New Page -Site		Go To New Page Site

User Submits The New Page	Submit The New Page

Layout Should Not Have Changed
	Take Screenshot Of Content
	${originalpic} =  Set Variable  ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_UNITSEARCH_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}