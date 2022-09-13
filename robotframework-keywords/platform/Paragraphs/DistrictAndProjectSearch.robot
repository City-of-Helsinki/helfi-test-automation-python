*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***
Create New District And Project Search Paragraph
	[Arguments]   ${pagetype}
	Input Non-paragraph Related Content   ${pagetype}
	Open Paragraph For Edit   ${Opt_DistrictAndUnitSearch}
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph   ${Inp_DistrictAndProjectSearch_Title}
	Input Description To Paragraph   ${Inp_DistrictAndProjectSearch_Description}