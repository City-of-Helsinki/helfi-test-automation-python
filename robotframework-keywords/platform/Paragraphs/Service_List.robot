*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Add ServiceList
	[Arguments]   ${pagetype}
	Input Non-paragraph Related Content   ${pagetype}
	Open Paragraph For Edit   ${Opt_ServiceList}
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph   ${Inp_ServiceList_Title}
	Select From List By Index   name:field_content[0][subform][field_service_list_services][]   0
	Run Keyword If  '${TEST NAME}'=='Two Units'  Select From List By Index   name:field_content[0][subform][field_service_list_services][]   1
	Run Keyword If  '${language}'=='fi'  Wait Until Keyword Succeeds  5x  100ms   Input Description To Paragraph   css:#cke_1_contents > iframe
	