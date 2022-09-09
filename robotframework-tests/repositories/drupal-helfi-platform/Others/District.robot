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
	Then Content Link Works Succesfully

	
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
	Add List Of Links To Lower Content Area

Add List Of Links To Lower Content Area
	Click Element  ${Opt_ListOfLinks_Lower}
	Wait Until Keyword Succeeds  5x  200ms  Input Text   ${Inp_ListOfLinks_Title}   Title For List Of Links
	Wait Until Keyword Succeeds  5x  200ms  Input Text   ${Inp_ListOfLinks_Link_Title}   Link Examples
	Wait Until Keyword Succeeds  5x  200ms  Input Text   ${Inp_ListOfLinks_Link_Uri}   Link Examples
	Wait Until Keyword Succeeds  5x  200ms  Click Element  css:.linkit-result-line--title
	Add Picture To Link   train
	
Add Picture To Link
	[Arguments]   ${picname}
	${islandingpage}=  Suite Source Contains Text    Landing_Page
	Wait Until Keyword Succeeds  5x  200ms  Click Element  ${Inp_District_ListOfLinks_Link_AddPicture}
	Wait Until Keyword Succeeds  6x  300ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/${picname}.jpg
	Wait Until Keyword Succeeds  6x  300ms  Set Focus To Element  ${Inp_Pic_Name}
	Input Text    ${Inp_Pic_Name}   Juna sillalla
	Input Text    ${Inp_Pic_AltText}   Vanha juna kuljettaa matkustajia 
	Input Text    ${Inp_Pic_Photographer}   Testi Valokuvaaja
	Click Button   ${Btn_Save}
	Wait Until Keyword Succeeds  5x  200ms  Submit New Media
	Wait Until Element Is Visible  //input[contains(@data-drupal-selector, 'remove-button')]   timeout=3
	Set Test Variable  ${picture}   picture	

Input Non-paragraph Related Content
	[Arguments]   ${pagetype}
	Input Title  Test Automation: ${SUITE}.${TEST NAME}
	${headertitle}=  Get File  ${CONTENT_PATH}/text_description_short_${language}.txt
	${islandingpage}=  Suite Source Contains Text    Landing_Page

Content Link Works Succesfully

	Click Link  Link Examples
	${currenturl}=   Get Title
	Should Contain   ${currenturl}   Link examples 
	
	
Add District Spesific Data
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph   ${Inp_District_Hero_Title}
	Wait Until Keyword Succeeds  5x  200ms  Input Description To Paragraph   ${Inp_District_Hero_Description}
