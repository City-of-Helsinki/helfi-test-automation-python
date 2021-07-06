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

Create New ${lang_selection} Gallery Paragraph To Library
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Open Paragraph Add Page With Given Language   ${lang_selection}
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Paragraph_Title}    Test_Automation_Add_From_Library_Gallery_${language}
	Click Element   ${Btn_Actions_Dropbutton}
	Click Element  ${Opt_Paragraph_AddGallery}
	Add Picture 'train' And Caption To 1:th Picture
	Click Button   ${Btn_Paragraph_Submit}
	Wait Until Keyword Succeeds  5x  200ms  Element Should Not Be Visible   ${Btn_Paragraph_Submit}
	Set Test Variable  ${paragraphsadded}    ${paragraphsadded}+1 


Create New ${lang_selection} ContentCards Paragraph To Library
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Open Paragraph Add Page With Given Language   ${lang_selection}
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Paragraph_Title}    Test_Automation_Add_From_Library_ContentCards_${language}  
	Click Element   ${Btn_Actions_Dropbutton}
	Click Element  ${Opt_Paragraph_AddContentCards}
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph  ${Inp_Paragraph_ContentCards_Title}
	Run Keyword If  '${lang_selection}'=='Finnish'  Input Text   ${Inp_Paragraph_ContentCard_TargetId}   Esimerkkisivu
	Run Keyword If  '${lang_selection}'=='Finnish'  Wait Until Keyword Succeeds  5x  100ms  Click Element   //a[contains(text(),'Esimerkkisivu')]
	Run Keyword If  '${lang_selection}'=='English'  Input Text   ${Inp_Paragraph_ContentCard_TargetId}   example
	Run Keyword If  '${lang_selection}'=='English'  Wait Until Keyword Succeeds  5x  100ms  Click Element   //a[contains(text(),'example')]
	Click Button   ${Btn_Paragraph_Submit}
	Wait Until Keyword Succeeds  5x  200ms  Element Should Not Be Visible   ${Btn_Paragraph_Submit}
	Set Test Variable  ${paragraphsadded}    ${paragraphsadded}+1

Create New ${lang_selection} Picture Paragraph To Library
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Open Paragraph Add Page With Given Language   ${lang_selection}
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Paragraph_Title}    Test_Automation_Add_From_Library_Picture_${language}  
	Click Element   ${Btn_Actions_Dropbutton}
	Click Element  ${Opt_Paragraph_AddPicture}
	Add Picture 'train' And Caption To 1:th Picture
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
	Run Keyword If  '${lang_selection}'=='Finnish'  Open Paragraph For Edit   ${Opt_AddFromLibrary}
	Wait Until Keyword Succeeds  5x  200ms  Click Element   //option[text()='Test_Automation_Add_From_Library_${paragraph}_${language}']
	Wait Until Keyword Succeeds  5x  200ms  Submit The New ${pagetype}

Add Picture '${name}' And Caption To ${number}:th Picture
	${number}=   Convert To Integer   ${number}
	Run Keyword If  ${number}>=2   Click Element   ${Btn_Gallery_Picture_Addmore}
	${editgalleryvisible}=  Run Keyword And Return Status    Wait Until Element Is Visible  name:field_content_0_edit   timeout=1
	Run Keyword If  ${editgalleryvisible}  Wait Until Keyword Succeeds  5x  500ms  Click Edit Paragraph
	Run Keyword If  ${editgalleryvisible}  Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Btn_Gallery_Picture_Addmore}
	Run Keyword If  '${name}'=='tulips'   Sleep   1    # Sleep due issues of missing paragraph in page
	Wait Until Keyword Succeeds  5x  500ms   Open Add Picture   ${number}
	@{content}=  Set Variable  @{pic_1_texts_${language}}
	${pictitle}=  Get From List  ${content}   0
	${picdescription}=  Get From List  ${content}   1
	${pgrapher}=  Get From List  ${content}   2
	Wait Until Keyword Succeeds  5x  200ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/${name}.jpg
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Pic_Name}   ${pictitle}
	Input Text    ${Inp_Pic_AltText}   ${picdescription} 
	Input Text    ${Inp_Pic_Photographer}   ${pgrapher}
	Run Keyword If  '${language}'=='fi'   Click Button   ${Btn_Save}
	Run Keyword If  '${language}'=='en'   Click Button   ${Btn_Save_En}
	Run Keyword If  '${language}'=='sv'   Click Button   ${Btn_Save_Sv}
	Run Keyword If  '${language}'=='fi'  Wait Until Keyword Succeeds  5x  200ms  Click Button   ${Btn_Insert_Pic}
	Run Keyword If  '${language}'=='en'  Wait Until Keyword Succeeds  5x  200ms  Click Button   ${Btn_Insert_Pic_Alt}
	Run Keyword If  '${language}'=='sv'  Wait Until Keyword Succeeds  5x  200ms  Click Button   ${Btn_Insert_Pic_Alt}

	Run Keyword If  '${TEST NAME}'=='Gallery'  Wait Until Keyword Succeeds  5x  200ms   Input Text      ${Tar_Paragraph_Gallery_Image_Caption}   ${pic_1_caption_${language}}
	Run Keyword If  '${TEST NAME}'=='Picture'  Wait Until Keyword Succeeds  5x  200ms   Input Text      ${Tar_Paragraph_Picture_Image_Caption}   ${pic_1_caption_${language}}
	Set Test Variable  ${picsadded}    ${picsadded}+1
	Set Test Variable  ${picture}    picture

