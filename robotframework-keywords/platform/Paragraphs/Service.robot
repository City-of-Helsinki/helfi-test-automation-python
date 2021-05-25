*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Publish The ${nth} Service In The Service List
	Goto  https://helfi.docker.sh/fi/admin/content/integrations/tpr-service/${nth}/edit
	${ispublished}=   Run Keyword And Return Status   Checkbox Should Be Selected  id:edit-status
	Run Keyword Unless   ${ispublished}   Set Content As Published
	Submit New Content

Open Service With Name
	[Arguments]	   ${name}
	Goto  https://helfi.docker.sh/fi/${name}
	
Get Service Title
	${title}=   Get Text   css:.service__title
	[Return]   ${title}
	
Get Service Short Description
	${shortdesc}=   Get Text   css:.service__short-desc
	[Return]   ${shortdesc}
	
Get Service Long Description
	${longdesc}=   Get Text   css:.service__long-desc
	[Return]   ${longdesc}	