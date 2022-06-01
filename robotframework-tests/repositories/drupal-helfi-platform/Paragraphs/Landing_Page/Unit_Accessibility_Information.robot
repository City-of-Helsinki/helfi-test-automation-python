*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Unit_Accessibility_Information.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		LANDINGPAGE   UNIT_ACCESSIBILITY_INFORMATION

*** Test Cases ***
Accessibility Information On Page
	[Tags]
	When User Goes To New LandingPage -Site
	And User Creates Accessibility Information For Unit   Otaniemen Kirjasto
	And User Submits The New LandingPage
	Then Accessibility Information Is Present


*** Keywords ***
User Goes To New LandingPage -Site		Go To New LandingPage Site
User Submits The New LandingPage	Submit The New LandingPage

User Creates Accessibility Information For Unit
	[Arguments]   ${unitname}
	Create Unit Accessibility Information For Unit   Landingpage   ${unitname}
	
Accessibility Information Is Present
	Wait Until Page Contains Element   id:esteettomyystiedot