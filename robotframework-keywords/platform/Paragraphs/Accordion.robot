*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Create ${pagetype} With ${color} Color , ${heading} Heading And ${contenttype} Content
	Set Test Variable  ${pagetype}  ${pagetype}
	Set Test Variable  ${contenttype}  ${contenttype}
	Set Test Variable  ${color}  ${color}
	Set Test Variable  ${heading}  ${heading}
	Input Non-paragraph Related Content   ${pagetype}
	Open Paragraph For Edit   ${Opt_AddAccordion}
	Run Keyword Unless  '${color}'=='White'  Wait Until Keyword Succeeds  5x  100ms  Click Element With Value   grey
	Wait Until Keyword Succeeds  5x  200ms  Click Element   //option[text()='${heading}']
	Input Title To Paragraph   ${Inp_Accordion_Title}
	Select Icon With Name   cogwheel
	Add SubContent To Accordion   ${contenttype}
	
Add ${content} Content to Columns Subcategory
	${content}=  Convert To Lower Case   ${content}
	Run Keyword If  '${content}'=='picture'	 Wait Until Keyword Succeeds  5x  200ms  Add Pictures to Column
	Run Keyword If  '${content}'=='text'	 Wait Until Keyword Succeeds  5x  200ms  Add Text to Column
	Input Title To Paragraph   ${Inp_Column_Title}
	
Add Pictures to Column
	Add picture to Left Column
	Add picture to Right Column

Add Text to Column
	Add text to Left Column
	Add text to Right Column

Add Content To Text Subcategory
	${TextFileContent}=  Return Correct Content   ${language}
	Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   ${Frm_Accordion_Content}   //body   ${TextFileContent}
	
Add SubContent To Accordion 
	[Arguments]   ${content}
	Wait Until Element Is Visible   ${Ddn_Accordion_AddContent}   timeout=3
	Focus   ${Ddn_Accordion_AddContent}
	Click Element	${Ddn_Accordion_AddContent}
	Run Keyword If  '${content}'=='Text'  Click Element   ${Opt_Accordion_Content_Text}
	Run Keyword If  '${content}'=='Columns'  Click Element   ${Opt_Accordion_Content_Columns}
	
Accordion Component Works As Expected
	Click Element  ${Btn_Accordion_View}
	Run Keyword Unless  '${picture}'=='picture'	 Wait Until Keyword Succeeds  5x  200ms  Text Content Exists In Created Accordion   
	Run Keyword If  '${picture}'=='picture'  Wait Until Keyword Succeeds  5x  200ms  Columns Paragraph With Pictures Exist In Created Accordion

Text Content Exists In Created Accordion
	${content}=  Run Keyword If  '${TEST NAME}'=='Columns With Text'   Return Content From Accordion Column Text Content
	...			 ELSE   Accordion.Return Content From Page
	Run Keyword If  '${TEST NAME}'=='Columns With Text'    Column Texts Matches To Expected Content  ${content}
	...			 ELSE      Content Should Match Current Language Selection   ${content}

Column Texts Matches To Expected Content
	[Arguments]   ${contentlist} 
	${left}=  Get From List  ${contentlist}   0
	${right}=  Get From List  ${contentlist}   1
	Should Match Regexp  ${left}   Sitä Matti ajatteli, mitä rovastin ja ruustinnan kanssa oli puhunut
	Should Match Regexp  ${right}   Viittatie teki niemen nenässä polvekkeen
	

Columns Paragraph With Pictures Exist In Created Accordion
	${pic1}=  Get Element Attribute  //picture//img@src
	${pic2}=  Get Element Attribute  //picture//following::picture//img@src
	Should Contain   ${pic1}    train
	Should Contain   ${pic2}    temple
			
Return Content From Page
	Wait Until Element Is Visible   css:#handorgel1-fold1-content > div > div > div > div > p   timeout=3	
	${content}=	Get Text    css:#handorgel1-fold1-content > div > div > div > div > p
	[Return]		${content}	

Return Content From Accordion Column Text Content
	Wait Until Element Is Visible   css:#handorgel1-fold1-content > div > div > div > div > div:nth-child(1) > div > div > div > p   timeout=3	
	${contentleft}=	Get Text    css:#handorgel1-fold1-content > div > div > div > div > div:nth-child(1) > div > div > div > p
	${contentright}=	Get Text    css:#handorgel1-fold1-content > div > div > div > div > div:nth-child(2) > div > div > div > p
	[Return]		${contentleft}   ${contentright}	