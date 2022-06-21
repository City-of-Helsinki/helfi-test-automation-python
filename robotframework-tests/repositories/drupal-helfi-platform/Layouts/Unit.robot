*** Settings ***
Resource        ../../../../robotframework-keywords/platform/Contenthandler.robot
Resource        ../../../../robotframework-keywords/platform/Others/Layouts_Common.robot
Test Setup     Layouts_Common.Login And Go To Content Page
Test Teardown  Debug If Needed And Close Browsers

Force Tags		UNIT   LAYOUTS
*** Variables ***
${unit_main_path}			  dc-layout-tpr-unit	
${unit_subnav_sidebar}	 	  dc-layout-tpr-unit-subnav-sidebar
${unit_subnav_nosidebar}	  dc-layout-tpr-unit-subnav-no-sidebar
${unit_nosubnav_sidebar}	  dc-layout-tpr-unit-no-subnav-sidebar



*** Test Cases ***
Units-Picture Comparison
	[Tags]
	Unit Layouts Match Comparison Pictures	

Units-Functional Testing
	[Tags]
	Unit Components Function Correctly


*** Keywords ***
Unit Layouts Match Comparison Pictures
	Take Screenshot And Compare Upper And Lower Content On Page   ${unit_subnav_sidebar}
	Take Screenshot And Compare Upper And Lower Content On Page   ${unit_subnav_nosidebar}
	Take Screenshot And Compare Main Content On Page			  ${unit_nosubnav_sidebar}
	
Unit Components Function Correctly
	GoTo    ${URL_layouts_page}/${unit_main_path}/${unit_subnav_sidebar}
	IF  not(${MOBILE})
		Accept Cookies
	END
	Unit Accessibility Component Functions Correctly

	
Unit Accessibility Component Functions Correctly
	Wait Until Keyword Succeeds  5x  200ms  Click Button   id:accessibility-information
	Wait Until Element Is Visible   id:group-en_1   timeout=3
	IF  not(${MOBILE}) 
		Capture Screenshot For Picture Comparison In Layouts Page   css=div.accordion__wrapper.handorgel   filename=unit_accordion_desktop
		Compare Two Pictures   origfilename=unit_accordion   compfilename=unit_accordion_desktop
	END	
	

