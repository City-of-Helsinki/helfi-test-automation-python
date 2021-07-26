*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Create Map With Given Url
	[Arguments]   ${URL}
	Set Test Variable   ${URL}   ${URL}
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
	
Map Paragraph Works Correctly
	Wait Until Keyword Succeeds  5x   200ms   Accept Cookies
	${ispalvelukartta}=  URL Contains Text   palvelukartta
	Wait Until Element Is Visible  ${Itm_Map}
	Select Frame   ${Itm_Map}
	Run Keyword Unless   ${ispalvelukartta}   Scroll Element Into View   css:#mapcontainer > div.ol-viewport > canvas
	Run Keyword If   ${ispalvelukartta}   Scroll Element Into View   css:#app > div > div > div:nth-child(3) > div
	Sleep  2
	Run Keyword If   ${ispalvelukartta}   Wait Until Keyword Succeeds  5x   200ms   Click Button   ${Btn_Map_Palvelukartta_AllowCookies}
	IF    ${ispalvelukartta}
        Capture Element Screenshot   css:#app > div > div > div:nth-child(3) > div   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Mapstart.png
    ELSE
    	Capture Element Screenshot   css:#mapcontainer > div.ol-viewport > canvas   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Mapstart.png
    END 
	
	${mapstart} =  Set Variable    ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Mapstart.png
	Run Keyword Unless   ${ispalvelukartta}	  Click Element   ${Btn_Map_ZoomOut}
	Run Keyword If   ${ispalvelukartta}	  Click Element  css:#app > div > div > div:nth-child(3) > div > div.leaflet-control-container > div.leaflet-bottom.leaflet-right > div:nth-child(2) > div > button.MuiButtonBase-root.jss275.zoomOut
	Sleep   1
	IF    ${ispalvelukartta}
        Capture Element Screenshot   css:#app > div > div > div:nth-child(3) > div   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Mapend.png
    ELSE
    	Capture Element Screenshot   css:#mapcontainer > div.ol-viewport > canvas   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Mapend.png
    END 
	${mapend} =  Set Variable    ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Mapend.png
	Run Keyword And Expect Error   The compared images are different.  Compared Pictures Match  ${mapstart}   ${mapend}
	Unselect Frame

URL Contains Text
	[Arguments]  ${text}
	${containstext}=    Run Keyword And Return Status    Should Contain    ${URL}    ${text}
	[Return]   ${containstext}	