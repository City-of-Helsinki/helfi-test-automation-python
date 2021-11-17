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

Create New ${lang_selection} LiftupWithImage Paragraph To Library
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Open Paragraph Add Page With Given Language   ${lang_selection}
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Paragraph_Title}    Test_Automation_Add_From_Library_LiftupWithImage_${language}  
	Click Element   ${Btn_Actions_Dropbutton}
	Click Element  ${Opt_Paragraph_AddLiftupWithImage}
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph    ${Inp_LiftupWithImage_Title}
	Add Picture 'train' And Caption To 1:th Picture
	Input Description To Paragraph   ${Frm_Content}
	Wait Until Keyword Succeeds  5x  200ms  Click Button   ${Btn_Paragraph_Submit}
	Wait Until Keyword Succeeds  5x  200ms  Element Should Not Be Visible   ${Btn_Paragraph_Submit}
	Set Test Variable  ${paragraphsadded}    ${paragraphsadded}+1

Create New ${lang_selection} ListOfLinks Paragraph To Library
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Open Paragraph Add Page With Given Language   ${lang_selection}
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Paragraph_Title}    Test_Automation_Add_From_Library_ListOfLinks_${language}  
	Click Element   ${Btn_Actions_Dropbutton}
	Click Element  ${Opt_Paragraph_AddListOfLinks}
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph    ${Inp_Paragraph_ListOfLinks_Title}
	Input Text  ${Inp_ListOfLinks_Link_Uri}   /fi/linkkiesimerkit
	Input Text  ${Inp_ListOfLinks_Link_Title}   Linkkiesimerkit
	Add Picture 'train' And Caption To 1:th Picture
	Wait Until Keyword Succeeds  5x  200ms  Click Button   ${Btn_Paragraph_Submit}
	Wait Until Keyword Succeeds  5x  200ms  Element Should Not Be Visible   ${Btn_Paragraph_Submit}
	Set Test Variable  ${paragraphsadded}    ${paragraphsadded}+1

Create New ${lang_selection} Text Paragraph To Library
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Open Paragraph Add Page With Given Language   ${lang_selection}
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Paragraph_Title}    Test_Automation_Add_From_Library_Text_${language}  
	Click Element   ${Btn_Actions_Dropbutton}
	Click Element  ${Opt_Paragraph_AddText}
	Wait Until Keyword Succeeds  5x  200ms  Input Description To Paragraph   ${Frm_Content}
	Wait Until Keyword Succeeds  5x  200ms  Click Button   ${Btn_Paragraph_Submit}
	Wait Until Keyword Succeeds  5x  200ms  Element Should Not Be Visible   ${Btn_Paragraph_Submit}
	Set Test Variable  ${paragraphsadded}    ${paragraphsadded}+1

Create New ${lang_selection} SidebarText Paragraph To Library
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Open Paragraph Add Page With Given Language   ${lang_selection}
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Paragraph_Title}    Test_Automation_Add_From_Library_SidebarText_${language}  
	Click Element   ${Btn_Actions_Dropbutton}
	Click Element  ${Opt_Paragraph_AddSidebarText}
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph    ${Inp_Paragraph_SidebarText_Title}
	Wait Until Keyword Succeeds  5x  200ms  Input Description To Paragraph   ${Frm_Content}
	
	Wait Until Keyword Succeeds  5x  200ms  Click Button   ${Btn_Paragraph_Submit}
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
	
	Wait Until Keyword Succeeds  5x  200ms  Click Element   //option[contains(text(),'Test_Automation_Add_From_Library_${paragraph}_${language}')]
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
	Wait Until Keyword Succeeds  5x  200ms  Submit New Media

	Run Keyword If  '${TEST NAME}'=='Gallery'  Wait Until Keyword Succeeds  5x  200ms   Input Text      ${Tar_Paragraph_Gallery_Image_Caption}   ${pic_1_caption_${language}}
	Run Keyword If  '${TEST NAME}'=='Picture'  Wait Until Keyword Succeeds  5x  200ms   Input Text      ${Tar_Paragraph_Picture_Image_Caption}   ${pic_1_caption_${language}}
	Set Test Variable  ${picture}    picture

