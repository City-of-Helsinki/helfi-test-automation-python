*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***
Create New ${lang_selection} Columns Paragraph To Library
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Open Paragraph Add Page With Given Language   ${lang_selection}
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Paragraph_Title}    Test_Automation_Add_From_Library_Columns_${language}  
	Click Element   ${Btn_Actions_Dropbutton}
	Click Element  ${Opt_Paragraph_AddColumns}
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph  ${Inp_Paragraph_Columns_Title}
	Add Text to Left Column
	Add Text to Right Column
	Click Button   ${Btn_Paragraph_Submit}
	Wait Until Keyword Succeeds  5x  200ms  Element Should Not Be Visible   ${Btn_Paragraph_Submit}
	Set Test Variable  ${paragraphsadded}    ${paragraphsadded}+1

Create New ${lang_selection} Banner Paragraph To Library
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Open Paragraph Add Page With Given Language   ${lang_selection}
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Paragraph_Title}    Test_Automation_Add_From_Library_Banner_${language}
	Click Element   ${Btn_Actions_Dropbutton}
	Click Element  ${Opt_Paragraph_AddBanner}
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph   ${Inp_Paragraph_Banner_Title}
	Click Element   ${Opt_Banner_Left}
	Select Icon With Name   ticket
	Input Description To Paragraph   ${Frm_Content}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_Paragraph_Banner_Link_Uri}   https://fi.wikipedia.org/wiki/Rautatie_(romaani)
	Input Text   ${Inp_Paragraph_Banner_Link_Text}   Test Automation Banner Link 
	Click Button   ${Btn_Paragraph_Submit}
	Wait Until Keyword Succeeds  5x  200ms  Element Should Not Be Visible   ${Btn_Paragraph_Submit}
	Set Test Variable  ${paragraphsadded}    ${paragraphsadded}+1 
 
Create New ${lang_selection} Accordion Paragraph To Library
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Open Paragraph Add Page With Given Language   ${lang_selection}
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Paragraph_Title}    Test_Automation_Add_From_Library_Accordion_${language}
	Click Element   ${Btn_Actions_Dropbutton}
	Click Element  ${Opt_Paragraph_AddAccordion}
	Wait Until Element Is Visible   ${Inp_Paragraph_Accordion_Accordion1_Text}
	Input Title To Paragraph   ${Inp_Paragraph_Accordion_Accordion1_Text}
	Select Icon With Name   cogwheel
	Add SubContent To Accordion   Text
	Add Content To Text Subcategory
	Click Button   ${Btn_Paragraph_Submit}
	Wait Until Keyword Succeeds  5x  200ms  Element Should Not Be Visible   ${Btn_Paragraph_Submit}
	Set Test Variable  ${paragraphsadded}    ${paragraphsadded}+1  
 
Add SubContent To Accordion 
	[Arguments]   ${content}
	Wait Until Element Is Visible   ${Ddn_Accordion_AddContent}   timeout=3
	Click Element	${Ddn_Accordion_AddContent}
	Run Keyword If  '${content}'=='Text'  Click Element   ${Opt_Accordion_Content_Text}
	Run Keyword If  '${content}'=='Columns'  Click Element   ${Opt_Accordion_Content_Columns}

Add Content To Text Subcategory
	${TextFileContent}=  Return Correct Content   ${language}
	Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   ${Frm_Content}   //body   ${TextFileContent}
	 
Open Paragraph Add Page With Given Language
	[Arguments]   ${language}
	Go To   ${URL_paragraphs_add_page}
	Select Language   ${language}
	
Create ${lang_selection} Language ${paragraph} -Paragraph ${pagetype} Content 
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Run Keyword If  '${lang_selection}'!='Finnish'  Go To New ${pagetype} -View For ${lang_selection} Translation
	Set Test Variable   ${paragraph}   ${paragraph}
	Input Non-paragraph Related Content   ${pagetype}
	Open Paragraph For Edit   ${Opt_AddFromLibrary}
	Wait Until Keyword Succeeds  5x  200ms  Click Element   //option[text()='Test_Automation_Add_From_Library_${paragraph}_${language}']
	Wait Until Keyword Succeeds  5x  200ms  Submit The New ${pagetype}

Page Should Have ${lang_input} Translation
	Set Language Pointer   ${lang_input}
	Select Language   ${lang_input}
	Page Content Matches Language

Page Content Matches Language
	${islandingpage}=  Suite Name Contains Text    Landing Page
	Run Keyword If  ('${TEST NAME}'=='Accordion') & ('${language}'=='fi')  Accept Cookies
	Run Keyword If  '${TEST NAME}'=='Accordion'  Wait Until Keyword Succeeds  5x  200ms  Click Element  ${Btn_Accordion_View}
	${Title}=  Return Title From Page
	${Description}=  Return Description From Page
	 ${Content}=  Run Keyword Unless  '${TEST NAME}'=='Banner'  Add_From_Library.Return Content From Page
	 ${Linktext}=  Run Keyword If  '${TEST NAME}'=='Banner'  Return Link Text From Page
	Title Should Match Current Language Selection   ${Title}
	Run Keyword Unless  ${islandingpage}  Description Should Match Current Language Selection   ${Description}	
	Run Keyword If  ${islandingpage} & ('${TEST NAME}'=='Banner')  Description Should Match Current Language Selection   ${Description}
	Run Keyword If  ${islandingpage} & ('${TEST NAME}'=='Columns')   Content Should Match Current Language Selection   ${Description}
	Run Keyword Unless  '${TEST NAME}'=='Banner'  Content Should Match Current Language Selection   ${Content}
	
	Run Keyword If  '${TEST NAME}'=='Banner'   LinkText Is Correct   ${Linktext}
	
Return Title From Page
	IF    '${TEST NAME}'=='Columns'
        ${title}=   Get Text    ${Txt_Column_Title}
    ELSE IF    '${TEST NAME}'=='Banner'
        ${title}=   Get Text    ${Txt_Banner_Title}
    ELSE IF    '${TEST NAME}'=='Accordion'
    	Wait Until Element Is Visible   ${Txt_Accordion_Title}
    	${title}=   Get Text    ${Txt_Accordion_Title}
    END
	[Return]		${title}

Return Description From Page
	${description}=	Get Text    ${Txt_Column_Description}
	[Return]		${description}

Return Content From Page
	IF    '${TEST NAME}'=='Columns'
		${content}=	Get Text    ${Txt_Column_Content}
	ELSE IF   '${TEST NAME}'=='Accordion'
		Sleep  2
		${content}=	Get Text   ${Txt_Accordion_Content}
	END
	[Return]		${content}
	
Return Link Text From Page
	${linktxt}=	 Get Text    ${Txt_Banner_Link}
	[Return]		${linktxt}
	
LinkText Is Correct
	[Arguments]   ${linktext}
	Should Match    ${linktext}    Test Automation Banner Link