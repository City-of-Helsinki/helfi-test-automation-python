*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Resolve Card-Size Variable
	[Arguments]  ${card-size}
	${card-size}=  Convert To Lower Case   ${card-size}
	${cardsizevariable}=   Set Variable If   '${card-size}'=='small'    small-cards
	...			'${card-size}'=='large'    large-cards
	...			'${card-size}'=='small grey'    small-cards-grey
	...			'${card-size}'=='large grey'    large-cards-grey
	[Return]   ${cardsizevariable}

Create ${pagetype} With ${cardsize} Cards For ${contentname} Content
 	Set Test Variable  ${cardsize}  ${cardsize}
 	Input Non-paragraph Related Content   ${pagetype}
	Open Paragraph For Edit   ${Opt_AddContentCards}
	${islandingpage}=  Suite Source Contains Text    Landing_Page
	Run Keyword Unless  ${islandingpage}   Wait Until Keyword Succeeds  5x  100ms  Input Title To Paragraph   ${Inp_ContentCard_Title}
	Run Keyword If  ${islandingpage}  Wait Until Keyword Succeeds  5x  100ms  Input Title To Paragraph   ${Inp_ContentCard_Landingpage_Title}
	${cardsizevalue}=  Resolve Card-Size Variable   ${cardsize}
	Select From List By Value  ${Inp_ContentCard_Design}  ${cardsizevalue}
	Input Text   ${Inp_ContentCard_TargetId}   ${contentname}
	Wait Until Keyword Succeeds  5x  100ms  Click Element   //a[contains(text(),'${contentname}')]
	
Add New ContentCard For ${contentname} Content
	${islandingpage}=  Suite Source Contains Text    Landing_Page
	Wait Until Keyword Succeeds  5x  100ms  Click Element  ${Inp_ContentCard_Addnew}
	# Better locators does not match correct element. For some reason only first is returned
	# So Only works for second content card. 
	Sleep  3
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_ContentCard_TargetId}   ${contentname}
	
	
ContentCards Are Working Correctly
	${contentpageurl}=   Get Location
	Click Element   //a[contains(@href, '/en/link-examples')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   link-examples
	Go To   ${contentpageurl}
	Wait Until Element Is Visible   //a[contains(@href, '/fi/esimerkkisivu')]
	Click Element   //a[contains(@href, '/fi/esimerkkisivu')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   esimerkkisivu
	
	