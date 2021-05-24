*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Variables ***
${color}	 		 ${EMPTY}

*** Keywords ***

Return Hero Title From Page
	${title}=	Get Text    ${Txt_Hero_Title}
	[Return]		${title}

Return Hero Description From Page
	${description}=	Get Text    ${Txt_Hero_Description}
	[Return]		${description}
	
Create a ${value} Aligned Page With Hero Block In ${lang_selection} Language
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Run Keyword If  '${lang_selection}'=='Finnish'  Go To New Page Site
	Run Keyword If  '${lang_selection}'!='Finnish'  Go To New Page -View For ${lang_selection} Translation
	Start Creating a ${value} Aligned Page With Hero Block
	Submit The New Page
	Open Created Content
	Take Screenshot Of Content
 
Start Creating a ${value} Aligned Page With Hero Block 
	Set Test Variable   ${value}    ${value} 
	${islandingpage}=   Suite Name Contains Text   Landing Page
	Set Test Variable   ${islandingpage}   ${islandingpage}
	${containslink}=    Run Keyword And Return Status    Should Contain    ${TEST NAME}    Link
	Input Title  Test Automation: ${value} Aligned Hero Block Page
	${titleisvisible}=  Run Keyword And Return Status   Element Should Be Enabled   ${Inp_Hero_Title}
	Run Keyword Unless  ${titleisvisible} 	Click Element   ${Swh_HeroOnOff}
	Wait Until Keyword Succeeds  5x  100ms  Focus   ${Ddn_Hero_Alignment}
	Wait Until Keyword Succeeds  5x  100ms  Run Keyword If  '${value}'=='Center'  Click Element   ${Ddn_Hero_Alignment}
	Run Keyword If  '${value}'=='Center'  Click Element   ${Opt_Hero_Alignment_Center} 
	Wait Until Keyword Succeeds  5x  100ms   Input Title To Paragraph   ${Inp_Hero_Title}
	${TextFileContent}=  Return Correct Content   ${language}
	${TextFileDescription}=  Return Correct Description   ${language}
	# In case of link we need to add some linebreaks
	# main content
	Run Keyword Unless  ${containslink}  Input Text Content   ${TextFileContent}
	Run Keyword If      ${containslink}  Input Text Content   ${TextFileContent}\n
	# description
	Run Keyword Unless   ${containslink} | ${islandingpage}   Input Hero Description   ${TextFileDescription}
	Run Keyword If   ${containslink} & (${islandingpage}!=True)  Input Hero Description   ${TextFileDescription}\n

Input Text Content
	[Arguments]   ${content}
	Run Keyword If  '${language}'=='fi'	Input Text To Frame   ${Frm_Content}   //body   ${content}
	Run Keyword If  '${language}'!='fi'   Input Text To Frame   ${Frm_Content2}   //body   ${content}

Start Creating Hero Block Page with ${picalign} Picture 
	Start Creating a Left Aligned Page With Hero Block
    Set Test Variable   ${picture}  picture
    Set Test Variable   ${picalign}   ${picalign}    
	Run Keyword If  '${picalign}'=='Left'  Click Element   ${Opt_Hero_Picture_On_Left}
	Run Keyword If  '${picalign}'=='Right'  Click Element   ${Opt_Hero_Picture_On_Right}
	Run Keyword If  '${picalign}'=='Bottom'  Click Element   ${Opt_Hero_Picture_On_Bottom}
	Run Keyword If  '${picalign}'=='Background'  Click Element   ${Opt_Hero_Picture_On_Background}
	Run Keyword If  '${picalign}'=='Diagonal'  Click Element   ${Opt_Hero_Diagonal}
	Wait Until Keyword Succeeds  5x  100ms  Focus   ${Btn_Hero_Picture}
	Wait Until Keyword Succeeds  5x  100ms  Run Keyword If  ('${BROWSER}'=='chromeheadless')  Execute javascript  window.scrollTo(0, 400)
	Wait Until Keyword Succeeds  5x  100ms  Click Button   ${Btn_Hero_Picture}
	Wait Until Keyword Succeeds  5x  100ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/train.jpg
	Wait Until Keyword Succeeds  5x  100ms  Focus  ${Inp_Pic_Name}
	Input Text    ${Inp_Pic_Name}   Juna sillalla
	Input Text    ${Inp_Pic_AltText}   Vanha juna kuljettaa matkustajia 
	Input Text    ${Inp_Pic_Photographer}   Testi Valokuvaaja
	Click Button   ${Btn_Save}
	Wait Until Keyword Succeeds  5x  100ms  Click Button   ${Btn_Insert_Pic}
	Wait Until Element Is Visible  //input[@data-drupal-selector='edit-field-hero-0-subform-field-hero-image-selection-0-remove-button']   timeout=3
	Set Test Variable  ${picsadded}    ${picsadded}+1   


Add Hero Link Button With ${style} Style
	Set Test Variable   ${linkstyle}  ${style}
	Run Keyword If  '${picalign}'=='Background'   Add ${style} Link In Hero Content Paragraph   
	...    ELSE 	Add ${style} Link In Text Editor


Add ${style} Link In Hero Content Paragraph
	Click Button   ${Btn_Hero_AddLink}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_Hero_Link_URL}   https://fi.wikipedia.org/wiki/Rautatie_(romaani)    
	Input Text   ${Inp_Hero_Link_Title}    ${link_title_${language}}
	Focus   ${Ddn_Hero_Link_Design}
	Click Element  ${Ddn_Hero_Link_Design}
	Run Keyword If  '${style}'=='Fullcolor'  Click Element   ${Opt_Hero_Link_ButtonFullcolor}
	Run Keyword If  '${style}'=='Framed'  Click Element   ${Opt_Hero_Link_ButtonFramed}
	Run Keyword If  '${style}'=='Transparent'  Click Element   ${Opt_Hero_Link_ButtonTransparent}


Add ${style} Link In Text Editor
	${cke}=   Set Variable If  ${islandingpage}   id:cke_24 
	...		  id:cke_81
	Focus   ${cke}
	Click Element   ${cke}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_Hero_Link_Texteditor_URL}   https://fi.wikipedia.org/wiki/Rautatie_(romaani)    
	Input Text   ${Inp_Hero_Link_Texteditor_Title}    ${link_title_${language}}
	Focus   ${Ddn_Hero_Link_Texteditor_Design}
	Click Element  ${Ddn_Hero_Link_Texteditor_Design}
	
	Run Keyword If  '${style}'=='Fullcolor'  Click Element   ${Opt_Hero_Link_Texteditor_ButtonFullcolor}
	Run Keyword If  '${style}'=='Framed'  Click Element   ${Opt_Hero_Link_Texteditor_ButtonFramed}
	Run Keyword If  '${style}'=='Transparent'  Click Element   ${Opt_Hero_Link_Texteditor_ButtonTransparent}
	Click Button   ${Btn_Save}

Add ${color} As Background Color
	Set Test Variable   ${color}  ${color}
	Focus    ${Ddn_Hero_Color}
	Click Element Using JavaScript Xpath  ${Ddn_Hero_Color}
	Click Element With Value   ${color}

Input Hero Description
	[Arguments]   ${description}
	[Documentation]	  Here. In translation cases cke -identifier numbers have changed. Thus some if else is needed.
	Run Keyword If  '${language}'=='fi'	Input Text To Frame   ${Frm_Content_Description}   //body   ${description}
	Run Keyword If  '${language}'!='fi'   Input Text To Frame   ${Frm_Content}   //body   ${description}



