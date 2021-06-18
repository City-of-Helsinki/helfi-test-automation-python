*** Settings ***
Documentation   Handler class for several content handling keywords.
...				Variables:
...				Submitted:  Is the new page submitted. This is needed when tearing down creating content after test.
...				Picalign:   Picture alignment value in hero cases.
...				Picture:    Is at least one picture added to content = picture , else 'nopicture'
...				Picsadded:  Number of pictures added to content. This is needed in teardown after test, so all media
...				Picsize:   Picture size for column pictures. Original=  If use original aspect ratio. Cropped otherwise  
...				gets deleted succesfully. Please note that pictures with greater value of width than length are not 
...				modified in any way by drupal.
...				Linkstyle:	Styling of the link used in some test cases.
...				language:  Not UI language but content translation.
...				gallery:  is gallery paragraph used in this test.  
Resource        Commonkeywords.robot
Resource		  ./variables/create_content.robot
Library           DocTest.VisualTest
Library           OperatingSystem
Library			  Collections

*** Variables ***
${submitted}								false
${picalign} 		 						${EMPTY}
${picture} 			 						nopicture
${picsadded}								0
${videosadded}								0
${pagesadded}								0
${picsize}									cropped
${linkstyle} 		 						${EMPTY}
${language}	 		 						fi
${gallery}									false
${serviceispublished}						false
@{excludetaglist}     					    ARTICLE
${URL_login_page}							${PROTOCOL}://${BASE_URL}/fi
${URL_content_page}							${PROTOCOL}://${BASE_URL}/fi/admin/content
${URL_media_page}							${PROTOCOL}://${BASE_URL}/fi/admin/content/media		
*** Keywords ***

Open Paragraph For Edit
	[Arguments]   ${paragraph}
	Wait Until Element Is Visible   ${Ddn_AddContent}   timeout=3
	Click Element	${Ddn_AddContent}
	Click Element   ${paragraph}

Input Title To Paragraph
	[Arguments]    ${paragraph_title_locator}
	${title}=  Return Correct Title   ${language}
	Input Text  ${paragraph_title_locator}   ${title}

Input Description To Paragraph
	[Arguments]    ${paragraph_description_locator}
	${TextFileDescription}=  Return Correct Description   ${language}
	Input Text To Frame   ${paragraph_description_locator}   //body   ${TextFileDescription}

Input Title
	[Arguments]   ${title}
	Wait Until Element Is Visible   ${Inp_Title}   timeout=3  
	Input Text  ${Inp_Title}   ${title}  

Input Author
	[Arguments]   ${author}
	Wait Until Element Is Visible   ${Inp_Author}   timeout=3  
	Input Text  ${Inp_Author}   ${author}  

Input Lead
	[Arguments]   ${lead}
	Wait Until Element Is Visible   ${Inp_Lead}   timeout=3  
	Input Text  ${Inp_Lead}   ${lead} 

Input Content Header Title
	[Arguments]   ${content}
	Input Text To Frame   ${Frm_Content}   //body   ${content}
	
Go To Translations Tab
	Click Button   //a[contains(text(),'Translate')]	
	
Go To ${language} Translation Page
	${language_pointer}=  Get Language Pointer   ${language}
	Click Element   //a[contains(@href, 'translations/add/fi/${language_pointer}')]
		
Cleanup and Close Browser
	[Documentation]  Deletes content created by testcases. Page , if created and picture if added.
	Run Keyword If   ${DEBUG}   Run Keyword If Test Failed   Debug Error
	FOR    ${i}    IN RANGE    ${pagesadded}
           Wait Until Keyword Succeeds  2x  200ms 	Delete Newly Created Item on Content Menu List
    END
	FOR    ${i}    IN RANGE    ${picsadded}
           Wait Until Keyword Succeeds  2x  200ms 	Delete Newly Created Item from Content Media List
    END
    FOR    ${i}    IN RANGE    ${videosadded}
           Wait Until Keyword Succeeds  2x  200ms 	Delete Newly Created Item from Content Media List
    END
    # in case of service/unit testcases
    ${serviceispublished}=   Convert To Boolean   ${serviceispublished}
    Run Keyword If  ${serviceispublished}  Set Service Back To Unpublished
	Close Browser	
	
