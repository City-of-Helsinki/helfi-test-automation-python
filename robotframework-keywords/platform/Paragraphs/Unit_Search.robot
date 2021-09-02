*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Create Unit Search Paragraph
	[Arguments]	  ${pagetype}
	Input Non-paragraph Related Content   ${pagetype}
	Run Keyword If  '${language}'=='fi'  Open Paragraph For Edit   ${Opt_UnitSearch}
	Run Keyword If  '${pagetype}'!='LandingPage'  Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph   ${Inp_UnitSearch_Title}
	Run Keyword If  '${pagetype}'=='LandingPage'  Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph   ${Inp_UnitSearch_Title_Landingpage}
	Run Keyword If  '${pagetype}'!='LandingPage'  Select From List By Index   name:field_content[1][subform][field_unit_search_units][]   0
	Run Keyword If  '${pagetype}'!='LandingPage'  Select From List By Index   name:field_content[1][subform][field_unit_search_units][]   1
	Run Keyword If  '${pagetype}'=='LandingPage'  Select From List By Index   name:field_content[0][subform][field_unit_search_units][]   0
	Run Keyword If  '${pagetype}'=='LandingPage'  Select From List By Index   name:field_content[0][subform][field_unit_search_units][]   1
	${TextFileContent}=  Return Correct Content   ${language}
	Run Keyword If  '${pagetype}'=='Page'   Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   ${Frm_UnitSearch_Content}   //body   ${TextFileContent}
	Run Keyword If  '${pagetype}'=='Article'   Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   css:#cke_68_contents > iframe   //body   ${TextFileContent}
	Run Keyword If  '${pagetype}'=='LandingPage'   Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   ${Frm_Content}   //body   ${TextFileContent}
	
	
Unit Links Are Working Correctly
	${contentpageurl}=   Get Location
	Click Element   //a[contains(@href, '/fi/paloheinan-kirjasto')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   paloheinan-kirjasto
	Goto   ${contentpageurl}
	Click Element   //a[contains(@href, '/fi/tapanilan-kirjasto')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   tapanilan-kirjasto
	Goto   ${contentpageurl}
	
The Search Bar Is Working Correctly
	Search Bar Works By Unit Name
	Clear Element Text   ${Inp_UnitSearch_SearchField}
	Search Bar Works By Unit Address
	Clear Element Text   ${Inp_UnitSearch_SearchField}
	Search Bar Works By Unit Post Number
	Clear Element Text   ${Inp_UnitSearch_SearchField}
	Click Button   ${Inp_UnitSearch_SearchButton}
	Wait Until Keyword Succeeds  5x  200ms  Page Should Contain Element   //a[contains(@href, '/fi/paloheinan-kirjasto')]
	Wait Until Keyword Succeeds  5x  200ms  Page Should Contain Element   //a[contains(@href, '/fi/tapanilan-kirjasto')]

Search Bar Works By Unit Name
	Input Text  ${Inp_UnitSearch_SearchField}   Tapa
	Click Button   ${Inp_UnitSearch_SearchButton}
	Wait Until Keyword Succeeds  5x  200ms  Page Should Not Contain Element   //a[contains(@href, '/fi/paloheinan-kirjasto')]
	Wait Until Keyword Succeeds  5x  200ms  Page Should Contain Element   //a[contains(@href, '/fi/tapanilan-kirjasto')]
	
Search Bar Works By Unit Address
	Input Text  ${Inp_UnitSearch_SearchField}   hiiden
	Click Button   ${Inp_UnitSearch_SearchButton}
	Wait Until Keyword Succeeds  5x  200ms  Page Should Not Contain Element   //a[contains(@href, '/fi/paloheinan-kirjasto')]
	Wait Until Keyword Succeeds  5x  200ms  Page Should Contain Element   //a[contains(@href, '/fi/tapanilan-kirjasto')]

Search Bar Works By Unit Post Number
	Sleep  0.2
	Input Text  ${Inp_UnitSearch_SearchField}   00670
	Click Button   ${Inp_UnitSearch_SearchButton}
	Wait Until Keyword Succeeds  5x  200ms  Page Should Contain Element   //a[contains(@href, '/fi/paloheinan-kirjasto')]
	Wait Until Keyword Succeeds  5x  200ms  Page Should Not Contain Element   //a[contains(@href, '/fi/tapanilan-kirjasto')]
	
Unit Address And Phone Data Is Correct
	${addressline1}=  Get Text   css:.address-line1
	${postalcode}=  Get Text   css:.postal-code
	${city}=  Get Text   css:.locality
	${phone}=  Get Text   css:.phones > a
	Click Element   //a[contains(@href, '/fi/paloheinan-kirjasto')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   paloheinan-kirjasto
	${addressline1_unitsite}=  Get Text   css:.address-line1
	${postalcode_unitsite}=  Get Text   css:.postal-code
	${city_unitsite}=  Get Text   css:.locality
	${phone_unitsite}=  Get Text   css:div.unit__sidebar > div > div.unit__contact-row.unit__contact-row--phone > a
	Should Be Equal   ${addressline1}   ${addressline1_unitsite}
	Should Be Equal   ${postalcode}   ${postalcode_unitsite}
	Should Be Equal   ${city}   ${city_unitsite}
	Should Be Equal   ${phone}   ${phone_unitsite}
	