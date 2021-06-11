*** Settings ***
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Hero.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		LANDINGPAGE   HERO

*** Test Cases ***

Left Aligned
	[Documentation]   Left Aligned Hero Block with Short version of text files in Finnish. 'Vaakuna' style.
	[Tags]  CRITICAL
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed	

Center Aligned
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Center Aligned Page With Hero Block
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed	

Left Aligned Picture
	[Documentation]   Left Aligned Hero Block with Picture
	[Tags]  CRITICAL
	Given User Goes To New LandingPage Site
	And User Starts Creating Hero Block Page with Left Picture
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed	

Right Aligned Picture
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating Hero Block Page with Right Picture
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed
	
Bottom Aligned Picture
	[Tags]      
	Given User Goes To New LandingPage Site
	And User Starts Creating Hero Block Page with Bottom Picture
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed
	
Background Picture
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating Hero Block Page with Background Picture
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed			

Diagonal Picture
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating Hero Block Page with Diagonal Picture
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed	

Fullcolor Link
	[Documentation]   Adds Left aligned page and a link with Fullcolor styling option selected
	[Tags]  CRITICAL
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Hero Link Button With Fullcolor Style
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed

Framed Link
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Hero Link Button With Framed Style
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed

Transparent Link
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Hero Link Button With Transparent Style
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed

Gold Background Color
	[Documentation]   Left Aligned Hero Block with Background Color selection 'Gold' 
	[Tags]  CRITICAL
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Gold As Background Color
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed

Silver Background Color
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Silver As Background Color
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed
	
Brick Background Color
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Brick As Background Color
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed
	
Bus Background Color
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Bus As Background Color
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed
	
Copper Background Color
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Copper As Background Color
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed
	
Engel Background Color
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Engel As Background Color
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed
	
Fog Background Color
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Fog As Background Color
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed
	
Metro Background Color
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Metro As Background Color
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed
	
Summer Background Color
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Summer As Background Color
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed
	
Suomenlinna Background Color
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Suomenlinna As Background Color
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed
	
Tram Background Color
	[Tags]  
	Given User Goes To New LandingPage Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Tram As Background Color
	When New Landingpage is Submitted
	Then Layout Should Not Have Changed

Finnish English Swedish Translations
	[Tags]  CRITICAL
	Given User Creates a Left Aligned Page With Hero Block In Finnish Language
	And User Creates a Left Aligned Page With Hero Block In English Language
	And User Creates a Left Aligned Page With Hero Block In Swedish Language
	Then Page Should Have Finnish Translation
	And Page Should Have English Translation
	And Page Should Have Swedish Translation
	
	
	
   
*** Keywords ***
User Adds ${color} As Background Color
	Add ${color} As Background Color

User Goes To New LandingPage Site   Go To New LandingPage Site
New Landingpage is Submitted	Submit The New Landingpage

User Opens Created Content
	 Open Created Content


User Adds Hero Link Button With ${style} Style
	Add Hero Link Button With ${style} Style

User Starts Creating Hero Block Page with ${picalign} Picture
	Start Creating Hero Block Page with ${picalign} Picture
	
User Starts Creating a ${value} Aligned Page With Hero Block
	Start Creating a ${value} Aligned Page With Hero Block

User Creates a ${value} Aligned Page With Hero Block In ${lang_selection} Language
	Create a ${value} Aligned Page With Hero Block In ${lang_selection} Language

Page Should Have ${lang_input} Translation
	Set Language Pointer   ${lang_input}
	Select Language   ${lang_input}
	Page Content Matches Language

Page Content Matches Language
	${Title}=  Return Hero Title From Page
	${Content}=  Return Content From Page
	Title Should Match Current Language Selection   ${Title}
	Content Should Match Current Language Selection   ${Content}
	
Layout Should Not Have Changed
	Wait Until Keyword Succeeds  5x   200ms     Accept Cookies
	Take Screenshot Of Content
	${originalpic} =  Set Variable If
...  '${picalign}'!='${EMPTY}'  ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_LANDINGPAGE_HERO_${picalign}_vaakuna_${picture}_${BROWSER}.png
...  '${linkstyle}'!='${EMPTY}'  ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_LANDINGPAGE_HERO_left_vaakuna_nopicture_${linkstyle}link_${BROWSER}.png
...  '${color}'!='${EMPTY}'  ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_LANDINGPAGE_HERO_left_${color}_nopicture_${BROWSER}.png
...   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_LANDINGPAGE_HERO_${value}_vaakuna_nopicture_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData	  ${originalpic}   ${comparisonpic}
	

	
