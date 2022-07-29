*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/UnitContactCard.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PAGE    UNITCONTACTCARD

*** Test Cases ***
Full Unit Data
	[Tags]
	Given User Goes To New Page Site
	And User Creates New UnitContactCard With Full Data
	When User Submits The New Page
	

No Unit Data
	[Tags]
	Given User Goes To New Page Site
	And User Creates New UnitContactCard With No Data
	When User Submits The New Page


*** Keywords ***
User Submits The New Page
	Submit The New Page  
	
User Goes To New Page Site  Go To New Page Site

User Creates New UnitContactCard With ${selection} Data
	Create UnitContactCard With ${selection} Data