Set Service Back To Unpublished
	Goto  https://helfi.docker.sh/fi/admin/content/integrations/tpr-service/1/edit
	Set Content As Published
	Submit New Content
	
Image Comparison Needs To Exclude Areas
	[Documentation]   Image Comparison needs to exclude some parts of the picture in case of for example changing date
	... 			  values and such which cause the test to fail in comparion stage. For this reason we check if
	...				  excluding is needed and save possible excludetag in test variable so that right parts will later
	...				  be excluded
	Log List   ${TEST TAGS}
	${count}=  Get Length   ${excludetaglist}
	FOR    ${i}    IN RANGE    ${count}
		   ${tag}=  Get From List  ${excludetaglist}   ${i}	
           ${status}=   Run Keyword And Return Status   Should Contain Match   ${TEST TAGS}    ${tag}
           Run Keyword If   '${status}'=='True'   Set Test Variable   ${excludetag}    ${tag}
           Exit For Loop If   '${status}'=='True'   
    END
    [Return]   ${status}

Click Content Link From Notification Banner
	Wait Until Element Is Visible   css:div.messages__content > em > a
	Wait Until Keyword Succeeds  5x  200ms  Click Element   css:div.messages__content > em > a
	Element Should Not Be Visible   //a[contains(@href, '/node/add')]

Accept Cookies
	Wait Until Keyword Succeeds  5x  400ms  Click Button  //button[@class='agree-button eu-cookie-compliance-default-button hds-button hds-button--primary']

Open Created Content
	Run Keyword Unless  ${CI}  Open Content In Non CI Environments
	Run Keyword If   (${CI}) & ('${language}'=='fi')  	Accept Cookies
	Run Keyword If   ${CI}  Reload Page
	  
Log In
	Wait Until Keyword Succeeds  5x  200ms  Input Text   id:edit-name   helfi-admin
	Input Password   id:edit-pass   Test_Automation
	Click Button   id:edit-submit

Open Content In Non CI Environments
	[Documentation]   Goes to content view of created content through content list page (since local environment errors prevent
	...				  viewing it directly after creation)
	
	Go To   ${URL_content_page}
	Wait Until Keyword Succeeds  5x  200ms  Click Content Link From Notification Banner
	Run Keyword If  '${language}'=='fi'  	Accept Cookies
	
Get Language Pointer
	[Arguments]     ${language}
	[Documentation]  fi = Finnish is default
	${language_pointer}=  Set Variable If  '${language}'=='Finnish'   fi
	...		'${language}'=='Swedish'   sv
	...		'${language}'=='English'   en
	...		'${language}'=='Russian'   ru
	[Return]   ${language_pointer}

Set Language Pointer
	[Arguments]     ${language}
	[Documentation]  Language to set to Test Variable
	${language_pointer}=  Set Variable If  '${language}'=='Finnish'   fi
	...		'${language}'=='Swedish'   sv
	...		'${language}'=='English'   en
	...		'${language}'=='Russian'   ru
	Set Test Variable   ${language}   ${language_pointer}
	
	
Compared Pictures Match
	[Documentation]   Tests that two pictures look same --> layout is not broken
	[Arguments]	   ${pic1}   ${pic2}    ${excludefilepath}=${EMPTY}   ${movetolerance}=${EMPTY}
	IF    ('${excludefilepath}'!='${EMPTY}') & ('${movetolerance}'!='${EMPTY}')
        Compare Images      ${pic1}   ${pic2}   placeholder_file=${excludefilepath}   move_tolerance=${movetolerance}
    ELSE IF    ('${excludefilepath}'!='${EMPTY}') & ('${movetolerance}'=='${EMPTY}')
        Compare Images      ${pic1}   ${pic2}   placeholder_file=${excludefilepath}
    ELSE IF    ('${excludefilepath}'=='${EMPTY}') & ('${movetolerance}'!='${EMPTY}')
        Compare Images      ${pic1}   ${pic2}   move_tolerance=${movetolerance}
    ELSE
    	Compare Images      ${pic1}   ${pic2}
    END 
    

