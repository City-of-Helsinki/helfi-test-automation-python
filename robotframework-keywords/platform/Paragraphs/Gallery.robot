*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Create ${pagetype} With Gallery
	Input Non-paragraph Related Content   ${pagetype}
	Open Paragraph For Edit   ${Opt_AddGallery}
	Add Picture 'train' And Caption To 1:th Picture
	Sleep  1   # Added sleep to avoid odd behaviour in page
	Add Picture 'temple' And Caption To 2:th Picture
	Sleep  1   # Added sleep to avoid odd behaviour in page
	Add Picture 'tulips' And Caption To 3:th Picture

Click Edit Paragraph
	Execute javascript  window.scrollTo(0, 1000)
	Click Element   ${Inp_Gallery_Edit}

Add Picture '${name}' And Caption To ${number}:th Picture
	${number}=   Convert To Integer   ${number}
	Run Keyword If  ${number}>=2   Click Element   ${Btn_Gallery_Picture_Addmore}
	${editgalleryvisible}=  Run Keyword And Return Status    Wait Until Element Is Visible  ${Inp_Gallery_Edit}   timeout=3
	Run Keyword If  ${editgalleryvisible}  Wait Until Keyword Succeeds  5x  500ms  Click Edit Paragraph
	Run Keyword If  ${editgalleryvisible}  Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Btn_Gallery_Picture_Addmore}
	Run Keyword If  '${name}'=='tulips'   Sleep   1    # Sleep due issues of missing paragraph in page
	Wait Until Keyword Succeeds  5x  500ms   Open Add Picture To Gallery Window   ${number}
	@{content}=  Set Variable  @{pic_1_texts_${language}}
	${pictitle}=  Get From List  ${content}   0
	${picdescription}=  Get From List  ${content}   1
	${pgrapher}=  Get From List  ${content}   2
	Wait Until Keyword Succeeds  5x  200ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/${name}.jpg
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Pic_Name}   ${pictitle}
	Input Text    ${Inp_Pic_AltText}   ${picdescription} 
	Input Text    ${Inp_Pic_Photographer}   ${pgrapher}
	Click Button   ${Btn_Save}
	Submit New Media
	Wait Until Keyword Succeeds  5x  200ms   Input Text      ${Btn_Gallery_Picture_Caption}   ${pic_1_caption_${language}}
	Set Test Variable  ${picture}    picture
	
Open Add Picture To Gallery Window
	[Arguments]   ${number}
	Wait Until Element Is Visible   ${Btn_Gallery_Picture}
	Wait Until Keyword Succeeds  5x  200ms  Click Element	${Btn_Gallery_Picture}
	Wait Until Keyword Succeeds  5x  300ms  Element Should Be Visible   name:files[upload] 


Take Screenshot Of Content
	Maximize Browser Window
	Wait Until Element Is Visible   ${Itm_Gallery_Slidetrack}   timeout=5
	Execute javascript  document.body.style.zoom="28%"
	${containsarticle}=    Suite Source Contains Text   Article
	Run keyword if  ('${BROWSER}'=='chromeheadless') & (${containsarticle})   Execute javascript   document.body.style.zoom="25%"
	Capture Page Screenshot    filename=${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Execute javascript  document.body.style.zoom="100%"
	
Moving Between Gallery Images Works
	Click Element   //button[@class='splide__arrow splide__arrow--next']
	Sleep   1   # Sleep so that element attribute value is changed
	${value}=  Get Element Attribute  //li[contains(@class, 'is-active is-visible')]//img   src
	Should Contain   ${value}   temple
	Click Element   //button[@class='splide__arrow splide__arrow--prev']
	Sleep   1   # Sleep so that element attribute value is changed
	${value}=  Get Element Attribute  //li[contains(@class, 'is-active is-visible')]//img   src
	Should Contain   ${value}   train	