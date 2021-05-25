*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Publish The ${nth} Unit In The Unit List
	Goto  https://helfi.docker.sh/fi/admin/content/integrations/tpr-unit/${nth}/edit
	Set Content As Published
	Submit New Content

Open Unit With Name
	[Arguments]	   ${name}
	Goto  https://helfi.docker.sh/fi/${name}
	
Get Unit Title
	${value}=   Get Text   css:.unit__title
	[Return]   ${value}

Get Contact Card Title
	${value}=   Get Text   css:.unit__contact__title
	[Return]   ${value}
	

Get Address Main Title
	${value}=   Get Text   css:div.unit__contact-row.unit__contact-row--address > label
	[Return]   ${value}
	
Get Address Line 1
	${value}=   Get Text   css:.address-line1
	[Return]   ${value}
	
Get Postal Code
	${value}=   Get Text   css:.postal-code
	[Return]   ${value}	
	
Get Locality
	${value}=   Get Text   css:.locality
	[Return]   ${value}
	
Get Country
	${value}=   Get Text   css:.country
	[Return]   ${value}

Get Phone Main Title
	${value}=   Get Text   css:div.unit__contact-row.unit__contact-row--phone > label
	[Return]   ${value}
	
Get Phone
	${value}=   Get Text   css:.unit__contact-row__label:last-of-type
	[Return]   ${value}

Unit Has Service Link
	${status}=  Run Keyword And Return Status    Element Should Be Visible   css:.service__link
	[Return]   ${status}
	
Get Units Service Title 
	${value}=  Get Text   css:.service__title
	[Return]   ${value}
	
Get Units Service Description
	${value}=  Get Text   css:.service__short-desc
	[Return]   ${value}