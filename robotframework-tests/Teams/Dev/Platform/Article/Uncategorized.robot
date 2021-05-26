*** Settings ***
Documentation   Mainly contains some cases which do not fall under any parent paragraph like Hero, Columns. Some text,
...				links and pictures still are supported and could be tested here.
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Uncategorized.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		ARTICLE

*** Test Cases ***

Only Text
	[Tags] 
	Given User Goes To New Article Site
	And User Starts Creating a New Article With Text Content  
	When User Submits The New Article
	And User Opens Created Content
	Then Layout Should Not Have Changed

Only Picture
	[Tags]  
	Given User Goes To New Article Site
	And User Starts Creating a New Article With Picture Content  
	When User Submits The New Article
	And User Opens Created Content
	Then Layout Should Not Have Changed

Text And Picture
	[Tags]
	Given User Goes To New Article Site
	And User Starts Creating a New Article With Mixed Content  
	When User Submits The New Article
	And User Opens Created Content
	Then Layout Should Not Have Changed

	
*** Keywords ***
User Opens Created Content
	 Open Created Content
	 Uncategorized.Take Screenshot Of Content
	

User Submits The New Article
	Submit The New Article  
	
User Goes To New Article Site  Go To New Article Site
	
User Starts Creating a New Article With ${content} Content
	Start Creating a New Article With ${content} Content
	
Layout Should Not Have Changed
	${originalpic} =  Set Variable   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_${content}_ARTICLE_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Copy Original Screenshot To Reports Folder   ${originalpic}
	Compared Pictures Match   ${originalpic}    ${comparisonpic}