Go To New Article Site
	Click Add Content
	Wait Until Keyword Succeeds  5x  200ms  Click Add Article

Go To New Page Site
	Click Add Content
	Wait Until Keyword Succeeds  5x  200ms  Click Add Page

Go To New Service Site
	Click Add Content
	Wait Until Keyword Succeeds  5x  200ms  Click Add Service

Go To New LandingPage Site
	Click Add Content
	Wait Until Keyword Succeeds  5x  200ms  Click Add Landing Page

Click Add Content
	[Documentation]   Add Content ('Lisää sisältöä') in Content Menu
	Wait Until Element Is Visible   css:#block-hdbt-admin-local-actions > ul > li > a   timeout=3
	Wait Until Keyword Succeeds  5x  200ms  Click Element  css:#block-hdbt-admin-local-actions > ul > li > a
	
   
Click Add Page
	[Documentation]   Add Page ('Sivu') click in Add Content('Lisää sisältöä') -menu
	Wait Until Element Is Visible  //a[contains(@href, '/node/add/page')][@class='admin-item__link']   timeout=3
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/node/add/page')][@class='admin-item__link']
	Element Should Not Be Visible   //a[contains(@href, '/node/add/page')][@class='admin-item__link']

Click Add Service
	Wait Until Element Is Visible  //a[contains(@href, '/node/add/service')][@class='admin-item__link']   timeout=3
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/node/add/service')][@class='admin-item__link']
	Element Should Not Be Visible   //a[contains(@href, '/node/add/service')][@class='admin-item__link']

Click Add Landing Page
	[Documentation]   Add LandingPage ('Laskeutumissivu') click in Add Content('Lisää sisältöä') -menu
	Wait Until Element Is Visible  //a[contains(@href, '/node/add/landing_page')][@class='admin-item__link']   timeout=3
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/node/add/landing_page')][@class='admin-item__link']
	Element Should Not Be Visible   //a[contains(@href, '/node/add/landing_page')][@class='admin-item__link']

	
Click Add Article
	[Documentation]   Add Article ('Artikkeli') click in Add Content('Lisää sisältöä') -menu
	Wait Until Element Is Visible  //a[contains(@href, '/node/add/article')][@class='admin-item__link']   timeout=3
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/node/add/article')][@class='admin-item__link']
	Element Should Not Be Visible   //a[contains(@href, '/node/add/article')][@class='admin-item__link']

Go To Translate Selection Page
	[Documentation]   Goes To Translations Page for first document in the content list
	Go To   ${URL_content_page}
	Click Button   ${Btn_Actions_Dropbutton}
	Click Element  ${Btn_Actions_ContentMenu_Translatebutton}

Submit The New ${pagetype}
	[Documentation]   Sleeps 1 second in case of pictures added so that they have time to load into content view.
	Run Keyword If  ${picsadded} > 0   Sleep  1
	Wait Until Keyword Succeeds  2x  1  Submit New Content

Submit New Content
	[Documentation]  User submits new page and it is saved and appears in content view
	Wait Until Keyword Succeeds  5x  100ms  Click Button   ${Btn_Submit}
	Wait Until Keyword Succeeds  5x  100ms  Element Should Not Be Visible   ${Btn_Submit}
	${isserviceandunit}=  Suite Name Contains Text  ServiceAndUnit
	Run Keyword Unless  ${isserviceandunit}  Set Test Variable  ${pagesadded}    ${pagesadded}+1
		
Go To New ${pagetype} -View For ${language} Translation
	Go To Translate Selection Page
	Go To ${language} Translation Page
	
