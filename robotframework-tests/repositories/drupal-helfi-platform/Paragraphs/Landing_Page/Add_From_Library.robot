*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Add_From_Library.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		LANDINGPAGE   ADDFROMLIBRARY

*** Test Cases ***
Columns
	[Tags]    CRITICAL
	Given User Creates New Columns Paragraphs To Library
	When User Starts Creating LandingPage With Add From Library Content For Columns -Paragraph in Finnish Language
	And User Starts Creating LandingPage With Add From Library Content For Columns -Paragraph in English Language
	And User Starts Creating LandingPage With Add From Library Content For Columns -Paragraph in Swedish Language
	Then Page Should Have Finnish Translation
	Then Page Should Have English Translation
	Then Page Should Have Swedish Translation
	
Banner
	[Tags]
	Given User Creates New Banner Paragraphs To Library
	When User Starts Creating LandingPage With Add From Library Content For Banner -Paragraph in Finnish Language
	And User Starts Creating LandingPage With Add From Library Content For Banner -Paragraph in English Language
	And User Starts Creating LandingPage With Add From Library Content For Banner -Paragraph in Swedish Language
	Then Page Should Have Finnish Translation
	Then Page Should Have English Translation
	Then Page Should Have Swedish Translation

ContentCards
	[Tags]
	Given User Creates New ContentCards Paragraphs To Library
	When User Starts Creating LandingPage With Add From Library Content For ContentCards -Paragraph in Finnish Language
	And User Starts Creating LandingPage With Add From Library Content For ContentCards -Paragraph in English Language
	Then Page Should Have Finnish Translation
	Then Page Should Have English Translation

LiftupWithImage
	[Tags]
	Given User Creates New LiftupWithImage Paragraphs To Library
	When User Starts Creating LandingPage With Add From Library Content For LiftupWithImage -Paragraph in Finnish Language
	And User Starts Creating LandingPage With Add From Library Content For LiftupWithImage -Paragraph in English Language
	And User Starts Creating LandingPage With Add From Library Content For LiftupWithImage -Paragraph in Swedish Language
	Then Page Should Have Finnish Translation
	Then Page Should Have English Translation
	Then Page Should Have Swedish Translation

ListOfLinks
	[Tags] 
	Given User Creates New ListOfLinks Paragraphs To Library
	When User Starts Creating LandingPage With Add From Library Content For ListOfLinks -Paragraph in Finnish Language
	And User Starts Creating LandingPage With Add From Library Content For ListOfLinks -Paragraph in English Language
	And User Starts Creating LandingPage With Add From Library Content For ListOfLinks -Paragraph in Swedish Language
	Then Page Should Have Finnish Translation
	Then Page Should Have English Translation
	Then Page Should Have Swedish Translation
	
*** Keywords ***
User Creates New Columns Paragraphs To Library	
	Create New Finnish Columns Paragraph To Library
	Create New English Columns Paragraph To Library
	Create New Swedish Columns Paragraph To Library

User Creates New Banner Paragraphs To Library	
	Create New Finnish Banner Paragraph To Library
	Create New English Banner Paragraph To Library
	Create New Swedish Banner Paragraph To Library	

User Creates New ContentCards Paragraphs To Library	
	Create New Finnish ContentCards Paragraph To Library
	Create New English ContentCards Paragraph To Library

User Creates New LiftupWithImage Paragraphs To Library	
	Create New Finnish LiftupWithImage Paragraph To Library
	Create New English LiftupWithImage Paragraph To Library
	Create New Swedish LiftupWithImage Paragraph To Library

User Creates New ListOfLinks Paragraphs To Library	
	Create New Finnish ListOfLinks Paragraph To Library
	Create New English ListOfLinks Paragraph To Library
	Create New Swedish ListOfLinks Paragraph To Library

User Starts Creating ${pagetype} With Add From Library Content For ${paragraph} -Paragraph in ${lang_selection} Language
	Go To  ${URL_content_page}
	Go To New LandingPage Site
	Create ${lang_selection} Language ${paragraph} -Paragraph ${pagetype} Content
