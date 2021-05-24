*** Settings ***
Resource        ../../../robotframework-keywords/platform/Paragraphs/Accordion.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PAGE   ACCORDION
*** Variables ***



*** Test Cases ***
White Accordion
	[Tags]  CRITICAL
	Given User Goes To New Page -Site
	And User Starts Creating White Accordion With h2 Heading And Text Content
	And User Adds Content to Text Subcategory
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And Accordion Component Works As Expected	
	
Grey Accordion
	[Tags]
	Given User Goes To New Page -Site
	And User Starts Creating Grey Accordion With h2 Heading And Text Content
	And User Adds Content to Text Subcategory
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And Accordion Component Works As Expected	

Columns With Pictures
	[Tags]  CRITICAL
	Given User Goes To New Page -Site
	And User Starts Creating White Accordion With h2 Heading And Columns Content
	User Adds Picture Content to Columns Subcategory
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And Accordion Component Works As Expected	

Columns With Text
	[Tags]
	Given User Goes To New Page -Site
	And User Starts Creating White Accordion With h2 Heading And Columns Content
	User Adds Text Content to Columns Subcategory
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And Accordion Component Works As Expected	
	
*** Keywords ***
User Goes To New Page -Site		Go To New Page Site
User Submits The New Page
	Submit The New Page

User Adds ${content} Content to Columns Subcategory
	Add ${content} Content to Columns Subcategory

User Adds Content to Text Subcategory
	Add Content To Text Subcategory

User Opens Created Content
	 Open Created Content
	 Click Element  ${Btn_Accordion_View}
	 Sleep  1
	 Take Screenshot Of Content
	 Click Element  ${Btn_Accordion_View}

User Starts Creating ${color} Accordion With ${heading} Heading And ${contenttype} Content
	Create Page With ${color} Color , ${heading} Heading And ${contenttype} Content

User Starts Creating ${color} Accordion With ${heading} Heading And ${contenttype} With ${subcontent} Content
	Create Page With ${color} Color , ${heading} Heading And ${contenttype} With ${subcontent} Content
	
Layout Should Not Have Changed
	${contenttype}=  Convert To Lower Case   ${contenttype}
	${originalpic} =  Set Variable If  '${picture}'=='picture'   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_PAGE_ACCORDION_${contenttype}_${color}_${picture}_${heading}_${BROWSER}.png   
	...				${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_PAGE_ACCORDION_${contenttype}_${color}_${heading}_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Run Keyword If   ${USEORIGINALNAME}   Rename Picture With New Name   ${originalpic}   ${comparisonpic}
	Compared Pictures Match   ${originalpic}    ${comparisonpic}
	Run Keyword Unless   ${USEORIGINALNAME}   Copy Original Screenshot To Reports Folder   ${originalpic}