Open Add Picture
	[Arguments]   ${number}
	Run Keyword If  '${TEST NAME}'=='Gallery'  Wait Until Element Is Visible   ${Btn_Paragraph_Gallery_Picture}${number-1}-subform   timeout=4
	Run Keyword If  '${TEST NAME}'=='Picture'  Wait Until Element Is Visible   ${Btn_Paragraph_Image_Picture}   timeout=4
	Run Keyword If  '${TEST NAME}'=='LiftupWithImage'  Wait Until Element Is Visible   ${Btn_Paragraph_LiftupWithImage_Picture}   timeout=4
	Run Keyword If  '${TEST NAME}'=='ListOfLinks'  Wait Until Element Is Visible   ${Btn_Paragraph_ListOfLinks_Picture}   timeout=4
	Run Keyword If  '${TEST NAME}'=='Gallery'  Wait Until Keyword Succeeds  5x  200ms  Click Element	${Btn_Paragraph_Gallery_Picture}${number-1}-subform
	Run Keyword If  '${TEST NAME}'=='Picture'  Wait Until Keyword Succeeds  5x  200ms  Click Element	${Btn_Paragraph_Image_Picture}
	Run Keyword If  '${TEST NAME}'=='LiftupWithImage'  Wait Until Keyword Succeeds  5x  200ms  Click Element	${Btn_Paragraph_LiftupWithImage_Picture}
	Run Keyword If  '${TEST NAME}'=='ListOfLinks'  Execute javascript  window.scrollTo(0, 800)
	Run Keyword If  '${TEST NAME}'=='ListOfLinks'  Wait Until Keyword Succeeds  5x  200ms  Click Element	${Btn_Paragraph_ListOfLinks_Picture}
	Wait Until Keyword Succeeds  5x  300ms  Element Should Be Visible   name:files[upload] 

Page Should Have ${lang_input} Translation
	Set Language Pointer   ${lang_input}
	Select Language   ${lang_input}
	Page Content Matches Language

