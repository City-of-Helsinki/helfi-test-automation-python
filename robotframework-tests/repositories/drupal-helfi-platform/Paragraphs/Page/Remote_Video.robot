*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Remote_Video.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PAGE   REMOTEVIDEO

*** Test Cases ***

One Video
	[Tags]   CRITICAL
	Given User Goes To New Page -Site
	And User Adds Content With 1 Remote Video(s)
	When User Submits The New Page
	Then Layout Should Not Have Changed
	#And Remote Video Play Begins Correctly

Two Videos
	[Tags]
	Given User Goes To New Page -Site
	And User Adds Content With 2 Remote Video(s)
	When User Submits The New Page
	Then Layout Should Not Have Changed
	#And Remote Video Play Begins Correctly
	
*** Keywords ***
User Adds Content With ${number} Remote Video(s)
	Create Page With ${number} Remote Video(s) Content

User Goes To New Page -Site		Go To New Page Site
User Submits The New Page
	Submit The New Page

Layout Should Not Have Changed
	Run Keyword And Ignore Error  Accept Cookies
	Remote_Video.Take Screenshot Of Content
	${originalpic} =  Set Variable   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_PAGE_REMOTEVIDEO_${number}_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE}-${TEST NAME}_${language}.png
	Run Keyword Unless  '${TEST NAME}'=='Two Videos'   Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}   ${EMPTY}   2
	Run Keyword If  '${TEST NAME}'=='Two Videos'	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}   ${EMPTY}   93