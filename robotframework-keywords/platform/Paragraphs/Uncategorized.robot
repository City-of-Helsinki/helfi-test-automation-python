*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Take Screenshot Of Content
	Maximize Browser Window
	Execute javascript  document.body.style.zoom="40%"
	Run Keyword If  (('${TEST NAME}'=='Text And Picture') | ('${TEST NAME}'=='Only Picture')) & ('${BROWSER}'=='chromeheadless')   Execute javascript  document.body.style.zoom="30%"
	Capture Screenshot For Picture Comparison
	Execute javascript  document.body.style.zoom="100%"

Start Creating a New ${pagetype} With ${content} Content
	Set Test Variable  ${content}  ${content}
	Input Non-paragraph Related Content   ${pagetype}
	Wait Until Element Is Visible   ${Ddn_AddContent}   timeout=3
	Run Keyword If  '${language}'=='fi'  Click Element	${Ddn_AddContent}
	Run Keyword If  '${content}'=='Text'	Add Text Content To Page
	Run Keyword If  '${content}'=='Picture'	Add Picture Content To Page
	Run Keyword If  '${content}'=='Mixed'	Add Text And Picture To Page

Add Text And Picture To Page
	Add Text Content To Page   cke_66_contents
	Add Picture Content To Page
	
	
Add Text Content To Page
	[Arguments]   ${cke}=cke_67_contents
	${ispage}=  Suite Source Contains Text   Page
	${cke}=  Run Keyword If   ${ispage}   Set Variable  cke_122_contents
	...		ELSE IF  ('${TEST NAME}'=='Text And Picture') & ('${ispage}'=='False')   Set Variable   cke_66_contents
	...		ELSE 	Set Variable   cke_67_contents
	
	
	Run Keyword If  '${language}'=='fi'  Click Element   ${Opt_AddText}
	${TextFileContent}=  Return Correct Content   ${language}
	Wait Until Keyword Succeeds  5x  200ms  Input Text Content To Frame   ${TextFileContent}   ${cke}


Add Picture Content To Page
	${addpicturevisible}=  Run Keyword And Return Status    Wait Until Element Is Visible  ${Opt_AddPicture}   timeout=1
	Run Keyword Unless   ${addpicturevisible}   Click Element   ${Ddn_AddContent}
	Run Keyword If  '${language}'=='fi'  Click Element   ${Opt_AddPicture}
	Run Keyword If  '${content}'=='Picture'   Wait Until Keyword Succeeds  5x  200ms  Click Element  ${Btn_Picture}
	Run Keyword If  '${content}'=='Mixed'     Wait Until Keyword Succeeds  5x  200ms  Click Element  name:field_image-media-library-open-button-field_content-2-subform
	Wait Until Keyword Succeeds  5x  100ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/train.jpg
	Wait Until Keyword Succeeds  5x  100ms  Set Focus To Element  ${Inp_Pic_Name}
	Input Text    ${Inp_Pic_Name}   Juna sillalla
	Input Text    ${Inp_Pic_AltText}   Vanha juna kuljettaa matkustajia 
	Input Text    ${Inp_Pic_Photographer}   Testi Valokuvaaja
	Click Button   ${Btn_Save}
	Wait Until Keyword Succeeds  5x  200ms  Submit New Media
	Run Keyword If  '${content}'=='Picture'  Wait Until Element Is Visible  name:field_image-0-media-library-remove-button-field_content-1-subform   timeout=3
	Run Keyword If  '${content}'=='Mixed'  Wait Until Element Is Visible  name:field_image-0-media-library-remove-button-field_content-2-subform   timeout=3
	
		


