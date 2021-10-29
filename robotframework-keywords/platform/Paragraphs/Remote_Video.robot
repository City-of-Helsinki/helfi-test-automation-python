*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Create ${pagetype} With ${number} Remote Video(s) Content
	Set Test Variable   ${number}   ${number}
	Input Non-paragraph Related Content   ${pagetype}
    Add Remote Video
    Run Keyword If  '${TEST NAME}'=='Two Videos'   Add Remote Video   https://www.youtube.com/watch?v=3HPuT7A0O8c

	
Add Remote Video
	[Arguments]   ${url}=https://www.youtube.com/watch?v=nl5jKA6MMVg
	Run Keyword If  '${language}'=='fi'  Open Paragraph For Edit   ${Opt_AddRemotevideo}
	Wait Until Keyword Succeeds  5x  200ms  Execute javascript  window.scrollTo(0, 200)
	Wait Until Keyword Succeeds  5x  200ms  Click Element  ${Btn_RemoteVideo_Add}
	Wait Until Keyword Succeeds  5x  200ms  Input Text   ${Inp_RemoteVideo_Url}   ${url}
	Wait Until Keyword Succeeds  5x  100ms  Press Keys    None    TAB
	Wait Until Keyword Succeeds  5x  100ms  Press Keys    None    ENTER
	Sleep  1
	Wait Until Keyword Succeeds  5x  1s   Click Button  ${Btn_RemoteVideo_Confirm}
	Sleep  1
	Wait Until Keyword Succeeds  5x  1s   Click Button  ${Btn_RemoteVideo_Confirm}
	Wait Until Keyword Succeeds  6x  300ms   Element Should Not Be Visible   ${Btn_RemoteVideo_Confirm} 
	Set Test Variable  ${mediaadded}    ${mediaadded}+1
	
Remote Video Play Begins Correctly
	Wait Until Element Is Visible  ${Itm_Video}
	Capture Element Screenshot   css:div.remote-video.remote-video--default     ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video1start.png
	${videostart} =  Set Variable    ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video1start.png
	Play Video   ${Itm_Video}
	Capture Element Screenshot   css:div.remote-video.remote-video--default > div > iframe   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video1end.png
	${videoend} =  Set Variable    ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video1end.png
	Run Keyword And Expect Error   The compared images are different.  Compared Pictures Match  ${videostart}   ${videoend}
	#VIDEO2
	Run Keyword If  '${TEST NAME}'=='Two Videos'   Video 2 Plays Correctly


Video 2 Plays Correctly
	${isarticle}=  Suite Name Contains Text   Article
	${islandingpage}=  Suite Name Contains Text   Landing Page
	Run Keyword If   ${isarticle}   Capture Element Screenshot   ${Itm_Article_Video2}   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video2start.png
	Run Keyword If   ${islandingpage}   Capture Element Screenshot   ${Itm_Landingpage_Video2}   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video2start.png   
	Run Keyword Unless   ${isarticle} | ${islandingpage}   Capture Element Screenshot   ${Itm_Video2}   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video2start.png
	${video2start} =  Set Variable    ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video2start.png
	Play Video   ${Itm_Video2}
	Run Keyword If   ${isarticle}   Capture Element Screenshot   ${Itm_Article_Video2}   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video2end.png
	Run Keyword If   ${islandingpage}   Capture Element Screenshot   ${Itm_Landingpage_Video2}   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video2end.png
	Run Keyword Unless   ${isarticle} | ${islandingpage}   Capture Element Screenshot   ${Itm_Video2}   ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video2end.png
	${video2end} =  Set Variable    ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}_Video2end.png
	Run Keyword And Expect Error   The compared images are different.  Compared Pictures Match  ${video2start}   ${video2end}

Play Video
	[Arguments]   ${video_frame}
	Select Frame   ${video_frame}
	Select Frame   css:body > iframe
	Sleep  3
	Click Element   css:#movie_player > div.ytp-cued-thumbnail-overlay > button
	Unselect Frame
	Unselect Frame
	Sleep   8
	
Take Screenshot Of Content
	Maximize Browser Window
	IF  '${TEST NAME}'=='Two Videos'
		Execute javascript  document.body.style.zoom="25%"
	ELSE
		Execute javascript  document.body.style.zoom="30%"
	END
	Capture Page Screenshot    filename=${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Execute javascript  document.body.style.zoom="100%"	
	