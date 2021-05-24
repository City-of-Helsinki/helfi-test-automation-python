*** Settings ***
Resource        ../../../robotframework-keywords/platform/Paragraphs/Service.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		SERVICE


*** Test Cases ***
Service
	[Tags]  
	Given User Goes To New Service Site
	And User Starts Creating Service With Finnish Language
	When New Service is Submitted
	And User Opens Created Content
	Then Layout Should Not Have Changed

With Parent Service
	[Tags]
	Given User Goes To New Service Site
	And User Starts Creating Service With Finnish Language
	And User Adds Esimerkkipalvelu as Parent Service
	When New Service is Submitted
	And User Opens Created Content
	Then Layout Should Not Have Changed

Finnish English Swedish Translations
	[Tags] 
	Given User Goes To New Service Site
	And User Starts Creating Service With Finnish Language
	And User Starts Creating Service With English Language
	And User Starts Creating Service With Swedish Language
	And User Opens Created Content
	Then Page Should Have Finnish Translation
	And Page Should Have English Translation
	And Page Should Have Swedish Translation

*** Keywords ***

User Goes To New Service Site   Go To New Service Site
New Service is Submitted	Submit The New Service

User Starts Creating Service With ${language} Language
	Run Keyword If  '${language}'!='Finnish'   Start New ${language} Language Translation
	Create Service With Language   ${language}
	Run Keyword If   '${TEST NAME}'=='Finnish English Swedish Translations'   Submit The New Service
	Run Keyword If   '${TEST NAME}'=='Finnish English Swedish Translations'   Open Created Content
	Run Keyword If   '${TEST NAME}'=='Finnish English Swedish Translations'   Take Screenshot Of Content

Start New ${language} Language Translation
	Go To Translate Selection Page
	Go To ${language} Translation Page

Page Should Have ${lang_input} Translation
	Set Language Pointer   ${lang_input}
	Contenthandler.Select Language   ${lang_input}
	Page Content Matches Language

Return Title From Page
	${title}=	Get Text    ${Txt_Column_Title}
	[Return]		${title}

Return Description From Page
	${description}=	Get Text    ${Txt_Column_Description}
	[Return]		${description}

Return Content From Page
	${content}=	Get Text    ${Txt_Column_Content}
	[Return]		${content}

Page Content Matches Language
	${Title}=  Return Title From Page
	${Description}=  Return Description From Page
	${Content}=  Return Content From Page
	Title Should Match Current Language Selection   ${Title}
	Content Should Match Current Language Selection   ${Content}

User Adds ${service} as Parent Service
	Add ${service} as Parent Service

User Opens Created Content
	 Open Created Content
	 Take Screenshot Of Content
	 
Layout Should Not Have Changed
	${originalpic} =  Set Variable   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_SERVICE_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}