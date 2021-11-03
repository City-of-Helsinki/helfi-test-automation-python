*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Create Unit Search Paragraph
	[Arguments]	  ${pagetype}
	Input Non-paragraph Related Content   ${pagetype}
	Run Keyword If  '${language}'=='fi'  Open Paragraph For Edit   ${Opt_UnitSearch}
	Wait Until Keyword Succeeds  5x  200ms  Input Title To Paragraph   ${Inp_UnitSearch_Title}
	Select From List By Index   ${Sel_UnitSearch_Units}   0
	Select From List By Index   ${Sel_UnitSearch_Units}   1
	${TextFileContent}=  Return Correct Content   ${language}
	Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   ${Frm_UnitSearch_Content}   //body   ${TextFileContent}
	
	
Unit Links Are Working Correctly
	${contentpageurl}=   Get Location
	Click Element   //a[contains(@href, '/fi/lippulaivan-kirjasto')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   lippulaivan-kirjasto
	Goto   ${contentpageurl}
	Click Element   //a[contains(@href, '/fi/otaniemen-kirjasto')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   otaniemen-kirjasto
	Goto   ${contentpageurl}
	
The Search Bar Is Working Correctly
	Search Bar Works By Unit Name
	Clear Element Text   ${Inp_UnitSearch_SearchField}
	Search Bar Works By Unit Address
	Clear Element Text   ${Inp_UnitSearch_SearchField}
	Search Bar Works By Unit Post Number
	Clear Element Text   ${Inp_UnitSearch_SearchField}
	Click Button   ${Inp_UnitSearch_SearchButton}
	Wait Until Keyword Succeeds  5x  200ms  Page Should Contain Link   Lippulaivan kirjasto
	Wait Until Keyword Succeeds  5x  200ms  Page Should Contain Link   Otaniemen kirjasto

Search Bar Works By Unit Name
	Input Text  ${Inp_UnitSearch_SearchField}   Otan
	Click Button   ${Inp_UnitSearch_SearchButton}
	Wait Until Keyword Succeeds  5x  200ms  Page Should Not Contain Link   Lippulaivan kirjasto
	Wait Until Keyword Succeeds  5x  200ms  Page Should Contain Link   Otaniemen kirjasto
	
Search Bar Works By Unit Address
	Input Text  ${Inp_UnitSearch_SearchField}   merikar
	Click Button   ${Inp_UnitSearch_SearchButton}
	Wait Until Keyword Succeeds  5x  200ms  Page Should Not Contain Link   Otaniemen kirjasto
	Wait Until Keyword Succeeds  5x  200ms  Page Should Contain Link   Lippulaivan kirjasto

Search Bar Works By Unit Post Number
	Sleep  0.2
	Input Text  ${Inp_UnitSearch_SearchField}   02150
	Click Button   ${Inp_UnitSearch_SearchButton}
	Wait Until Keyword Succeeds  5x  200ms  Page Should Contain Link   Otaniemen kirjasto
	Wait Until Keyword Succeeds  5x  200ms  Page Should Not Contain Link   Lippulaivan kirjasto
	
Unit Address And Phone Data Is Correct
	Input Text  ${Inp_UnitSearch_SearchField}   Otan
	Click Button   ${Inp_UnitSearch_SearchButton}
	Wait Until Keyword Succeeds  5x  200ms  Page Should Not Contain Link   Lippulaivan kirjasto
	${addressline1}=  Get Text   css:.address-line1
	${postalcode}=  Get Text   css:.postal-code
	${city}=  Get Text   css:.locality
	Click Link   Otaniemen kirjasto
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   otaniemen-kirjasto
	${addressline1_unitsite}=  Get Text   css:.address-line1
	${postalcode_unitsite}=  Get Text   css:.postal-code
	${city_unitsite}=  Get Text   css:.locality
	${phone_unitsite}=  Get Text   css:div.unit__sidebar > div > div.unit__contact-row.unit__contact-row--phone > a
	Should Be Equal   ${addressline1}   ${addressline1_unitsite}
	Should Be Equal   ${postalcode}   ${postalcode_unitsite}
	Should Be Equal   ${city}   ${city_unitsite}
	Should Not Be Empty   ${phone_unitsite}
	