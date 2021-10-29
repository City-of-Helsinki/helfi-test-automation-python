*** Settings ***
Documentation   For these testcases to work  'helfi_example_content' module should be enabled
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

Accordion
	[Tags]
	Given User Creates New Accordion Paragraphs To Library
	When User Starts Creating Page With Add From Library Content For Accordion -Paragraph in Finnish Language
	And User Starts Creating Page With Add From Library Content For Accordion -Paragraph in English Language
	And User Starts Creating Page With Add From Library Content For Accordion -Paragraph in Swedish Language
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

Gallery
	[Tags]
	Given User Creates New Gallery Paragraphs To Library
	When User Starts Creating Page With Add From Library Content For Gallery -Paragraph in Finnish Language
	And User Starts Creating Page With Add From Library Content For Gallery -Paragraph in English Language
	And User Starts Creating Page With Add From Library Content For Gallery -Paragraph in Swedish Language
	Then Page Should Have Finnish Translation
	Then Page Should Have English Translation
	Then Page Should Have Swedish Translation

Picture
	[Tags]
	Given User Creates New Picture Paragraphs To Library
	When User Starts Creating Page With Add From Library Content For Picture -Paragraph in Finnish Language
	And User Starts Creating Page With Add From Library Content For Picture -Paragraph in English Language
	And User Starts Creating Page With Add From Library Content For Picture -Paragraph in Swedish Language
	Then Page Should Have Finnish Translation
	Then Page Should Have English Translation
	Then Page Should Have Swedish Translation

ListOfLinks
	[Tags]   
	Given User Creates New ListOfLinks Paragraphs To Library
	When User Starts Creating Page With Add From Library Content For ListOfLinks -Paragraph in Finnish Language
	And User Starts Creating Page With Add From Library Content For ListOfLinks -Paragraph in English Language
	And User Starts Creating Page With Add From Library Content For ListOfLinks -Paragraph in Swedish Language
	Then Page Should Have Finnish Translation
	Then Page Should Have English Translation
	Then Page Should Have Swedish Translation

Text
	[Tags]
	Given User Creates New Text Paragraphs To Library
	When User Starts Creating Page With Add From Library Content For Text -Paragraph in Finnish Language
	And User Starts Creating Page With Add From Library Content For Text -Paragraph in English Language
	And User Starts Creating Page With Add From Library Content For Text -Paragraph in Swedish Language
	Then Page Should Have Finnish Translation
	Then Page Should Have English Translation
	Then Page Should Have Swedish Translation
		
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

User Creates New Gallery Paragraphs To Library	
	Create New Finnish Gallery Paragraph To Library
	Create New English Gallery Paragraph To Library
	Create New Swedish Gallery Paragraph To Library

User Creates New Picture Paragraphs To Library	
	Create New Finnish Picture Paragraph To Library
	Create New English Picture Paragraph To Library
	Create New Swedish Picture Paragraph To Library

User Creates New ListOfLinks Paragraphs To Library	
	Create New Finnish ListOfLinks Paragraph To Library
	Create New English ListOfLinks Paragraph To Library
	Create New Swedish ListOfLinks Paragraph To Library

User Creates New Text Paragraphs To Library	
	Create New Finnish Text Paragraph To Library
	Create New English Text Paragraph To Library
	Create New Swedish Text Paragraph To Library
		
User Starts Creating ${pagetype} With Add From Library Content For ${paragraph} -Paragraph in ${lang_selection} Language
	Go To  ${URL_content_page}
	Go To New Page Site
	Create ${lang_selection} Language ${paragraph} -Paragraph ${pagetype} Content
