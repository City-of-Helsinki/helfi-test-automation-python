*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/List_Of_Plans.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PAGE   LISTOFPLANS

*** Test Cases ***

One List
	[Tags]
	Given User Goes To New Page -Site	
	When User Starts Creating Page With List Of Plans Content
	And User Submits The New Page
	Then List Of Plans Should Be Present In Page
	
*** Keywords ***
User Goes To New Page -Site		Go To New Page Site
User Submits The New Page
	Submit The New Page
	
User Starts Creating Page With List Of Plans Content
	Create List Of Plans

List Of Plans Should Be Present In Page
	list-of-plans Is Present In Page