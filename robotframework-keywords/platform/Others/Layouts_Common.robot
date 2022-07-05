*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Setup Browsers 
	Set Test Variable   ${MOBILE}  ${false}
	Set Shortened Suite Name
	IF    ${CI}
		Register Keyword To Run On Failure   NONE
	END
		Layouts_Common.Open Browser Instance For Device And Go To Layouts Page   iPhone SE
		Accept Cookies In Mobile
		Seleniumlibrary.Open Browser  about:blank  ${BROWSER}   desktopchrome 
		Set Window Size   1296   696

Accept Cookies In Mobile
	Wait Until Element Is Visible   xpath://button[@class='agree-button eu-cookie-compliance-default-button hds-button hds-button--primary']   timeout=2
	PuppeteerLibrary.Click Button  xpath://button[@class='agree-button eu-cookie-compliance-default-button hds-button hds-button--primary']

Open Browser Instance For Device And Go To Layouts Page
	[Arguments]   ${devicename}
	Import Library   PuppeteerLibrary
	Set Library Search Order   PuppeteerLibrary
	${options}=    Create Dictionary    emulate=${devicename}  
	PuppeteerLibrary.Open Browser   ${URL_layouts_page}   options=${options}   alias=mobilechrome
	Set Screenshot Directory   ${REPORTS_PATH}

Layout Should Not Have Changed
	Run Keyword And Ignore Error  Accept Cookies In Mobile
	Compare Two Pictures	

Prepare Test Settings And Variables For ${devicetype} 
	[Documentation]   Accepted Devicetype values are 'Desktop' and 'Mobile'
	IF  '${devicetype}'=='Desktop'
		Set Window Size   1296   696
		SeleniumLibrary.Switch Browser   desktopchrome
		Set Test Variable   ${MOBILE}   ${false}
	ELSE
		Set Test Variable   ${MOBILE}   ${true}
	END

Go To Content Page
	[Arguments]    ${contentpath}   ${contentpage}
	IF  ${MOBILE}
		PuppeteerLibrary.GoTo    ${URL_layouts_page}/${contentpath}/${contentpage}
	ELSE
		SeleniumLibrary.GoTo   ${URL_layouts_page}/${contentpath}/${contentpage}
	END 

Take Screenshot And Compare Upper And Lower Content On Page
	[Arguments]   ${contentpath}   ${contentpage}
	Go To Content Page   ${contentpath}   ${contentpage}
	IF  ${MOBILE}   
		Capture Screenshot For Picture Comparison In Layouts Page   css=main.layout-main-wrapper   filename=${contentpage}_mobile
		Compare Two Pictures   origfilename=${contentpage}   compfilename=${contentpage}_mobile
	ELSE
		Capture Screenshot For Picture Comparison In Layouts Page   css=div.layout-content   filename=${contentpage}_desktop_upper
		Capture Screenshot For Picture Comparison In Layouts Page   css=div.lower-content   filename=${contentpage}_desktop_lower
		Compare Two Pictures   origfilename=${contentpage}_upper   compfilename=${contentpage}_desktop_upper
		Compare Two Pictures   origfilename=${contentpage}_lower   compfilename=${contentpage}_desktop_lower
	END	
	
Take Screenshot And Compare Main Content On Page
	[Arguments]   ${contentpath}   ${contentpage}
	Go To Content Page   ${contentpath}   ${contentpage}
	IF  ${MOBILE}   
		Capture Screenshot For Picture Comparison In Layouts Page   css=div.main-content   filename=${contentpage}_mobile
		Compare Two Pictures   origfilename=${contentpage}   compfilename=${contentpage}_mobile
	ELSE
		Capture Screenshot For Picture Comparison In Layouts Page   css=div.main-content   filename=${contentpage}_desktop
		Compare Two Pictures   origfilename=${contentpage}   compfilename=${contentpage}_desktop
	END	
	
Capture Screenshot For Picture Comparison In Layouts Page
	[Arguments]   ${locator}   ${filename}=${BROWSER}_TESTRUN-${SUITE}-${TEST NAME}_${language}   ${blur}=${EMPTY}    ${redact}=${EMPTY}
	[Documentation]  See   https://github.com/jz-jess/RobotEyes
	
	IF  not(${MOBILE})
		${wsize}=  Get Window Size
		${width}=  Get From List   ${wsize}   0
		${height}=  Get From List   ${wsize}   1
		Set Window Size  3840   3160    # SO THAT WHOLE ELEMENT GETS CAPTURED SUCCESFULLY
	END
	IF    ${CI}
		Open Eyes   SeleniumLibrary
		Capture Element   ${locator}     name=/app/helfi-test-automation-python/robotframework-reports/${filename}   blur=${blur}   redact=${redact}
		Set Window Size   ${width}   ${height}	# LETS RESTORE THE ORIGINAL VALUE USED IN TESTING
	ELSE IF  ${MOBILE}
		Capture Page Screenshot   filename=${REPORTS_PATH}/${filename}.png   fullPage=True
	ELSE
		Open Eyes   SeleniumLibrary
		Capture Element   ${locator}   name=${REPORTS_PATH}/${filename}   blur=${blur}   redact=${redact}
		Set Window Size   ${width}   ${height}	# LETS RESTORE THE ORIGINAL VALUE USED IN TESTING
	END
	