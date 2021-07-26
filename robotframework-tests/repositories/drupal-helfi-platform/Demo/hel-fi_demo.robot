*** Settings ***
Documentation   Just a small demo
Library           SeleniumLibrary
Library           OperatingSystem
Library           DocTest.VisualTest   take_screenshots=${true}
Test Teardown	Close Browser

*** Variables ***
${language}    fi
${CONTENT_PATH}    
${RESOURCES_ROOT}    
${PROJECT_ROOT}    
${browser} =  ${BROWSER}


*** Test Cases ***

Browse Content Item
	[Tags]
    Go To Content Site
    Open First Item	
 
Browse Robotframework
	[Tags]
	   Log   Starting Browser
	   Open Website   http://robotframework.org
	   Set Window Size   1296   696
	   Capture Page Screenshot
	   Page Should Contain   ROBOT FRAME WORK/
	   Sleep   2

Picture Compare
	[Tags]   DEMO
	Compare Images      C:\\TA\\helfi_python//robotframework-resources//screenshots//chrome//fi_short_COLUMNS_50-50_text_chrome.png    C:\\TA\\helfi_python//robotframework-resources//screenshots//chrome//fi_short_HERO_LANDINGPAGE_left_Engel_nopicture_chrome.png
   
*** Keywords ***
Open Website
	[Arguments]   ${url}
    ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --headless
    Open Browser    ${url}    chrome    options=${chrome_options}

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