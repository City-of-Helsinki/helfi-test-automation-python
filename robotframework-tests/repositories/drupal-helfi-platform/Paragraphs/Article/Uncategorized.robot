*** Settings ***
Documentation   Mainly contains some cases which do not fall under any parent paragraph like Hero, Columns. Some text,
...				links and pictures still are supported and could be tested here.
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Uncategorized.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		ARTICLE   UNCATEGORIZED

*** Test Cases ***

Only Text
	[Tags]
	Given User Goes To New Article Site
	And User Starts Creating a New Article With Text Content  
	When User Submits The New Article
	Then Layout Should Not Have Changed

Only Picture
	[Tags]  
	Given User Goes To New Article Site
	And User Starts Creating a New Article With Picture Content  
	When User Submits The New Article
	Then Layout Should Not Have Changed

Text And Picture
	[Tags]
	Given User Goes To New Article Site
	And User Starts Creating a New Article With Mixed Content  
	When User Submits The New Article
	Then Layout Should Not Have Changed

	
*** Keywords ***
User Submits The New Article
	Submit The New Article  
	
User Goes To New Article Site  Go To New Article Site
	
User Starts Creating a New Article With ${content} Content
	Start Creating a New Article With ${content} Content
	
Layout Should Not Have Changed
	Wait Until Keyword Succeeds  5x   200ms     Accept Cookies
	Uncategorized.Take Screenshot Of Content
	${originalpic} =  Set Variable   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_${content}_ARTICLE_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}