Page Content Matches Language
	${islandingpage}=  Suite Source Contains Text    Landing_Page
	${Description}=  Return Description From Page
	IF    ('${TEST NAME}'=='Accordion') & ('${language}'=='fi')  
		Accept Cookies
    ELSE IF  '${TEST NAME}'=='Accordion'
        Wait Until Keyword Succeeds  5x  200ms  Click Element  ${Btn_Accordion_View}
    ELSE IF    (not('${TEST NAME}'=='Gallery')) | (not('${TEST NAME}'=='Picture')) | (not('${TEST NAME}'=='Text'))
    	${Title}=  Return Title From Page
    ELSE IF  (not('${TEST NAME}'=='Banner')) | (not('${TEST NAME}'=='ContentCards')) | (not('${TEST NAME}'=='Gallery')) | (not('${TEST NAME}'=='Picture')) | (not('${TEST NAME}'=='LiftupWithImage')) | (not('${TEST NAME}'=='ListOfLinks')) | (not('${TEST NAME}'=='Text'))
    	${Content}=  Add_From_Library.Return Content From Page
    ELSE IF  	('${TEST NAME}'=='Banner') | ('${TEST NAME}'=='ListOfLinks')
    	${Linktext}=  Return Link Text From Page
    ELSE IF  	('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture')
    	${Piccaption}=   Return Picture Caption From Page
    ELSE IF  	(not('${TEST NAME}'=='Gallery')) | (not('${TEST NAME}'=='Picture')) | (not('${TEST NAME}'=='Text'))
    	Title Should Match Current Language Selection   ${Title}
    ELSE IF    not(${islandingpage})
    	  Description Should Match Current Language Selection   ${Description}  	
    ELSE IF   ${islandingpage} & ('${TEST NAME}'=='Banner')
    	  Description Should Match Current Language Selection   ${Description}
    ELSE IF   ${islandingpage} & ('${TEST NAME}'=='Columns')
    	  Content Should Match Current Language Selection   ${Description}
    ELSE IF   (not('${TEST NAME}'=='Banner')) | (not('${TEST NAME}'=='ContentCards')) | (not('${TEST NAME}'=='Gallery')) | (not('${TEST NAME}'=='Picture')) | (not('${TEST NAME}'=='LiftupWithImage')) | (not('${TEST NAME}'=='ListOfLinks')) | (not('${TEST NAME}'=='Text'))
    	  Content Should Match Current Language Selection   ${Content}
    ELSE IF  ('${TEST NAME}'=='Banner') | ('${TEST NAME}'=='ListOfLinks')
    	  LinkText Is Correct   ${Linktext}
    ELSE IF   ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture')
    	  Picture Caption Is Correct   ${Piccaption}
    END
	
	#Run Keyword If  ('${TEST NAME}'=='Accordion') & ('${language}'=='fi')  Accept Cookies
	#Run Keyword If  '${TEST NAME}'=='Accordion'  Wait Until Keyword Succeeds  5x  200ms  Click Element  ${Btn_Accordion_View}
	#${Title}=  Run Keyword Unless  ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture') | ('${TEST NAME}'=='Text')   Return Title From Page
	#${Description}=  Return Description From Page
	# ${Content}=  Run Keyword Unless  ('${TEST NAME}'=='Banner') | ('${TEST NAME}'=='ContentCards') | ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture') | ('${TEST NAME}'=='LiftupWithImage') | ('${TEST NAME}'=='ListOfLinks') | ('${TEST NAME}'=='Text')  Add_From_Library.Return Content From Page
	# ${Linktext}=  Run Keyword If  ('${TEST NAME}'=='Banner') | ('${TEST NAME}'=='ListOfLinks')  Return Link Text From Page
	# ${Piccaption}=  Run Keyword If  ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture')  Return Picture Caption From Page
	#Run Keyword Unless  ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture') | ('${TEST NAME}'=='Text')  Title Should Match Current Language Selection   ${Title}
	#Run Keyword Unless  ${islandingpage}  Description Should Match Current Language Selection   ${Description}	
	#Run Keyword If  ${islandingpage} & ('${TEST NAME}'=='Banner')  Description Should Match Current Language Selection   ${Description}
	#Run Keyword If  ${islandingpage} & ('${TEST NAME}'=='Columns')   Content Should Match Current Language Selection   ${Description}
	#Run Keyword Unless  ('${TEST NAME}'=='Banner') | ('${TEST NAME}'=='ContentCards') | ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture') | ('${TEST NAME}'=='LiftupWithImage') | ('${TEST NAME}'=='ListOfLinks') | ('${TEST NAME}'=='Text')  Content Should Match Current Language Selection   ${Content}
	#Run Keyword If  ('${TEST NAME}'=='Banner') | ('${TEST NAME}'=='ListOfLinks')    LinkText Is Correct   ${Linktext}
	#Run Keyword If  ('${TEST NAME}'=='Gallery') | ('${TEST NAME}'=='Picture')   Picture Caption Is Correct   ${Piccaption}
	
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
    ELSE IF  '${TEST NAME}'=='LiftupWithImage'	
    	${title}=   Get Text    ${Txt_LiftupWithImage_Title}
    ELSE IF  '${TEST NAME}'=='ListOfLinks'	
    	${title}=   Get Text    ${Txt_ListOfLinks_Title}
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
	IF    '${TEST NAME}'=='Banner'
		${linktxt}=	 Get Text    ${Txt_Banner_Link}
	ELSE IF   '${TEST NAME}'=='ListOfLinks'
		${linktxt}=	 Get Text    ${Txt_ListOfLinks_Link}
	END
	[Return]		${linktxt}

Return Picture Caption From Page
	${caption}=	 Get Text    ${Txt_Gallery_Image_Caption}
	[Return]		${caption}

Picture Caption Is Correct
	[Arguments]   ${caption}
	Should Contain    ${caption}    ${pic_1_caption_${language}}
	
LinkText Is Correct
	[Arguments]   ${linktext}
	${linktext}=  Replace Encoded Characters From String   ${linktext}   ${EMPTY}    UTF-8    \\xc2\\xad
	IF    '${TEST NAME}'=='Banner'
		Should Match    ${linktext}    Test Automation Banner Link
	ELSE IF   '${TEST NAME}'=='ListOfLinks'
		Should Match    ${linktext}    Linkkiesimerkit
	END