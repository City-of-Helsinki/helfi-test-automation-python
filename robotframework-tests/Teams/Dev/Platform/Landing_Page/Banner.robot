*** Settings ***
Documentation   Testing Banner paragraph in landing page content type
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Banner.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser
Force Tags		LANDINGPAGE   BANNER

*** Test Cases ***
Left Aligned Banner With Fullcolor Link
	[Tags]  CRITICAL
	Given User Goes To New LandingPage Site
	And User Starts Creating Left Aligned Banner With Fullcolor Link
	When New Landingpage is Submitted
	And User Opens Created Content	
	Then Layout Should Not Have Changed

Left Aligned Banner With Transparent Link
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating Left Aligned Banner With Transparent Link
	When New Landingpage is Submitted
	And User Opens Created Content	
	Then Layout Should Not Have Changed
	
Left Aligned Banner With Framed Link
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating Left Aligned Banner With Framed Link
	When New Landingpage is Submitted
	And User Opens Created Content	
	Then Layout Should Not Have Changed	

Center Aligned Banner With Fullcolor Link
	[Tags]  CRITICAL
	Given User Goes To New LandingPage Site
	And User Starts Creating Center Aligned Banner With Fullcolor Link
	When New Landingpage is Submitted
	And User Opens Created Content	
	Then Layout Should Not Have Changed

Center Aligned Banner With Transparent Link
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating Center Aligned Banner With Transparent Link
	When New Landingpage is Submitted
	And User Opens Created Content	
	Then Layout Should Not Have Changed
	
Center Aligned Banner With Framed Link
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating Center Aligned Banner With Framed Link
	When New Landingpage is Submitted
	And User Opens Created Content	
	Then Layout Should Not Have Changed		

Link Opens In New Window
	[Tags]  CRITICAL
	Given User Goes To New LandingPage Site
	And User Starts Creating Left Aligned Banner With Fullcolor Link
	When New Landingpage is Submitted
	And User Opens Created Content	
	And User Clicks The Content Link
	Then Link Should Be Opened In New Window
	
	
*** Keywords ***
User Goes To New LandingPage Site   Go To New LandingPage Site
New Landingpage is Submitted	Submit The New Landingpage
User Starts Creating ${alignment} Aligned Banner With ${linkstyle} Link   Create LandingPage With ${alignment} Aligned Banner And With ${linkstyle} Link

User Clicks The Content Link   
	Wait Until Keyword Succeeds  5x  200ms  Click Link In Content

Link Should Be Opened In New Window   New Window Should Be Opened   Rautatie (romaani) – Wikipedia

User Opens Created Content
	 Open Created Content
	 Banner.Take Screenshot Of Content
	 
Layout Should Not Have Changed
	${excludeneeded}=  Image Comparison Needs To Exclude Areas
	@{arealist}=  Run Keyword If   ${excludeneeded}    Add Excluded Areas To List
	${originalpic} =  Set Variable If  '${linkstyle}'!='${EMPTY}'  ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_LANDINGPAGE_BANNER_${alignment}_${linkstyle}link_${BROWSER}.png
	...   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_LANDINGPAGE_BANNER_${alignment}_text_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Copy Original Screenshot To Reports Folder   ${originalpic}
	Run Keyword If  ${excludeneeded}   Compared Pictures Match   ${originalpic}    ${comparisonpic}    ${arealist}
	Run Keyword Unless   ${excludeneeded}   Compared Pictures Match   ${originalpic}    ${comparisonpic}