Delete Newly Created Item on Content Menu List
	[Documentation]   Deletes Created Item By assuming it is the topmost one in the list. Returns to content page afterwards.
	Go To   ${URL_content_page}
	Click Button   ${Btn_Actions_Dropbutton}
	Click Element  ${Btn_Actions_ContentMenu_Deletebutton}
	Click Element  ${Btn_Actions_SelectedItem_Deletebutton}
	Go To   ${URL_content_page}
	
Delete Newly Created Item from Content Media List
	Go To   ${URL_media_page}
	Wait Until Keyword Succeeds  5x  200ms  Click Button   ${Btn_Actions_Dropbutton}
	Click Element  ${Btn_Actions_ContentMenu_Deletebutton}
	Click Element  ${Btn_Actions_SelectedItem_Deletebutton}
	Go To   ${URL_media_page}	
	
Copy Original Screenshot To Reports Folder
	[Arguments]     ${source}
	Copy File    ${source}    ${REPORTS_PATH}/originals/

Get Admin Url
   [Documentation]   Gets URL needed in localhost testing.
   ${admin_url} =   Run  ${ADMIN_URL}
   Set Test Variable   ${admin_url}

Set Content As Published
	Click Element   id:edit-status
	Set Test Variable  ${serviceispublished}   true

Select Language
	[Arguments]     ${value}
	[Documentation]  fi = Finnish , sv = Swedish , en = English , ru = Russian
	Run Keyword If  '${value}'=='Finnish'  Click Element  css:[lang|=fi]
	Run Keyword If  '${value}'=='Swedish'  Click Element  css:[lang|=sv]
	Run Keyword If  '${value}'=='English'  Click Element  css:[lang|=en]
	Run Keyword If  '${value}'=='Russian'  Click Element  css:[lang|=ru]

Return Correct Title
	[Arguments]     ${language}
	${title}=	Set Variable If  '${language}'=='fi'  Juhani Aho: Rautatie
	...				'${language}'=='en'  Emily Bronte: Wuthering Heights
	...		 		'${language}'=='sv'  Selma Lagerlof: Bannlyst
	[Return]		${title}

Return Correct Description
	[Arguments]     ${language}
	${description}=	Get File  ${CONTENT_PATH}/text_description_short_${language}.txt
	[Return]		${description}

Return Correct Content
	[Arguments]     ${language}
	${content}=	Get File  ${CONTENT_PATH}/text_content_short_${language}.txt
	[Return]		${content}

Return Content From Page	
	${content}=	Get Text    ${Txt_Content}
	[Return]		${content}

Title Should Match Current Language Selection
	[Arguments]   ${string}
	${string}=  Replace Encoded Characters From String   ${string}   ${EMPTY}    UTF-8    \\xc2\\xad
	Run Keyword If  '${language}'=='fi'  Should Match Regexp   ${string}   Juhani Aho: Rautatie
	Run Keyword If  '${language}'=='en'  Should Match Regexp   ${string}   Emily Bronte: Wuthering Heights
	Run Keyword If  '${language}'=='sv'  Should Match Regexp   ${string}   Selma Lagerlof: Bannlyst  

Description Should Match Current Language Selection
	[Arguments]   ${string}
	Run Keyword If  '${language}'=='fi'  Should Match Regexp  ${string}   "Rautatie" on Juhani Ahon
	Run Keyword If  '${language}'=='en'  Should Match Regexp  ${string}   In the late winter months
	Run Keyword If  '${language}'=='sv'  Should Match Regexp  ${string}   Sven Elversson var nära att dö under en nordpolsexpedtion

Content Should Match Current Language Selection
	[Arguments]   ${string}
	Run Keyword If  '${language}'=='fi'  Should Match Regexp  ${string}   Sitä Matti ajatteli, mitä rovastin ja ruustinnan kanssa oli puhunut
	Run Keyword If  '${language}'=='en'  Should Match Regexp  ${string}   “It is not,” retorted she
	Run Keyword If  '${language}'=='sv'  Should Match Regexp  ${string}   På Grimön i den västra skärgården bodde

