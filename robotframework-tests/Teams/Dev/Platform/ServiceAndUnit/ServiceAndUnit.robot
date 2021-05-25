*** Settings ***
Resource        ../../../robotframework-keywords/platform/Paragraphs/Service.robot
Resource        ../../../robotframework-keywords/platform/Paragraphs/Unit.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		SERVICE   UNIT


*** Test Cases ***
Service
	[Tags]
	When User Opens Service With Name service-fi-1
	Then Service Contents Should Be Correct

Unit With Service
	[Tags]
	Given Service Is Set as Published
	When User Opens Unit With Name name-fi-1
	Then Unit Contents Should Be Correct
	And Units Service Link Works Correctly


*** Keywords ***

Service Is Set as Published
	Publish The 1 Service In The Service List 
	
User Opens Service With Name ${name}
	Open Service With Name   ${name}

User Opens Unit With Name ${name}
	Open Unit With Name   ${name}
	
Service Contents Should Be Correct
	${title}=  Get Service Title
	${title}=   Encode String To Bytes   ${title}   UTF-8
	${title}=  Set Variable  ${title.replace('\xc2\xad', '')}
	${shortdesc}=  Get Service Short Description
	${longdesc}=  Get Service Long Description
	Should Be Equal   ${title}   Service fi 1
	Should Be Equal   ${shortdesc}   Description short fi 1
	Should Be Equal   ${longdesc}   Description long fi 1
	
Unit Contents Should Be Correct
	Accept Cookies
	${title}=  Get Unit Title
	${title}=   Encode String To Bytes   ${title}   UTF-8
	${title}=  Set Variable  ${title.replace('\xc2\xad', '')}
	${ccardtitle}=  Get Contact Card Title
	${ccardtitle}=   Encode String To Bytes   ${ccardtitle}   UTF-8
	${ccardtitle}=  Set Variable  ${ccardtitle.replace('\xc2\xad', '')}
	${addrmain}=  Get Address Main Title
	${addrline1}=  Get Address Line 1
	${postcode}=  Get Postal Code
	${locality}=  Get Locality
#	${country}=  Get Country
	${phonemain}=  Get Phone Main Title
	#${phone}=  Get Phone
	${servicetitle}=  Get Units Service Title
	${servicetitle}=   Encode String To Bytes   ${servicetitle}   UTF-8
	${servicetitle}=  Set Variable  ${servicetitle.replace('\xc2\xad', '')}
	${servicedesc}=  Get Units Service Description

	Should Be Equal   ${title}   Name fi 1
	Should Be Equal   ${ccardtitle}   Yhteystiedot
	Should Be Equal   ${addrmain}   Käyntiosoite:
	Should Be Equal   ${addrline1}   Address fi 1
	Should Be Equal   ${postcode}   02180
	Should Be Equal   ${locality}   Espoo fi 1
#	Should Be Equal   ${country}   Suomi
	Should Be Equal   ${phonemain}   Puhelinnumero:
	#Should Be Equal   ${phone}   +3581234
	${hasservicelink}=  Unit Has Service Link
	Should Be True   ${hasservicelink}
	Should Be Equal   ${servicetitle}   Service fi 1
	Should Be Equal   ${servicedesc}   Description short fi 1
	
Units Service Link Works Correctly
	Click Element   //a[contains(@href, 'http://helfi.docker.sh/fi/service-fi-1')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   service-fi-1
