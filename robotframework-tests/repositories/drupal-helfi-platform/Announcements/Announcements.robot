*** Settings ***
Resource        ../../../../robotframework-keywords/platform/Others/Announcements.robot
Documentation	For units and services used in these testcases to appear, about 50 units and services should be imported.
...				Also following modules should be enabled/imported:
...				helfi_announcements, tpr_errand_service, tpr_service, tpr_service_channel, helfi_example_content
...				Announcements block should be added to 'Before Content' section in Block Layout -page
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		 ANNOUNCEMENTS

*** Test Cases ***
All Pages
	[Tags]  CRITICAL
	Given User Goes To New Annoucement Site
	When User Creates Finnish Published Alert Announcement to Show on All Pages
	And User Submits The New Announcement
	Then Announcement Should Be Visible In Checked Content

All Pages After Modify
	[Tags]
	[Documentation]  Unpublished announcements should not be shown at all
	Given User Goes To New Annoucement Site
	When User Creates Finnish Published Alert Announcement to Show on All Pages
	And User Submits The New Announcement
	And User Modifies Announcement Text
	Then Modified Announcement Has Correct Text Content

Certain Pages
	[Tags]  
	Given User Goes To New Annoucement Site
	When User Creates Finnish Published Alert Announcement to Show on Certain Pages
	And User Submits The New Announcement
	Then Announcement Should Be Visible In Checked Content
	And Announcement Should Not Be Visible In Checked Content	

Unpublished
	[Tags]  
	[Documentation]  Unpublished announcements should not be shown at all
	Given User Goes To New Annoucement Site
	When User Creates Finnish Unpublished Alert Announcement to Show on All Pages
	And User Submits The New Announcement
	Then Announcement Should Not Be Visible In Checked Content	

English Translation
	[Tags]  
	[Documentation]  Translated announcement is shown in its respective language page.
	Given User Goes To New Annoucement Site
	When User Creates English Published Alert Announcement to Show on All Pages
	And User Submits The New Announcement
	Then Announcement Should Be Visible Only For English Language Content	

Notification Layout
	[Tags]
	[Documentation]  Checks by using picture compariso that layout looks as it should
	Given User Goes To New Annoucement Site
	When User Creates Finnish Published Notification Announcement to Show on All Pages
	And User Submits The New Announcement
	Then Announcement Layout For Notification Should Be Correct For Checked Content

Attention Layout
	[Tags]
	[Documentation]  Checks by using picture compariso that layout looks as it should
	Given User Goes To New Annoucement Site
	When User Creates Finnish Published Attention Announcement to Show on All Pages
	And User Submits The New Announcement
	Then Announcement Layout For Attention Should Be Correct For Checked Content
	
Alert Layout
	[Tags]
	[Documentation]  Checks by using picture compariso that layout looks as it should
	Given User Goes To New Annoucement Site
	When User Creates Finnish Published Alert Announcement to Show on All Pages
	And User Submits The New Announcement
	Then Announcement Layout For Alert Should Be Correct For Checked Content
	
*** Keywords ***
User Goes To New Annoucement Site
	Go To New Annoucement Site
	
User Creates ${lang_selection} ${publishstatus} ${type} Announcement to Show on ${visibility} Pages
	Run Keyword If   ('${visibility}'=='All') & ('${publishstatus}'=='Published')  Create Announcement    Test_Automation_Announcement_All_Pages   ${lang_selection}    ${type}
	Run Keyword If   ('${visibility}'=='All') & ('${publishstatus}'=='Unpublished')  Create Announcement    Test_Automation_Announcement_All_Pages   ${lang_selection}    ${type}   True   False
	Run Keyword If   '${visibility}'=='Certain'  Create Announcement    Test_Automation_Announcement_Certain_Pages   ${lang_selection}    ${type}   False

User Adds ${lang_selection} Translation For The Announcement
	Add ${lang_selection} Translation For The Announcement
	
  
User Submits The New Announcement  
	Submit The New Announcement   

User Modifies Announcement Text
	Modify Announcement Text
	
Modified Announcement Has Correct Text Content
	Announcement Is Visible For Esimerkkisivu Of User Created Content List
	Annoucement Text Content Equals    Modified Content For Announcement
	Announcement Is Visible For Peijaksen sairaala Of Unit List
	Annoucement Text Content Equals    Modified Content For Announcement
	Announcement Is Visible For Ompeleiden poisto Of Service List
	Annoucement Text Content Equals    Modified Content For Announcement
	
		
Announcement Should Be Visible In Checked Content
	Announcement Is Visible For Esimerkkisivu Of User Created Content List
	Announcement Is Visible For Peijaksen sairaala Of Unit List
	Announcement Is Visible For Ompeleiden poisto Of Service List

Announcement Should Not Be Visible In Checked Content
	Announcement Is Not Visible For Esimerkki laskeutumissivusta Of User Created Content List
	Announcement Is Not Visible For Viikin kampuskirjasto Of Unit List
	Announcement Is Not Visible For Äänioikeusrekisteri Of Service List
	
Announcement Should Be Visible Only For ${lang_selection} Language Content
	Announcement Is Visible For Link examples Of User Created Content List
	Announcement Is Visible For Lippulaiva library Of Unit List
	Announcement Is Visible For Online health check Of Service List
	
	Announcement Is Not Visible For Esimerkki laskeutumissivusta Of User Created Content List
	Announcement Is Not Visible For Viikin kampuskirjasto Of Unit List
	Announcement Is Not Visible For Äänioikeusrekisteri Of Service List
	
	Announcement Is Not Visible For Lippulaivabiblioteket Of Unit List
	Announcement Is Not Visible For Elektronisk hälsokontroll Of Service List

Announcement Layout For ${type} Should Be Correct For Checked Content
	Announcement Is Visible For Esimerkkisivu Of User Created Content List
	${type} Announcement Layout Is Corrent
	

${type} Announcement Layout Is Corrent
		Scroll Element Into View   css:#block-announcements > div
        Capture Element Screenshot   css:#block-announcements > div    filename=${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}-${type}.png
        ${originalpic}=  Set Variable  ${SCREENSHOTS_PATH}/${BROWSER}/ANNOUNCEMENTS_${type}_${BROWSER}.png
        ${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}-${type}.png
        Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}   ${EMPTY}   1