Login And Go To Content Page
	[Documentation]   Preparatory action for platform tests: User logs in and then navigates to Content('Sisältö')
	...				  page.
	Get Admin Url
	Run Keyword If   ${CI}   Log-In In CI Environment
	Run Keyword Unless   ${CI}   Open Browser  ${admin_url}  ${BROWSER}
	Go To   ${URL_content_page}
	Set Window Size   1296   696
	
Log-In In CI Environment
    ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --headless
    Open Browser    ${URL_login_page}    chrome    options=${chrome_options}
    Log In
	
Rename Picture With New Name
	[Documentation]   Idea is to Replace Reports file picture with new name in order to help in 
	...				  maintenance of comparison pictures
	[Arguments]   ${originalpic}   ${comparisonpic}
	${newname}=  Fetch From Right   ${originalpic}   ${BROWSER}/   
	Move File   ${comparisonpic}   ${REPORTS_PATH}/${newname}

Select Icon With Name
	[Arguments]   ${icon_name}
	Click Element With Value   ${icon_name}
	
Take Screenshot Of Content
	Maximize Browser Window
	Execute javascript  document.body.style.zoom="30%"
	Capture Page Screenshot    filename=${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Execute javascript  document.body.style.zoom="100%"

New Window Should Be Opened
	[Arguments]   ${title}
	${titles}=  Get Window Titles
	Should Contain   ${titles}   ${title}
	
# COLUMNS RELATED
	
Add ${content} to Left Column
	[Documentation]  Here we need to do some tricks in case picture tests original size. Content -string is modified
	...				 so that picture compare assertion works. Also long, snowdrops picture is used in the case because
	...				 pictures with longer width value does not get cropped. Only long pictures do.
	${content}=  Convert To Lower Case   ${content}
	Wait Until Keyword Succeeds  5x  100ms  Click Button  ${Ddn_Column_Left_AddContent}
	Run Keyword If  '${content}'=='picture'  Add Picture to Column   Left    train   @{pic_1_texts_${language}}
	Run Keyword If  '${content}'=='original picture'  Add Picture to Column   Left    snowdrops   @{pic_1_texts_${language}}
	Run Keyword If  '${content}'=='text'  Add Text Content To Column on Left
	Run Keyword If  ('${content}'=='picture') & ('${language}'=='fi')  Add Picture Caption to Left
	${content}=  Remove String And Strip Text   ${content}   original
	Set Test Variable  ${content1}   ${content}
	
Add ${content:[^"]+} to Right Column
	[Documentation]   Adds given content to Right column.
	${content}=  Convert To Lower Case   ${content}
	Set Test Variable  ${content2}   ${content}
	Wait Until Element Is Visible  ${Ddn_Column_Right_AddContent}   timeout=3
	Wait Until Keyword Succeeds  10x  500ms  Click Button  ${Ddn_Column_Right_AddContent}
	Run Keyword If  '${content}'=='picture'  Add Picture to Column   Right    temple   @{pic_2_texts_${language}}
	Run Keyword If  '${content}'=='text'  Add Text Content To Column on Right
	Run Keyword If  '${content}'=='link'  Add "${linkstyle}" Link To Right Column
	
Add Picture to Column
	[Documentation]  Adds picture and fills given content. selection= picture name from images -folder at src/main/
	...			     resources.  side = 'left' of 'right' column  . content = content as list items.    
	[Arguments]     ${side}   ${selection}   @{content}
	Wait Until Element Is Visible  ${Opt_Column_${side}_AddContent_Image}   timeout=3
	Click Element  ${Opt_Column_${side}_AddContent_Image}
	${pictitle}=  Get From List  ${content}   0
	${picdescription}=  Get From List  ${content}   1
	${pgrapher}=  Get From List  ${content}   2
	Wait Until Element Is Visible  ${Btn_Column_${side}_Picture}   timeout=3
	Wait Until Keyword Succeeds  10x  500ms  Click Element  ${Btn_Column_${side}_Picture}
	Wait Until Keyword Succeeds  10x  500ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/${selection}.jpg
	Wait Until Keyword Succeeds  10x  500ms  Input Text    ${Inp_Pic_Name}   ${pictitle}
	Input Text    ${Inp_Pic_AltText}   ${picdescription} 
	Input Text    ${Inp_Pic_Photographer}   ${pgrapher}
	Click Button   ${Btn_Save}
	Set Test Variable  ${picsadded}    ${picsadded}+1
	Set Test Variable  ${picture}    picture   
	Wait Until Keyword Succeeds  10x  500ms  Click Button   ${Btn_Insert_Pic}
	Wait Until Keyword Succeeds  10x  500ms   Add Picture Caption to ${side}  
	

Add Picture Caption to ${side}
	${editpicturevisible}=  Run Keyword And Return Status    Element Should Not Be Visible  ${Btn_Column_${side}_Edit}   timeout=1
	Run Keyword Unless   ${editpicturevisible}   Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Btn_Column_${side}_Edit}
	Run Keyword If  '${side}'=='Left'	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Column_Left_Picture_Caption}   ${pic_1_caption_${language}}
	Run Keyword If  '${side}'=='Right'	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Column_Right_Picture_Caption}   ${pic_2_caption_${language}}
	
