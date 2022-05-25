*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Events.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		EVENTS   PAGE

*** Test Cases ***
Event List
	[Tags]
	Given User Goes To New Page -Site
	And User Starts Creating Page With Event List Content
	When User Submits The New Page
	Then Event List Should Be Present In Page
	

	
	
*** Keywords ***
User Goes To New Page -Site		Go To New Page Site
User Submits The New Page
	Submit The New Page
	
User Starts Creating Page With Event List Content
	Create Event   Page

Event List Should Be Present In Page
	Events Are Present In Page