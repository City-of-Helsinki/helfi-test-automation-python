*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/UnitContactCard.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		LANDINGPAGE    UNITCONTACTCARD

*** Test Cases ***
Full Unit Data
	[Tags]
	Given User Goes To New LandingPage Site
	And User Creates New UnitContactCard With Full Data
	When User Submits The New LandingPage
	

No Unit Data
	[Tags]
	Given User Goes To New LandingPage Site
	And User Creates New UnitContactCard With No Data
	When User Submits The New LandingPage


*** Keywords ***
User Submits The New LandingPage
	Submit The New LandingPage  
	
User Goes To New LandingPage Site  Go To New LandingPage Site

User Creates New UnitContactCard With ${selection} Data
	Create UnitContactCard With ${selection} Data