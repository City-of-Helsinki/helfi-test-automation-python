*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Service_List.robot
Documentation	This Paragraph requires some units and tpr_config module enabled as prerequisite.
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		LANDINGPAGE   SERVICELIST

*** Test Cases ***

One Unit
	[Tags]
	Given Service Is Published
	When User Adds Content With Service List
	Then Layout Should Not Have Changed
	And ServiceList Paragraph Works Correctly


*** Keywords ***

Service Is Published
	Publish Service With Name   Digituki
	
User Adds Content With Service List
	Go To New LandingPage Site
	Add ServiceList   LandingPage
	Submit The New Landingpage
	
Layout Should Not Have Changed
	Wait Until Keyword Succeeds  5x   200ms     Run Keyword And Ignore Error   Accept Cookies
	Take Screenshot Of Content
	${originalpic} =  Set Variable  ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_LANDINGPAGE_SERVICELIST_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData	  ${originalpic}   ${comparisonpic}
	
ServiceList Paragraph Works Correctly
	Click Link   css:.service__link
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   digituki