Open Add Picture
	[Arguments]   ${number}
	Run Keyword If  '${TEST NAME}'=='Gallery'  Wait Until Element Is Visible   ${Btn_Paragraph_Gallery_Picture}${number-1}-subform   timeout=4
	Run Keyword If  '${TEST NAME}'=='Picture'  Wait Until Element Is Visible   ${Btn_Paragraph_Image_Picture}   timeout=4
	Run Keyword If  '${TEST NAME}'=='Gallery'  Wait Until Keyword Succeeds  5x  200ms  Click Element	${Btn_Paragraph_Gallery_Picture}${number-1}-subform
	Run Keyword If  '${TEST NAME}'=='Picture'  Wait Until Keyword Succeeds  5x  200ms  Click Element	${Btn_Paragraph_Image_Picture}
	Wait Until Keyword Succeeds  5x  300ms  Element Should Be Visible   name:files[upload] 

Page Should Have ${lang_input} Translation
	Set Language Pointer   ${lang_input}
	Select Language   ${lang_input}
	Page Content Matches Language

Page Content Matches Language
	${islandingpage}=  Suite Name Contains Text    Landing Page
	Run Keyword If  ('${TEST NAME}'=='Accordion') & ('${language}'=='fi')  Accept Cookies
	Run Keyword If  '${TEST NAME}'=='Accordion'  Wait Until Keyword Succeeds  5x  200ms  Click Element  ${Btn_Accordion_View}
	${Title}=  Run Keyword Unless  ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture')   Return Title From Page
	${Description}=  Return Description From Page
	 ${Content}=  Run Keyword Unless  ('${TEST NAME}'=='Banner') | ('${TEST NAME}'=='ContentCards') | ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture')  Add_From_Library.Return Content From Page
	 ${Linktext}=  Run Keyword If  '${TEST NAME}'=='Banner'  Return Link Text From Page
	 ${Piccaption}=  Run Keyword If  ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture')  Return Picture Caption From Page
	Run Keyword Unless  ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture')  Title Should Match Current Language Selection   ${Title}
	Run Keyword Unless  ${islandingpage}  Description Should Match Current Language Selection   ${Description}	
	Run Keyword If  ${islandingpage} & ('${TEST NAME}'=='Banner')  Description Should Match Current Language Selection   ${Description}
	Run Keyword If  ${islandingpage} & ('${TEST NAME}'=='Columns')   Content Should Match Current Language Selection   ${Description}
	Run Keyword Unless  ('${TEST NAME}'=='Banner') | ('${TEST NAME}'=='ContentCards') | ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture')   Content Should Match Current Language Selection   ${Content}
	Run Keyword If  '${TEST NAME}'=='Banner'    LinkText Is Correct   ${Linktext}
	Run Keyword If  ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture')   Picture Caption Is Correct   ${Piccaption}
	
Return Title From Page
	IF    '${TEST NAME}'=='Columns'
        ${title}=   Get Text    ${Txt_Column_Title}
    ELSE IF    '${TEST NAME}'=='Banner'
        ${title}=   Get Text    ${Txt_Banner_Title}
    ELSE IF    '${TEST NAME}'=='Accordion'
    	Wait Until Element Is Visible   ${Txt_Accordion_Title}
    	${title}=   Get Text    ${Txt_Accordion_Title}
    ELSE IF  '${TEST NAME}'=='ContentCards'
    	${title}=   Get Text    ${Txt_ContentCards_Title}
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

Return Picture Caption From Page
	${caption}=	 Get Text    ${Txt_Gallery_Image_Caption}
	[Return]		${caption}

Picture Caption Is Correct
	[Arguments]   ${caption}
	Should Contain    ${caption}    ${pic_1_caption_${language}}
	
LinkText Is Correct
	[Arguments]   ${linktext}
	Should Match    ${linktext}    Test Automation Banner Link