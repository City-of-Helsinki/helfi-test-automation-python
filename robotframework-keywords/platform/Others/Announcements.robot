*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Create Announcement
	[Documentation]    type=notification,attention,alert , showonallpages= should announcement be shown on all pages, Is announcement published
	[Arguments]   ${name}	${lang_selection}    ${type}    ${showonallpages}=True    ${published}=True
	Input Text   ${Inp_Announcement_Title}   ${name}
	Run Keyword Unless  '${lang_selection}'=='Finnish'   Select From List By Label   ${Ddn_Announcement_Language}   ${lang_selection}
	${type}=  Convert To Lower Case   ${type}
	Select From List By Value    name:field_announcement_type   ${type}
	Run Keyword Unless  ${showonallpages}   Click Element  ${Swh_Announcement_Visibility}
	Run Keyword Unless  ${showonallpages}   Select Content To Show The Announcement For
	${TextFileContent}=  Get File  ${CONTENT_PATH}/text_content_short_${language}.txt
	Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   css:#cke_1_contents > iframe   //body   ${TextFileContent}
	Run Keyword Unless  ${published}   Click Element  id:edit-status-value

Select Content To Show The Announcement For
	Wait Until Keyword Succeeds  5x  200ms  Input Text  css:#edit-field-announcement-content-pages-wrapper > div > span > span.selection > span > ul > li > input   Esimerkkisivu
	Input Text  css:#edit-field-announcement-unit-pages-wrapper > div > span > span.selection > span > ul > li > input   Peijaksen sairaala
	Input Text  css:#edit-field-announcement-service-pages-wrapper > div > span > span.selection > span > ul > li > input   Ompeleiden poisto
	Capture Page Screenshot
	
Add Link To Announcement
	[Arguments]   ${url}	${title}   
	 Input Text   ${Inp_Announcement_Link_Url}   ${url}
	 Input Text   ${Inp_Announcement_Link_Title}   ${title}

Add ${lang_selection} Translation For The Announcement
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Wait Until Keyword Succeeds  5x  200ms  Go To Translations Tab
	Wait Until Keyword Succeeds  5x  200ms  Go To ${lang_selection} Translation Page
	${TextFileContent}=  Get File  ${CONTENT_PATH}/text_content_short_${language}.txt
	Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   css:#cke_1_contents > iframe   //body   ${TextFileContent}
	Submit The New Announcement

Modify Announcement Text
	[Documentation]    Assuming automation is currently at announcement content view
	Wait Until Keyword Succeeds  5x   200ms   Run Keyword And Ignore Error   Accept Cookies
	Wait Until Keyword Succeeds  5x  200ms  Go To Modify Tab
	Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   css:#cke_1_contents > iframe   //body   Modified Content For Announcement
	Wait Until Keyword Succeeds  5x  100ms  Click Button   ${Btn_Submit}
	Wait Until Keyword Succeeds  5x  100ms  Element Should Not Be Visible   ${Btn_Submit}
	
Announcement Is Visible For ${contentname} Of ${contenttype} List
        Check Announcement Visibility For Given Content   ${contentname}   ${contenttype}

Announcement Is Not Visible For ${contentname} Of ${contenttype} List
        Check Announcement Visibility For Given Content   ${contentname}   ${contenttype}   False

Annoucement Text Content Equals
	[Arguments]   ${content}
	${announcementtext}=  Get Text  css:#block-announcements > div > div > span > p
	Should Be Equal   ${announcementtext}   ${content}  

Check Announcement Visibility For Given Content
	[Arguments]   ${contentname}    ${contenttype}   ${shouldbevisible}=True
	IF    '${contenttype}'=='User Created Content'
        Go To   ${URL_content_page}
    ELSE IF    '${contenttype}'=='Service'
        Go To   ${URL_service_page}
    ELSE IF    '${contenttype}'=='Unit'
    	Go To   ${URL_unit_page}
    END 
    Wait Until Keyword Succeeds  5x   200ms   Click Link   ${contentname}
	Wait Until Keyword Succeeds  5x   200ms   Run Keyword And Ignore Error   Accept Cookies
    IF    ${shouldbevisible}
        Element Should Be Visible   css:#block-announcements > div
    ELSE
    	Element Should Not Be Visible   css:#block-announcements > div
    END