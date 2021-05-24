*** Settings ***
Documentation   Just a small demo
Library           SeleniumLibrary
Library           OperatingSystem
Test Setup      Get Admin Url
Test Teardown	Close Browser

*** Variables ***
${language}    fi
${CONTENT_PATH}    
${RESOURCES_ROOT}    
${PROJECT_ROOT}    
${admin_url} =  ${ADMIN_URL}
${browser} =  ${BROWSER}


*** Test Cases ***

Browse Content Item
	[Tags]  DEMO
    Go To Content Site
    Open First Item	
 
   
*** Keywords ***
Get Admin Url
   ${admin_url} =   Run  ${admin_url}
   Set Test Variable   ${admin_url}
      
Go To Content Site
	Open Browser  ${admin_url}  ${browser}
	Log   ${PROJECT_ROOT}
	Log   ${RESOURCES_ROOT}
	Log   ${EXECDIR}
#	${description}=	Get File  ${CONTENT_PATH}/text_description_short_${language}.txt
#	Sleep   5
#    Log   ${RESOURCE_PATH}
	Go To   https://helfi.docker.sh/fi/user/1
#	Sleep   5
	Set Focus To Element   //span[contains(text(), 'Hyväksy kaikki evästeet')]
	Wait Until Keyword Succeeds  5x  400ms  Click Button  //button[@class='agree-button eu-cookie-compliance-default-button hds-button hds-button--primary']
#	Sleep   5
	Wait Until Keyword Succeeds  3x  200ms  Click Element  //li[contains(@class, 'admin_content')]
	
Open First Item
#	Sleep   5
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/fi/hero-ilman-kuvaa-tasattu-keskelle')]
#	Sleep   5
    Capture Page Screenshot