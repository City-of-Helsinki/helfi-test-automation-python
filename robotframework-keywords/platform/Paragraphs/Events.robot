*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Variables ***
${TAPAHTUMAT_URL}		https://tapahtumat.hel.fi/fi/home

*** Keywords ***

Create Event
	[Arguments]   ${pagetype}
	Input Non-paragraph Related Content   ${pagetype}
	Open Paragraph For Edit   ${Opt_AddEvent}
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph   ${Inp_Event_Title}
	Input Description To Paragraph   ${Frm_Content}
	Input Text   ${Inp_Event_Url}   ${TAPAHTUMAT_URL}
	Click Button  ${Swh_Event_LoadMore}
	
Events Are Present In Page
	Wait Until Element Is Visible  css:.component--event-list   timeout=5
