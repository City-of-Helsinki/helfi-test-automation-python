*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Create UnitContactCard With ${selection} Data
	[Documentation]   Selection values = Full , No . 'Full' shows all data for unit, 'No' shows minimal amount of data
	Input Non-paragraph Related Content   Page
	Wait Until Keyword Succeeds  5x  200ms  Open Paragraph For Edit   ${Opt_UnitContactCard}
	Wait Until Keyword Succeeds  5x  200ms  Input Text  ${Inp_UnitContactCard_Title}   UnitContactCard Title
	Wait Until Keyword Succeeds  5x  200ms  Input Text  ${Inp_UnitContactCard_Unit}   Otaniemen kirjasto
	IF    ('${selection}'=='Full')
		Click Element	${Swh_UnitContactCard_Postal}
		Click Element	${Swh_UnitContactCard_Opening}
		Click Element	${Swh_UnitContactCard_UseOverride}
		Click Element	${Swh_UnitContactCard_Details}
		Click Element	${Swh_UnitContactCard_Link}
	ELSE
		Click Element	${Swh_UnitContactCard_Address}
		Click Element	${Swh_UnitContactCard_Phone}
		Click Element	${Swh_UnitContactCard_Picture}
	END
	