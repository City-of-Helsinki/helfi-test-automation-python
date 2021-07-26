*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Remote_Video.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		ARTICLE   REMOTEVIDEO

*** Test Cases ***

One Video
	[Tags] 
	Given User Goes To New Article -Site
	And User Adds Content With 1 Remote Video(s)
	When User Submits The New Article
	Then Layout Should Not Have Changed
	And Remote Video Play Begins Correctly

Two Videos
	[Tags]
	Given User Goes To New Article -Site
	And User Adds Content With 2 Remote Video(s)
	When User Submits The New Article
	Then Layout Should Not Have Changed
	And Remote Video Play Begins Correctly
	
*** Keywords ***
User Adds Content With ${number} Remote Video(s)
	Create Page With ${number} Remote Video(s) Content

User Goes To New Article -Site		Go To New Article Site
User Submits The New Article
	Submit The New Article


Remote Video Should Work Correctly
	Remote Video Is Working Correctly
	 
Layout Should Not Have Changed
	Wait Until Keyword Succeeds  5x   200ms     Accept Cookies
	Remote_Video.Take Screenshot Of Content
	${originalpic} =  Set Variable   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_ARTICLE_REMOTEVIDEO_${number}_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Run Keyword Unless  '${TEST NAME}'=='Two Videos'   Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}   ${EMPTY}   1
	Run Keyword If  '${TEST NAME}'=='Two Videos'	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}   ${EMPTY}   93