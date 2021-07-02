*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Add_From_Library.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		ARTICLE   ADDFROMLIBRARY

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

ContentCards
	[Tags] 
	Given User Creates New ContentCards Paragraphs To Library
	When User Starts Creating Page With Add From Library Content For ContentCards -Paragraph in Finnish Language
	And User Starts Creating Page With Add From Library Content For ContentCards -Paragraph in English Language
	Then Page Should Have Finnish Translation
	Then Page Should Have English Translation
	
*** Keywords ***
User Creates New Columns Paragraphs To Library	
	Create New Finnish Columns Paragraph To Library
	Create New English Columns Paragraph To Library
	Create New Swedish Columns Paragraph To Library

User Creates New Accordion Paragraphs To Library	
	Create New Finnish Accordion Paragraph To Library
	Create New English Accordion Paragraph To Library
	Create New Swedish Accordion Paragraph To Library

User Creates New ContentCards Paragraphs To Library	
	Create New Finnish ContentCards Paragraph To Library
	Create New English ContentCards Paragraph To Library

User Starts Creating ${pagetype} With Add From Library Content For ${paragraph} -Paragraph in ${lang_selection} Language
	Go To  ${URL_content_page}
	Go To New Article Site
	Create ${lang_selection} Language ${paragraph} -Paragraph ${pagetype} Content
