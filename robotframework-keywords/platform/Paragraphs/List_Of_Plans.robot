*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***
Create List Of Plans
	[Arguments]   ${pagetype}=Page
	Input Non-paragraph Related Content   ${pagetype}
	Open Paragraph For Edit   ${Opt_ListofPlans}
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph  ${Inp_ListofPlans_Title}
	Input Text   ${Inp_ListofPlans_Description}   Test Description text