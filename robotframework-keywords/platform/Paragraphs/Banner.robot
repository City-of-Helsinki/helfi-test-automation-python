*** Settings ***
Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***
Create ${pagetype} With ${alignment} Aligned Banner And With ${linkstyle} Link
	Set Test Variable   ${alignment}   ${alignment}
	Set Test Variable   ${linkstyle}   ${linkstyle}
	Input Non-paragraph Related Content   ${pagetype}
	Open Paragraph For Edit   ${Opt_AddBanner}
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph   ${Inp_Banner_Title}
	Run Keyword If  '${alignment}'=='Left'   Click Element   ${Opt_Banner_Left}
	Run Keyword If  '${alignment}'=='Left'   Select Icon With Name   ticket
	
	Input Description To Paragraph   ${Frm_Content}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_Banner_Link_Uri}   https://fi.wikipedia.org/wiki/Rautatie_(romaani) 
	Input Text   ${Inp_Banner_Link_Title}    ${link_title_${language}}
	Run Keyword If  '${TEST NAME}'=='Link Opens In New Window'   Click Element  ${Swh_Banner_Link_OpenInNewWindow}
	Run Keyword If  '${linkstyle}'=='Fullcolor'  Click Element   ${Opt_Link_Fullcolor}
	Run Keyword If  '${linkstyle}'=='Framed'  Click Element   ${Opt_Link_Framed}
	Run Keyword If  '${linkstyle}'=='Transparent'  Click Element   ${Opt_Link_Transparent}
	
Take Screenshot Of Content
	Maximize Browser Window
	Execute javascript  document.body.style.zoom="40%"
	Run keyword if  ('${picsize}'=='original') & ('${BROWSER}'=='chromeheadless')   Execute javascript  document.body.style.zoom="30%"
	Capture Page Screenshot    filename=${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Execute javascript  document.body.style.zoom="100%"

Set Banner Title
	Input Text  ${Inp_Banner_Title}   Juhani Aho: Rautatie

Click Link In Content
	Run Keyword If  '${language}'=='fi'   Click Link   css:div.banner__content-wrapper > a
