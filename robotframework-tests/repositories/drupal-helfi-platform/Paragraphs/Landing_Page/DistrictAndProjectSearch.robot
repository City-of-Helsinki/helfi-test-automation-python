*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/DistrictAndProjectSearch.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		LANDINGPAGE   DISTRICTANDPROJECTSEARCH

*** Test Cases ***
Landingpage- One Item
	[Tags]  CRITICAL
	Given User Goes To New Landingpage -Site
	And User Starts Creating New District And Project Search
	When User Submits The New Landingpage
	Then Paragraph Content Is Present On Page

	
	
*** Keywords ***
User Goes To New Landingpage -Site		Go To New LandingPage Site
User Submits The New Landingpage
	Submit The New Landingpage
	
User Starts Creating New District And Project Search
	Create New District And Project Search Paragraph   Landingpage
	
Paragraph Content Is Present On Page
	district-and-project-search Is Present In Page
	Element Should Be Visible  css:.component__title   timeout=3
	Element Should Be Visible  css:.component__description   timeout=3