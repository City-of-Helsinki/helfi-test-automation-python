*** Settings ***
Documentation   Testing Gallery. Actually just checking that layout is not broken. No functional testing of the gallery
...			    component atm.
Resource        ../../../../../robotframework-keywords/platform/Paragraphs/Gallery.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PAGE   GALLERY

*** Test Cases ***
Browse Gallery Images
	[Tags]   CRITICAL
	Given User Goes To New Page -Site
	And User Starts Creating Page With Gallery
	When User Submits The New Page
	Then Layout Should Not Have Changed
	And Moving Between Gallery Images Works
		
	
*** Keywords ***
User Goes To New Page -Site  	Go To New Page Site
User Submits The New Page   	
	Submit The New Page 

User Starts Creating Page With Gallery  Create Page With Gallery

Layout Should Not Have Changed
	Run Keyword And Ignore Error  Accept Cookies
	Gallery.Take Screenshot Of Content
	Compare Two Pictures
