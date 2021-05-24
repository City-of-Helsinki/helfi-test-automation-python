*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Variables ***
${color}	 		 ${EMPTY}

*** Keywords ***

Create Service With Language
	[Documentation]   Parent Service Is Optional. Leave empty if not needed.
	[Arguments]  ${language}
	Set Language Pointer   ${language}
	Input Title To Paragraph   ${Inp_Service_Title}
	Input Text   ${Inp_Service_Visible_Title}   Test Automation: ${TEST NAME}
	Service.Select Language   ${language}
	Input Description To Paragraph   ${Frm_Content}
	Input Text Content
	
Add ${service} as Parent Service
	Input Text  ${Inp_Service_ParentService}   Esimerkkipalvelu
	Wait Until Keyword Succeeds  5x  200ms  Click Element   //a[contains(text(),'Esimerkkipalvelu')]
		
Select Language
	[Arguments]     ${value}
	[Documentation]  fi = Finnish , sv = Swedish , en = English , ru = Russian
	Run Keyword If  '${value}'=='Finnish'  Select From List By Value  id:edit-langcode-0-value  fi
	Run Keyword If  '${value}'=='Swedish'  Select From List By Value  id:edit-langcode-0-value  sv
	Run Keyword If  '${value}'=='English'  Select From List By Value  id:edit-langcode-0-value  en
	Run Keyword If  '${value}'=='Russian'  Select From List By Value  id:edit-langcode-0-value  ru
	
Input Text Content
	${content}=  Return Correct Content   ${language}
	Input Text To Frame   ${Frm_Content2}   //body   ${content}
