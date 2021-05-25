*** Settings ***
Library    OperatingSystem
Documentation   Common Keywords referred by many testsuites. Platform side tests only
Library           SeleniumLibrary
Library			  String

*** Variables ***
${REPORTS_PATH}    ${EXECDIR}/robotframework-reports
${CONTENT_PATH}    ${EXECDIR}/robotframework-resources/content
${KEYWORDS_PATH}    ${EXECDIR}/robotframework-keywords
${IMAGES_PATH}    ${EXECDIR}/robotframework-resources/images
${SCREENSHOTS_PATH}    ${EXECDIR}/robotframework-resources/screenshots

*** Keywords ***
Debug Error
	Maximize Browser Window   
	Execute javascript  document.body.style.zoom="30%"
	Capture Page Screenshot    filename=${REPORTS_PATH}/debug/${SUITE NAME}-${TEST NAME}_error_zoomout.png
	Execute javascript  document.body.style.zoom="100%"
	${source}=   Get Source
	Create File  ${REPORTS_PATH}/debug/${SUITE NAME}-${TEST NAME}_error_source.html  ${source}
	
Input Text To Frame
	[Documentation]   Inserts text to given frame and returns to original content
	[Arguments]	   ${frame}   ${locator}   ${input}
	Select Frame   ${frame}
	Input Text   ${locator}   ${input}
	Unselect Frame
    
Click Element With Value
	[Arguments]	   ${value}
	${value}=  Convert To Lower Case   ${value}
	Click Element  css:[value=${value}]

Remove String And Strip Text
	[Documentation]   Value= String to be modified , String = String to be removed from value -content
	[Arguments]	   ${value}   ${string}
	${value}=  Run Keyword And Continue On Failure   Remove String   ${value}   ${string}
	${value}=  Strip String   ${value}
	[Return]    ${value}
	
Suite Name Contains Text
	[Arguments]  ${text}
	${containstext}=    Run Keyword And Return Status    Should Contain    ${SUITE NAME}    ${text}
	[Return]   ${containstext}

Click Element Using JavaScript Xpath
	[Arguments]  ${xpath}
    Execute JavaScript    document.evaluate("${xpath}",document.body,null,9,null).singleNodeValue.click();

Click Element Using JavaScript Id
	[Arguments]  ${id}
    Execute JavaScript    document.getElementById(${id}).click();
	
Rename Reports Picture To Use Original Picture Name
	[Documentation]   Renames File In given source folder. Full path must be given in first argument and
	...				  only new name in second one.
	[Arguments]  ${fullpath}   ${newname}
	Move File  ${fullpath}  ${newname}
	
Zoom Out And Capture Page Screenshot
	Execute javascript  document.body.style.zoom="25%"
	Capture Page Screenshot
	Execute javascript  document.body.style.zoom="100%"