*** Settings ***
Resource        ../../../../robotframework-keywords/platform/Commonkeywords.robot
Resource        ../../../../robotframework-keywords/platform/Contenthandler.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PROJECT

*** Test Cases ***
Project Page
	[Tags]  CRITICAL   TODO
	Given User Goes To New Project -Site
	And User Creates Project Content Page
	When User Submits The New Page
	Fail

	
*** Keywords ***
User Goes To New Project -Site		Go To New Project Site
User Submits The New Page
	Submit The New Page

User Creates Project Content Page
	Input Non-paragraph Related Content   Project
	Add Project Spesific Data
	Scroll Element Into View   ${Ddn_AddContent}
	Click Button   ${Inp_Project_Sidebar_AddText}
	Wait Until Keyword Succeeds  5x  200ms  Input Text   ${Inp_Project_Sidebar_Text_Title}   Sidebar Title
	Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   ${Frm_Content}  //body   Sidebar Content
	Open Paragraph For Edit   ${Opt_AddText}
	Wait Until Keyword Succeeds  5x  200ms  Input Description To Paragraph   ${Inp_Project_Text_Content}
	
	
	
	
	

Input Non-paragraph Related Content
	[Arguments]   ${pagetype}
	Input Title  Test Automation: ${SUITE}.${TEST NAME}
	${headertitle}=  Get File  ${CONTENT_PATH}/text_description_short_${language}.txt
	${islandingpage}=  Suite Source Contains Text    Landing_Page
	#Run Keyword If  not(${islandingpage})   Input Content Header Title  ${headertitle}   ${pagetype}
	
Add Project Spesific Data
	Wait Until Keyword Succeeds  6x  300ms  Click Element  name:field_project_image-media-library-open-button
	Wait Until Keyword Succeeds  6x  300ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/windmill.jpg
	Wait Until Keyword Succeeds  6x  300ms  Input Text    ${Inp_Pic_Name}   Tuulimylly
	Input Text    ${Inp_Pic_AltText}   Vanhaa kaupunkia 
	Input Text    ${Inp_Pic_Photographer}   Testi Valokuvaaja
	Click Button   ${Btn_Save}
	Wait Until Keyword Succeeds  5x  200ms  Submit New Media
	Wait Until Keyword Succeeds  6x  300ms  Input Text   ${Inp_Project_Plan_StartDate}   01.01.2021
	Wait Until Keyword Succeeds  6x  300ms  Input Text   ${Inp_Project_Plan_EndDate}   01.01.2022
	Wait Until Keyword Succeeds  6x  300ms  Input Text   ${Inp_Project_Execution_StartDate}   01.02.2021
	Wait Until Keyword Succeeds  6x  300ms  Input Text   ${Inp_Project_Execution_EndDate}   01.02.2022
