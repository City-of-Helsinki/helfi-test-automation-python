*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Create Map With Given Url
	[Arguments]   ${URL}
	Input Non-paragraph Related Content   Page
	Open Paragraph For Edit   ${Opt_AddMap}
	${description}=  Return Correct Description   ${language}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_Map_Title}   ${TEST NAME}
	Input Text Content To Frame   ${description}   cke_122_contents
	Click Element   ${Btn_Map_Add}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   name:helfi_media_map_url   ${URL}
	Wait Until Keyword Succeeds  5x  100ms  Set Focus To Element	  ${Btn_Map_Url_Add}
	Wait Until Keyword Succeeds  5x  100ms  Click Button  ${Btn_Map_Url_Add}
	Wait Until Keyword Succeeds  5x  100ms  Click Button  ${Btn_Save}
	Wait Until Keyword Succeeds  5x  100ms  Click Button  ${Btn_Insert_Pic}
	Wait Until Keyword Succeeds  5x  100ms  Element Should Not Be Visible   ${Btn_Insert_Pic}
	Set Test Variable  ${picsadded}    ${picsadded}+1
	
	
	