Add Text Content To Column on ${side}
	[Documentation]   Adds text content to selected column by selecting content type first and then inserting text
	Run Keyword If  '${language}'=='fi'  Click And Select Text As ${side} Content Type
	${TextFileContent}=  Get File  ${CONTENT_PATH}/text_content_short_${language}.txt
	@{content} =	Split String	${TextFileContent}   .,.
	${content_left}=  Get From List  ${content}   0
	${content_right}=  Get From List  ${content}   1
	${content_text}=  Set Variable If
	... 	 '${side}'=='Left'	${content_left}
	... 	 '${side}'=='Right'	${content_right}
	${editpicturevisible}=  Run Keyword And Return Status    Element Should Not Be Visible  ${Btn_Column_${side}_Edit}   timeout=1
	Run Keyword Unless   ${editpicturevisible}   Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Btn_Column_${side}_Edit}
	Wait Until Keyword Succeeds  10x  500ms  Input Text To Frame   ${Frm_Column_${side}_Text}   //body   ${content_text}
	
Click And Select Text As ${side} Content Type
	Wait Until Element Is Visible  ${Opt_Column_${side}_AddContent_Text}   timeout=3
	Wait Until Keyword Succeeds  3x  100ms  Click Element  ${Opt_Column_${side}_AddContent_Text}
	
Compare Pictures And Handle PictureData
	[Arguments]   ${originalpic}   ${comparisonpic}   ${excludefilepath}=${EMPTY}   ${movetolerance}=${EMPTY}	
	Copy Original Screenshot To Reports Folder   ${originalpic}
	Compared Pictures Match   ${originalpic}    ${comparisonpic}   ${excludefilepath}   ${movetolerance}
	Run Keyword If   ${USEORIGINALNAME}   Rename Picture With New Name   ${originalpic}   ${comparisonpic}
	

Input Text Content To Frame
	[Arguments]   ${content}    ${cke}
	Input Text To Frame   css:#${cke} > iframe   //body   ${content}
		
Input Non-paragraph Related Content
	[Arguments]   ${pagetype}
	Input Title  Test Automation: ${TEST NAME}
	Run Keyword If  '${pagetype}'=='Article'   Set Article Spesific Values
	${headertitle}=  Get File  ${CONTENT_PATH}/text_description_short_${language}.txt
	${islandingpage}=  Suite Name Contains Text    Landing Page
	Run Keyword Unless  ${islandingpage}   Input Content Header Title  ${headertitle}	
	
Set Article Spesific Values
	Input Author   Test Automation Author
	${ingress}=  Get File  ${CONTENT_PATH}/text_ingress_${language}.txt
	Input Lead   ${ingress}