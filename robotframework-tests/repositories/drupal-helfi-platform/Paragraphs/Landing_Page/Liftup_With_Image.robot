*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Liftup_With_Image.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		LANDINGPAGE   LIFTUPWITHIMAGE

*** Test Cases ***
Left Picture
	[Tags]  CRITICAL
	Given User Goes To New LandingPage Site
	When User Starts Creating LandingPage With Left Picture -Design
	And New Landingpage is Submitted
	Then Layout Should Not Have Changed	

Right Picture
	[Tags]
	Given User Goes To New LandingPage Site
	When User Starts Creating LandingPage With Right Picture -Design
	And New Landingpage is Submitted
	Then Layout Should Not Have Changed	

Left Picture Secondary Color
	[Tags]  CRITICAL
	Given User Goes To New LandingPage Site
	When User Starts Creating LandingPage With Left Picture -Design and Alternate Color
	And New Landingpage is Submitted
	Then Layout Should Not Have Changed	

Right Picture Secondary Color
	[Tags]
	Given User Goes To New LandingPage Site
	When User Starts Creating LandingPage With Right Picture -Design and Alternate Color
	And New Landingpage is Submitted
	Then Layout Should Not Have Changed	

Background Picture Text Left
	[Tags]
	Given User Goes To New LandingPage Site
	When User Starts Creating LandingPage With Background Picture And Text On Left -Design
	And New Landingpage is Submitted
	Then Layout Should Not Have Changed	
	
Background Picture Text Right
	[Tags] 
	Given User Goes To New LandingPage Site
	When User Starts Creating LandingPage With Background Picture And Text On Right -Design
	And New Landingpage is Submitted
	Then Layout Should Not Have Changed	
	

*** Keywords ***
User Goes To New LandingPage Site   Go To New LandingPage Site
New Landingpage is Submitted	Submit The New Landingpage

User Starts Creating ${pagetype} With ${design} -Design 	Create LiftUpWithImage   ${pagetype}   ${design}
User Starts Creating ${pagetype} With ${design} -Design and Alternate Color 	Create LiftUpWithImage   ${pagetype}   ${design}   Secondary	
	
Layout Should Not Have Changed
	Run Keyword And Ignore Error  Accept Cookies
	Take Screenshot Of Content
	Run Keyword If  '${coloroption}'!='${EMPTY}'   Capture Element Screenshot  css:.liftup-with-image__content   filename=${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	${originalpic} =  Set Variable If  '${coloroption}'=='${EMPTY}'   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_LANDINGPAGE_LIFTUPWITHIMAGE_${design}_${BROWSER}.png
	...	  '${coloroption}'!='${EMPTY}'   ${SCREENSHOTS_PATH}/${BROWSER}/${TEST NAME}_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}