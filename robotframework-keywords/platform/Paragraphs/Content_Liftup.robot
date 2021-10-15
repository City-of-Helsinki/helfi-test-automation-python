*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Add Content Liftup For Unit
	[Arguments]   ${pagetype}   ${unitname}
	Wait Until Keyword Succeeds  5x  200ms   Open Paragraph For Edit   ${Opt_ContentLiftup}
	Sleep  0.5		# Small sleep so that text is inserted correctly
	Wait Until Keyword Succeeds  5x  200ms   Input Text   ${Inp_UnitId_Text}   ${unitname}
	Capture Page Screenshot

ContentLiftup Is Working Correctly For One Unit
	Click Link   css:.unit__link
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   lippulaivan-kirjasto

ContentLiftup Is Working Correctly For Two Units
	${contentpageurl}=   Get Location
	Click Link   css:.unit__link
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   lippulaivan-kirjasto
	Go To   ${contentpageurl}
	Wait Until Element Is Visible   //a[contains(@href, '/fi/otaniemen')]
	Click Element   //a[contains(@href, '/fi/otaniemen')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   otaniemen-kirjasto