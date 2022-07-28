*** Settings ***
Resource        ../../../../robotframework-keywords/platform/Commonkeywords.robot
Resource        ../../../../robotframework-keywords/platform/Contenthandler.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		DISTRICT

*** Test Cases ***
District Page
	[Tags]  CRITICAL
	Given User Goes To New District -Site
	And User Creates District Content Page
	When User Submits The New District
	

	
*** Keywords ***
User Goes To New District -Site		Go To New District Site
User Submits The New District
	Submit The New District

User Creates District Content Page
	Input Non-paragraph Related Content   District
	Add District Spesific Data
	Scroll Element Into View   ${Ddn_AddContent}
	Click Button   ${Inp_District_Sidebar_AddText}
	Wait Until Keyword Succeeds  5x  200ms  Input Text   ${Inp_District_Sidebar_Text_Title}   Sidebar Title
	Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   ${Inp_District_Sidebar_Text_Content}  //body   Sidebar Content
	Open Paragraph For Edit   ${Opt_AddText}
	${TextFileDescription}=  Return Correct Description   ${language}
	Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   ${Inp_District_Text}  //body   ${TextFileDescription}


Input Non-paragraph Related Content
	[Arguments]   ${pagetype}
	Input Title  Test Automation: ${SUITE}.${TEST NAME}
	${headertitle}=  Get File  ${CONTENT_PATH}/text_description_short_${language}.txt
	${islandingpage}=  Suite Source Contains Text    Landing_Page
	#Run Keyword If  not(${islandingpage})   Input Content Header Title  ${headertitle}   ${pagetype}
	
Add District Spesific Data
	#Wait Until Keyword Succeeds  6x  300ms  Click Element  name:field_project_image-media-library-open-button
	#Wait Until Keyword Succeeds  6x  300ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/windmill.jpg
	#Wait Until Keyword Succeeds  6x  300ms  Input Text    ${Inp_Pic_Name}   Tuulimylly
	#Input Text    ${Inp_Pic_AltText}   Vanhaa kaupunkia 
	#Input Text    ${Inp_Pic_Photographer}   Testi Valokuvaaja
	#Click Button   ${Btn_Save}
	#Wait Until Keyword Succeeds  5x  200ms  Submit New Media
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph   ${Inp_District_Hero_Title}
	Wait Until Keyword Succeeds  5x  200ms  Input Description To Paragraph   ${Inp_District_Hero_Description}
