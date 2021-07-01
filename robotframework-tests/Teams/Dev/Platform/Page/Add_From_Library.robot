*** Settings ***
Documentation   Testing Columns Settings in Platform by comparing layout to default picture. Testing is performed with
...				Different text deviation like 50-50, 30-70 and with pictures and links added.
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Add_From_Library.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PAGE   ADDFROMLIBRARY

*** Test Cases ***
Columns
	[Tags]
	Given User Creates New Columns Paragraphs To Library
	When User Starts Creating Page With Add From Library Content For Columns -Paragraph in Finnish Language
	And User Starts Creating Page With Add From Library Content For Columns -Paragraph in English Language
	And User Starts Creating Page With Add From Library Content For Columns -Paragraph in Swedish Language
	Then Page Should Have Finnish Translation
	Then Page Should Have English Translation
	Then Page Should Have Swedish Translation
	
*** Keywords ***
User Creates New Columns Paragraphs To Library	
	Create New Finnish Columns Paragraph To Library
	Create New English Columns Paragraph To Library
	Create New Swedish Columns Paragraph To Library

User Goes To New Page -Site
		Go To  ${URL_content_page}
		Go To New Page Site
		
User Submits The New Page	Submit The New Page

User Starts Creating ${pagetype} With Add From Library Content For ${paragraph} -Paragraph in ${lang_selection} Language
	Go To  ${URL_content_page}
	Go To New Page Site
	Create ${lang_selection} Language ${paragraph} -Paragraph ${pagetype} Content
