*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***
Create Unit Accessibility Information For Unit
	[Arguments] 	${pagetype}   ${unitname}
	Input Non-paragraph Related Content   ${pagetype}
	Open Paragraph For Edit   ${Opt_Unit_Accessibility_Information}
	Wait Until Keyword Succeeds  5x  200ms  Input Text   ${Inp_Unit_Accessibility_Information_Unit}   ${unitname}