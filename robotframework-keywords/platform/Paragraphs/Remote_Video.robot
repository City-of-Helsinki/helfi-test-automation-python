*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Create ${pagetype} With ${number} Remote Video(s) Content
	Set Test Variable   ${number}   ${number}
	Input Non-paragraph Related Content   ${pagetype}
    Add Remote Video   1
    Run Keyword If  '${TEST NAME}'=='Two Videos'   Add Remote Video   2   https://www.youtube.com/watch?v=3HPuT7A0O8c

	
Add Remote Video
	[Arguments]   ${number}   ${url}=https://www.youtube.com/watch?v=nl5jKA6MMVg    
	Run Keyword If  '${language}'=='fi'  Open Paragraph For Edit   ${Opt_AddRemotevideo}
	Wait Until Element Is Visible  name:field_remote_video-media-library-open-button-field_content-${number}-subform   timeout=3
	Wait Until Keyword Succeeds  5x  200ms  Click Element  name:field_remote_video-media-library-open-button-field_content-${number}-subform
	Wait Until Keyword Succeeds  5x  200ms  Input Text   ${Inp_RemoteVideo_Url}   ${url}
	Wait Until Keyword Succeeds  5x  100ms  Press Keys    None    TAB
	Wait Until Keyword Succeeds  5x  100ms  Press Keys    None    ENTER
	Sleep  1
	Wait Until Keyword Succeeds  5x  1s   Click Button  ${Btn_RemoteVideo_Confirm}
	Sleep  1
	Wait Until Keyword Succeeds  5x  1s   Click Button  ${Btn_RemoteVideo_Confirm}
	Wait Until Keyword Succeeds  6x  300ms   Element Should Not Be Visible   ${Btn_RemoteVideo_Confirm} 
	Set Test Variable  ${videosadded}    ${videosadded}+1
	
Remote Video Play Begins Correctly
	Wait Until Element Is Visible  css:#mm-0 > div.dialog-off-canvas-main-canvas > div > main > div.main-content   timeout=3
	Capture Element Screenshot   css:div.remote-video.remote-video--default > div > iframe   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video1start.png
	${videostart} =  Set Variable    ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video1start.png
	Click Element   ${Itm_Video}
	Sleep   5
	Capture Element Screenshot   css:div.remote-video.remote-video--default > div > iframe   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video1end.png
	${videoend} =  Set Variable    ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video1end.png
	Run Keyword And Expect Error   The compared images are different.  Compared Pictures Match  ${videostart}   ${videoend}
	#VIDEO2
	Run Keyword If  '${TEST NAME}'=='Two Videos'   Video 2 Plays Correctly


Video 2 Plays Correctly
	Capture Element Screenshot   css:article > div > div:nth-child(3) > div > iframe   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video2start.png
	${video2start} =  Set Variable    ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video2start.png
	Click Element   ${Itm_Video2}
	Sleep   5
	Capture Element Screenshot   css:article > div > div:nth-child(3) > div > iframe   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video2end.png
	${video2end} =  Set Variable    ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video2end.png
	Run Keyword And Expect Error   The compared images are different.  Compared Pictures Match  ${video2start}   ${video2end}
	
Take Screenshot Of Content
	Maximize Browser Window
	IF  '${TEST NAME}'=='Two Videos'
		Execute javascript  document.body.style.zoom="25%"
	ELSE
		Execute javascript  document.body.style.zoom="30%"
	END
	Capture Page Screenshot    filename=${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Execute javascript  document.body.style.zoom="100%"	
	