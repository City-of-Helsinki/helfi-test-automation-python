*** Settings ***
Documentation   Mainly contains some cases which do not fall under any parent paragraph like Hero, Columns. Some text,
...				links and pictures still are supported and could be tested here.
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Uncategorized.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PAGE    UNCATEGORIZED

*** Test Cases ***

Only Text
	[Tags]
	Given User Goes To New Page Site
	And User Starts Creating a New Page With Text Content  
	When User Submits The New Page
	Then Layout Should Not Have Changed

Only Picture
	[Tags]
	Given User Goes To New Page Site
	And User Starts Creating a New Page With Picture Content  
	When User Submits The New Page
	Then Layout Should Not Have Changed

Text And Picture
	[Tags]
	Given User Goes To New Page Site
	And User Starts Creating a New Page With Mixed Content  
	When User Submits The New Page
	Then Layout Should Not Have Changed

	
*** Keywords ***
User Submits The New Page
	Submit The New Page  
	
User Goes To New Page Site  Go To New Page Site
	
User Starts Creating a New Page With ${content} Content
	Start Creating a New Page With ${content} Content
	
Layout Should Not Have Changed
	Run Keyword And Ignore Error  Accept Cookies	
	Uncategorized.Take Screenshot Of Content
	Compare Two Pictures