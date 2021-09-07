*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Service.robot
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Unit.robot
Test Setup      Login And Go To Content Page
Test Teardown   Delete Banners And Do Other Teardown Actions	
Force Tags		SERVICE   UNIT


*** Test Cases ***
Service
	[Tags] 
	When User Opens Service With Name Digituki
	Then Service Contents Should Be Correct

Unit With Service
	[Tags]
	Given Service Is Set as Published
	When User Opens Unit With Name Paloheinän kirjasto
	Then Unit Contents Should Be Correct
	And Units Service Link Works Correctly

Unit With Color Palette
	[Tags]
	Given User Edits Unit With Name Roihuvuoren kirjasto
	And User Adds Banner To Unit With 'silver' Color Selection
	When User Submits The Unit Changes
	Then Banner Paragraph Should Have Selected Color

*** Keywords ***

User Submits The Unit Changes
	Submit Unit Changes

Service Is Set as Published
	Publish Service With Name   Digituki
	
User Opens Service With Name ${name}
	Open Service With Name   ${name}

User ${action} Unit With Name ${name}
	Open Unit With Name   ${name}
	Run Keyword And Ignore Error   Accept Cookies
	
User Adds Banner To Unit With '${color}' Color Selection
	Add Banner For Unit With Name And Color   Roihuvuoren kirjasto   ${color}
	
Service Contents Should Be Correct
	${title}=  Get Service Title
	${title}=   Replace Encoded Characters From String   ${title}   ${EMPTY}    UTF-8    \\xc2\\xad
	${shortdesc}=  Get Service Short Description
	${longdesc}=  Get Service Long Description
	Should Be Equal   ${title}   Digituki
	Should Be Equal   ${shortdesc}   Digitukea saa tietokoneen, tabletin ja älypuhelimen käytössä. Tukea saa myös sähköisen asioinnin, verkkopalveluiden ja yleisimpien sovellusten käyttöön liittyvissä ongelmissa.
	Should Contain   ${longdesc}   Digituki ja digineuvonta tarkoittavat Helsingin kaupungilla
	
Unit Contents Should Be Correct
	Run Keyword And Ignore Error  Accept Cookies
	${title}=  Get Unit Title
	${title}=  Replace Encoded Characters From String   ${title}   ${EMPTY}    UTF-8    \\xc2\\xad
	${title}=  Replace Encoded Characters From String   ${title}   ä    UTF-8    \\xc3\\xa4
	${ccardtitle}=  Get Contact Card Title
	${ccardtitle}=  Replace Encoded Characters From String   ${ccardtitle}   ${EMPTY}    UTF-8    \\xc2\\xad
	${addrmain}=  Get Address Main Title
	${addrline1}=  Get Address Line 1
	${postcode}=  Get Postal Code
	${locality}=  Get Locality
	${phonemain}=  Get Phone Main Title
	${servicetitle}=  Get Units Service Title
	${servicetitle}=  Replace Encoded Characters From String   ${servicetitle}   ${EMPTY}    UTF-8    \\xc2\\xad
	${servicedesc}=  Get Units Service Description

	Should Be Equal   ${title}   Paloheinän kirjasto
	Should Be Equal   ${ccardtitle}   Yhteystiedot
	Should Be Equal   ${addrmain}   Käyntiosoite:
	Should Be Equal   ${addrline1}   Paloheinäntie 22
	Should Be Equal   ${postcode}   00670
	Should Be Equal   ${locality}   Helsinki
	Should Be Equal   ${phonemain}   Puhelinnumero:
	${hasservicelink}=  Unit Has Service Link
	Should Be True   ${hasservicelink}
	Should Be Equal   ${servicetitle}   Digituki
	Should Be Equal   ${servicedesc}   Digitukea saa tietokoneen, tabletin ja älypuhelimen käytössä. Tukea saa myös sähköisen asioinnin, verkkopalveluiden ja yleisimpien sovellusten käyttöön liittyvissä ongelmissa.
	
Units Service Link Works Correctly
	Click Element   //a[contains(@href, 'https://helfi.docker.so/fi/digituki')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   digituki

Banner Paragraph Should Have Selected Color
	Open Unit With Name   Roihuvuoren kirjasto
	Capture Element Screenshot  css:div.unit-header__container.container > div.unit__header > div.enriched-content.has-sidebar   filename=${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	${originalpic} =   Set Variable  ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_SERVICEANDUNIT_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}
	
Delete Banners And Do Other Teardown Actions
	Run Keyword If  '${TEST NAME}'=='Unit With Color Palette'  Delete Banner For Unit With Name   Roihuvuoren kirjasto
	Cleanup and Close Browser
	