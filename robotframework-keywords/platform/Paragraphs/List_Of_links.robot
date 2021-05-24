*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***
Create ${pagetype} With List Of Links ${style}
	Set Test Variable  ${style}  ${style}
	Input Non-paragraph Related Content   ${pagetype}
	Open Paragraph For Edit   ${Opt_AddListOfLinks}
	${style}=   Resolve Style Variable   ${style}
	Wait Until Keyword Succeeds  5x  200ms  Select From List By Value  ${Inp_ListOfLinks_Design}  ${style}
	Input Text  ${Inp_ListOfLinks_Link_Uri}   /fi/linkkiesimerkit
	Input Text  ${Inp_ListOfLinks_Link_Title}   Linkkiesimerkit
	Click Element   ${Swh_ListOfLinks_Link_OpenInNewTab}
	Run Keyword If   '${TEST NAME}'=='With Picture'   Add Picture To Link   train
	...   ELSE IF   '${TEST NAME}'!='Without Picture And Description'   Input Text    ${Inp_ListOfLinks_Link_Description}    Siirry linkin sisältöön tästä
	
	
Add Picture To Link
	[Arguments]   ${picname}
	${islandingpage}=  Suite Name Contains Text    Landing Page
	Run Keyword If  ('${picname}'=='tulips') & (not(${islandingpage}))   Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Inp_ListOfLinks_Link_Picture2}
	...			ELSE IF  ('${picname}'=='tulips') & ${islandingpage}   Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Inp_ListOfLinks_Link_Picture2_Landingpage}
	...		 	ELSE IF  not(${islandingpage})  Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Inp_ListOfLinks_Link_Picture}
	...			ELSE     Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Inp_ListOfLinks_Link_Picture_Landingpage}
	Wait Until Keyword Succeeds  5x  200ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/${picname}.jpg
	Wait Until Keyword Succeeds  5x  100ms  Focus  ${Inp_Pic_Name}
	Input Text    ${Inp_Pic_Name}   Juna sillalla
	Input Text    ${Inp_Pic_AltText}   Vanha juna kuljettaa matkustajia 
	Input Text    ${Inp_Pic_Photographer}   Testi Valokuvaaja
	Click Button   ${Btn_Save}
	Wait Until Keyword Succeeds  5x  100ms  Click Button   ${Btn_Insert_Pic}
	Wait Until Element Is Visible  //input[contains(@data-drupal-selector, 'remove-button')]   timeout=3
	Set Test Variable  ${picsadded}    ${picsadded}+1 
	Set Test Variable  ${picture}   picture
	
Resolve Style Variable
	[Arguments]  ${style}
	${style}=  Convert To Lower Case   ${style}
	${stylevariable}=   Set Variable If   '${style}'=='with picture'    with-image
	...			'${style}'=='without picture'    without-image
	...			'${style}'=='without picture and description'    without-image-desc
	[Return]   ${stylevariable}

Add Second Link For Content
	Wait Until Keyword Succeeds  5x  100ms  Click Element  ${Inp_ListOfLinks_Link_NewLink}
	# Better locators does not match correct element. For some reason only first is returned
	# So Only works for second content card.
	${islandingpage}=  Suite Name Contains Text    Landing Page 
	Run Keyword Unless  ${islandingpage}   Wait Until Keyword Succeeds  5x  100ms  Input Text   //input[contains(@data-drupal-selector, 'list-of-links-links-1-subform-field-list-of-links-link-0-uri')]   /fi/esimerkkisivu
	Run Keyword If  ${islandingpage}   Wait Until Keyword Succeeds  5x  100ms  Input Text   //input[contains(@data-drupal-selector, 'list-of-links-links-1-subform-field-list-of-links-link-0-uri')]   /fi/esimerkkisivu
	Run Keyword Unless  ${islandingpage}   Wait Until Keyword Succeeds  5x  100ms  Input Text   //input[contains(@data-drupal-selector, 'list-of-links-links-1-subform-field-list-of-links-link-0-title')]   Esimerkkisivu
	Run Keyword If  ${islandingpage}   Wait Until Keyword Succeeds  5x  100ms  Input Text   name:field_content[0][subform][field_list_of_links_links][1][subform][field_list_of_links_link][0][title]   Esimerkkisivu
	Run Keyword If   '${TEST NAME}'=='With Picture'   Add Picture To Link    tulips
	...   ELSE IF  ('${TEST NAME}'!='Without Picture And Description') & (not(${islandingpage}))   Input Text    ${Inp_ListOfLinks_Link_Description2}    Klikkaa tästä siirtyäksesi
	...   ELSE IF  ${islandingpage} & ('${TEST NAME}'!='Without Picture And Description')   Input Text    name:field_content[0][subform][field_list_of_links_links][1][subform][field_list_of_links_desc][0][value]    Klikkaa tästä siirtyäksesi
	
		
List Of Links Is Working Correctly
	[Documentation]   Linkkiesimerkit is opened in new window when Esimerkkisivu opens in current.
	${contentpageurl}=   Get Location
	Click Element   //a[contains(@href, '/fi/linkkiesimerkit')]
	New Window Should Be Opened    Linkkiesimerkit | Drush Site-Install
	Wait Until Element Is Clickable   //a[contains(@href, '/fi/esimerkkisivu')]
	Click Element   //a[contains(@href, '/fi/esimerkkisivu')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   esimerkkisivu