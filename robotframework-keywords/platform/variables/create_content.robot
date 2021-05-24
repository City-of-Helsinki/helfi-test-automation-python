#############################     Naming Conventions    #######################
#
#				 Dropdown   = Ddn
#				 Option		= Opt
#				 Text		= Txt
#				 Switch     = Swh
#				 Frame      = Frm
#				 Input      = Inp
#				 Button     = Btn
#				 Menu-item  = Mtm
#				 Item		= Itm

*** Variables ***
#LISTS
@{pic_1_texts_fi}  							Juna sillalla   Vanha juna kuljettaa matkustajia   Testi Valokuvaaja
@{pic_1_texts_en}  							Train on The Bridge   Old Train Carries Passengers   Test Photographer
@{pic_1_texts_sv}  							Träna på bron   Gammalt tåg bär passagerare   Testfotograf
@{pic_1_texts_ru}  							Поезд на мосту  Старый поезд везет пассажиров   Тестовый фотограф
@{pic_2_texts_fi}							Temppeli koreassa   Buddhalaistemppeli talvella Aasiassa   Testi Valokuvaaja2
@{pic_2_texts_en}							Temple in Korea   Buddhist temple in winter in Asia   Test Photographer2
@{pic_2_texts_sv}							Templet i Korea   Buddistisk tempel i vinter i Asien   Testfotograf2
@{pic_2_texts_ru}							Храм в Корее   Буддийский храм зимой в Азии   Тестовый фотограф2		
${pic_1_caption_fi}							Juna puksuttaa kohti uutta pysäkkiä
${pic_1_caption_en}							The train pans towards a new stop
${pic_1_caption_sv}							Tåget går mot ett nytt stopp
${pic_1_caption_ru}							Кастрюли поезда к новой остановке
${pic_2_caption_fi}							Buddhalaisessa temppelissä suoritetaan hartausharjoituksia
${pic_2_caption_en}							In the Buddhist temple devotional exercises are performed
${pic_2_caption_sv}							I de buddhistiska templet utförs devotionsövningarna
${pic_2_caption_ru}							В буддийских храмах преданные упражнения выполняются
${link_title_fi}							Tietoa teoksesta
${link_title_en}							About a book
${link_title_sv}							Om en bok
${link_title_ru}							О книге

#SHARED
${Btn_Save}									//button[contains(text(),'Tallenna')]
${Ddn_AddContent}							//ul[@data-drupal-selector='edit-field-content-add-more-operations']//li[2]/button
${Opt_AddColumns}						    name:field_content_columns_add_more
${Opt_AddPicture}						    name:field_content_image_add_more
${Opt_AddText}								name:field_content_text_add_more
${Opt_AddLink}								name:field-content-link-add-more
${Opt_AddBanner}   							name:field_content_banner_add_more
${Opt_AddAccordion}   						name:field_content_accordion_add_more
${Opt_AddContentCards} 						name:field_content_content_cards_add_more
${Opt_AddLiftupWithImage}					name:field_content_liftup_with_image_add_more
${Btn_File_Upload}					    	name:files[upload]
${Inp_Pic_Name}								css:[data-drupal-selector=edit-media-0-fields-name-0-value]
${Inp_Pic_AltText}							css:[data-drupal-selector=edit-media-0-fields-field-media-image-0-alt]
${Inp_Pic_Photographer}						css:[data-drupal-selector=edit-media-0-fields-field-photographer-0-value]
${Btn_Insert_Pic}							//button[contains(text(),'Poimi valitut mediatiedostot')]
${Ddn_SelectLanguage}						//select[@id='edit-langcode-0-value']
${Inp_Title}								//input[@id='edit-title-0-value']
${Frm_Content}							    css:#cke_1_contents > iframe
${Frm_Content2}								css:#cke_2_contents > iframe
${Frm_Content_Description}				    css:#cke_58_contents > iframe
${Btn_Submit}							    //input[@id='edit-submit--2--gin-edit-form']		
${Mtm_Content}								//li[contains(@class, 'menu-item menu-item__system-admin_content')]
${Btn_Actions_Dropbutton}					//button[@class='dropbutton__toggle']
${Btn_Actions_ContentMenu_Deletebutton}		//li[contains(@class, 'delete dropbutton')]/child::a
${Btn_Actions_ContentMenu_Translatebutton}	//li[contains(@class, 'translate dropbutton')]/child::a
${Btn_Actions_SelectedItem_Deletebutton}	//input[@id='edit-submit']
${Opt_Link_Fullcolor}			css:[value=primary]
${Opt_Link_Framed}				css:[value=secondary]
${Opt_Link_Transparent}			css:[value=supplementary]
${Ddn_Icon} 							//select[contains(@data-drupal-selector, 'subform-field-icon')]

#HERO
${Inp_Hero_Title}							//input[contains(@id, 'edit-field-hero-0-subform')]
${Swh_HeroOnOff}						    //input[@id='edit-field-has-hero-value']
${Ddn_Hero_Alignment}						css:.select2-selection__arrow
${Opt_Hero_Alignment_Center}				css:[value=without-image-center]
${Opt_Hero_Picture_On_Right}				css:[value=with-image-right]
${Opt_Hero_Picture_On_Left}					css:[value=with-image-left]
${Opt_Hero_Picture_On_Bottom}				css:[value=with-image-bottom]
${Opt_Hero_Picture_On_Background}			css:[value=background-image]
${Opt_Hero_Diagonal}						css:[value=diagonal]
${Btn_Hero_Picture}							name:field_hero_image-media-library-open-button-field_hero-0-subform
${Btn_Hero_AddLink}						    name:field_hero_0_subform_field_hero_cta_link_add_more
${Inp_Hero_Link_URL}						css:[data-drupal-selector=edit-field-hero-0-subform-field-hero-cta-0-subform-field-link-link-0-uri]
${Inp_Hero_Link_Texteditor_URL}				css:[data-drupal-selector=edit-attributes-href]
${Inp_Hero_Link_Title}						css:[data-drupal-selector=edit-field-hero-0-subform-field-hero-cta-0-subform-field-link-link-0-title]
${Inp_Hero_Link_Texteditor_Title}			css:[data-drupal-selector=edit-attributes-data-link-text]
${Ddn_Hero_Link_Design}						css:[data-drupal-selector=edit-field-hero-0-subform-field-hero-cta-0-subform-field-link-design]
${Ddn_Hero_Link_Texteditor_Design}			css:[data-drupal-selector=edit-attributes-class]
${Opt_Hero_Link_Texteditor_ButtonFullcolor}		//option[@value='hds-button hds-button--primary']
${Opt_Hero_Link_Texteditor_ButtonFramed}		//option[@value='hds-button hds-button--secondary']
${Opt_Hero_Link_Texteditor_ButtonTransparent}	//option[@value='hds-button hds-button--supplementary']
${Ddn_Hero_Color}							//select[@data-drupal-selector='edit-field-hero-0-subform-field-hero-bg-color']

#COLUMNS
${Inp_Column_Title}	  						//input[contains(@data-drupal-selector, 'subform-field-columns-title-0-value')]
${Ddn_Column_Left_AddContent}               //ul[contains(@data-drupal-selector, 'subform-field-columns-left-column-add-more-operations')]//button
${Ddn_Column_Right_AddContent}				//ul[contains(@data-drupal-selector, 'subform-field-columns-right-column-add-more-operations')]//button
${Opt_Column_Left_AddContent_Image}			//ul[contains(@data-drupal-selector, 'subform-field-columns-left-column-add-more-operations')]//input[contains(@name,'subform_field_columns_left_column_image_add_more')]
${Opt_Column_Left_AddContent_Text}			//ul[contains(@data-drupal-selector, 'subform-field-columns-left-column-add-more-operations')]//input[contains(@name,'subform_field_columns_left_column_text_add_more')]
${Opt_Column_Left_AddContent_ListOfLinks}	//ul[@data-drupal-selector='edit-field-content-1-subform-field-columns-left-column-add-more-operations']//input[@name='field_content_1_subform_field_columns_left_column_list_of_links_add_more']
${Opt_Column_Left_AddContent_Link}			//ul[contains(@data-drupal-selector, 'subform-field-columns-left-column-add-more-operations')]//input[contains(@name,'subform_field_columns_left_column_link_add_more')]
${Opt_Column_Right_AddContent_Link}			//ul[contains(@data-drupal-selector, 'subform-field-columns-right-column-add-more-operations')]//input[contains(@name,'subform_field_columns_right_column_link_add_more')]
${Opt_Column_Right_AddContent_Image}		//ul[contains(@data-drupal-selector, 'subform-field-columns-right-column-add-more-operations')]//input[contains(@name,'subform_field_columns_right_column_image_add_more')]
${Opt_Column_Right_AddContent_Text}			//ul[contains(@data-drupal-selector, 'subform-field-columns-right-column-add-more-operations')]//input[contains(@name,'subform_field_columns_right_column_text_add_more')]
${Btn_Column_Left_AddPicture}				name:field_image-media-library-open-button-field_content-1-subform-field_columns_left_column-0-subform
${Btn_Column_Right_AddPicture}				name:field_image-media-library-open-button-field_content-1-subform-field_columns_right_column-0-subform
${Frm_Column_Left_Text}						//div[contains(@id,'cke_edit-field-content')][contains(@id,'left')]//iframe
${Frm_Column_Right_Text}					//div[contains(@id,'cke_edit-field-content')][contains(@id,'right')]//iframe
${Btn_Column_Left_Picture}					//input[contains(@data-drupal-selector, 'subform-field-image-open-button')][contains(@data-drupal-selector, 'left')]
${Btn_Column_Right_Picture}					//input[contains(@data-drupal-selector, 'subform-field-image-open-button')][contains(@data-drupal-selector, 'right')]
${Btn_Column_Right_Edit}					name:field_content_1_subform_field_columns_right_column_0_edit
${Btn_Column_Left_Edit}						name:field_content_1_subform_field_columns_left_column_0_edit
${Inp_Column_Left_Picture_Caption}			//textarea[contains(@data-drupal-selector, 'subform-field-image-caption')][contains(@data-drupal-selector, 'left')]
${Inp_Column_Right_Picture_Caption}			//textarea[contains(@data-drupal-selector, 'subform-field-image-caption')][contains(@data-drupal-selector, 'right')]
${Swh_Column_Left_Picture_Orig_Aspect_Ratio}   //input[contains(@data-drupal-selector, 'field-original-aspect-ratio-value')][contains(@data-drupal-selector, 'left')]
${Swh_Column_Right_Picture_Orig_Aspect_Ratio}   //input[contains(@data-drupal-selector, 'field-original-aspect-ratio-value')][contains(@data-drupal-selector, 'right')]
${Inp_Column_Left_Link_Title}				css:[data-drupal-selector=edit-field-content-1-subform-field-columns-left-column-0-subform-field-link-link-0-title]
${Inp_Column_Right_Link_Title}				css:[data-drupal-selector=edit-field-content-1-subform-field-columns-right-column-0-subform-field-link-link-0-title]
${Inp_Column_Left_Link_URL}					css:[data-drupal-selector=edit-field-content-1-subform-field-columns-left-column-0-subform-field-link-link-0-uri]
${Inp_Column_Right_Link_URL}				css:[data-drupal-selector=edit-field-content-1-subform-field-columns-right-column-0-subform-field-link-link-0-uri]	
${Ddn_Column_Left_Link_Design}				css:[data-drupal-selector=edit-field-content-1-subform-field-columns-left-column-0-subform-field-link-design]
${Ddn_Column_Right_Link_Design}				css:[data-drupal-selector=edit-field-content-1-subform-field-columns-right-column-0-subform-field-link-design]	
${Opt_Column_Left_Link_ButtonFullcolor}		//select[@data-drupal-selector='edit-field-content-1-subform-field-columns-left-column-0-subform-field-link-design']//option[@value='primary']
${Opt_Column_Right_Link_ButtonFullcolor}	//select[@data-drupal-selector='edit-field-content-1-subform-field-columns-right-column-0-subform-field-link-design']//option[@value='primary']
${Opt_Column_Left_Link_ButtonFramed}		//select[@data-drupal-selector='edit-field-content-1-subform-field-columns-left-column-0-subform-field-link-design']//option[@value='secondary']
${Opt_Column_Right_Link_ButtonFramed}		//select[@data-drupal-selector='edit-field-content-1-subform-field-columns-right-column-0-subform-field-link-design']//option[@value='secondary']
${Opt_Column_Left_Link_ButtonTransparent}	//select[@data-drupal-selector='edit-field-content-1-subform-field-columns-left-column-0-subform-field-link-design']//option[@value='supplementary']
${Opt_Column_Right_Link_ButtonTransparent}	//select[@data-drupal-selector='edit-field-content-1-subform-field-columns-right-column-0-subform-field-link-design']//option[@value='supplementary']

#GALLERY
${Opt_AddGallery}						    name:field_content_gallery_add_more
${Btn_Gallery_Picture}						name:field_gallery_slide_media-media-library-open-button-field_content-1-subform-field_gallery_slides-
${Btn_Gallery_Picture_Addmore}				name:field_content_1_subform_field_gallery_slides_gallery_slide_add_more
# PAGE VIEW
${Txt_Hero_Title}								css:.hero__title
${Txt_Hero_Description}							css:.hero__description
${Txt_Content}									css:.text__text-content
${Txt_Column_Title}								css:.columns__title
${Txt_Column_Description}						xpath://p[1]
${Txt_Column_Content}							xpath://div[@class='columns columns--default columns--50-50']//p
${Txt_Column_Content}
${Itm_Gallery_Slidetrack}						id:splide01-track
# ARTICLE SPESIFIC
${Inp_Author}								name:field_author[0][value]
${Inp_Lead}									name:field_lead[0][value]
${Inp_Keywords}								css:.select2-search__field
${Txt_Lead}									css:.article__lead
${Txt_Author}								css:.article__author

# BANNER
${Opt_Banner_Left}							css:[value=align-left]
${Inp_Banner_Title}							name:field_content[0][subform][field_banner_title][0][value]

${Inp_Banner_Link_Uri}						name:field_content[0][subform][field_banner_link][0][uri]
${Inp_Banner_Link_Title}					name:field_content[0][subform][field_banner_link][0][title]
${Swh_Banner_Link_OpenInNewWindow}   		name:field_content[0][subform][field_banner_link][0][options][target_new]
#UNCATEGORIZED
${Btn_Picture}								name:field_image-media-library-open-button-field_content-1-subform

#ACCORDION
${Inp_Accordion_Title}	  					//input[contains(@data-drupal-selector, 'subform-field-accordion-item-heading-0-value')]
${Ddn_Accordion_AddContent}					//ul[contains(@data-drupal-selector, 'subform-field-accordion-item-content-add-more-operations')]//li[2]/button
${Opt_Accordion_Content_Text}				//input[contains(@name, 'subform_field_accordion_item_content_text_add_more')]
${Opt_Accordion_Content_Columns}			//input[contains(@name, 'subform_field_accordion_item_content_columns_add_more')]
${Frm_Accordion_Content}					css:#cke_121_contents > iframe	
${Btn_Accordion_View}						css:#handorgel1-fold1-header > button
${Opt_Accordion_Column_Left_AddContent_Text}	//ul[contains(@data-drupal-selector, 'subform-field-columns-left-column-add-more-operations')]//input[contains(@name,'subform_field_accordion_item_content_text_add_more')]
${Opt_Accordion_Column_Right_AddContent_Text}	//ul[contains(@data-drupal-selector, 'subform-field-columns-right-column-add-more-operations')]//input[contains(@name,'subform_field_accordion_item_content_text_add_more')]

# CONTENT_CARDS
${Inp_ContentCard_Title}							name:field_content[1][subform][field_content_cards_title][0][value]
${Inp_ContentCard_Landingpage_Title}				name:field_content[0][subform][field_content_cards_title][0][value]
${Inp_ContentCard_Design}							name:field_content[1][subform][field_content_cards_design][0]
${Inp_ContentCard_Landingpage_Design}				name:field_content[0][subform][field_content_cards_design][0]
${Inp_ContentCard_TargetId}							//input[contains(@name, 'target_id')]
${Inp_ContentCard_Addnew}							//input[contains(@name, 'subform_field_content_cards_content_add_more')]

#LIST-OF-LINKS
${Opt_AddListOfLinks}							    name:field_content_list_of_links_add_more
${Inp_ListOfLinks_Title}							name:field_content[1][subform][field_list_of_links_title][0][value]
${Inp_ListOfLinks_Design}							//select[contains(@name, 'field_list_of_links_design')]
${Inp_ListOfLinks_Link_Uri}							//input[contains(@name, 'field_list_of_links_link')][contains(@name, 'uri')]
${Inp_ListOfLinks_Link_Title}		    			//input[contains(@name, 'field_list_of_links_link')][contains(@name, 'title')]
${Inp_ListOfLinks_Link_NewLink}						//input[contains(@name, 'field_list_of_links_links_list')][contains(@name, 'add_more')]
${Inp_ListOfLinks_Link_Picture}					    name:field_list_of_links_image-media-library-open-button-field_content-1-subform-field_list_of_links_links-0-subform
${Inp_ListOfLinks_Link_Picture_Landingpage}			name:field_list_of_links_image-media-library-open-button-field_content-0-subform-field_list_of_links_links-0-subform
${Inp_ListOfLinks_Link_Picture2}				    name:field_list_of_links_image-media-library-open-button-field_content-1-subform-field_list_of_links_links-1-subform
${Inp_ListOfLinks_Link_Picture2_Landingpage}	    name:field_list_of_links_image-media-library-open-button-field_content-0-subform-field_list_of_links_links-1-subform
${Inp_ListOfLinks_Link_Description}					//input[contains(@name, 'field_list_of_links_link')][contains(@name, 'value')]
${Inp_ListOfLinks_Link_Description2}				name:field_content[1][subform][field_list_of_links_links][1][subform][field_list_of_links_desc][0][value]
${Swh_ListOfLinks_Link_OpenInNewTab}				//input[contains(@name, 'field_list_of_links_link')][contains(@name, 'target_new')]

#LIFTUP-WITH-IMAGE
${Inp_LiftupWithImage_Title}		    			//input[contains(@name, 'liftup_with_image')][contains(@name, 'title')]
${Inp_LiftupWithImage_Picture}		    			//input[contains(@name, 'liftup_with_image')][contains(@name, 'image-media-library-open-button')]
${Inp_LiftupWithImage_Design}						name:field_content[0][subform][field_liftup_with_image_design][0]

#SERVICE
${Inp_Service_Title}								name:title[0][value]
${Inp_Service_Visible_Title}						name:field_service_visible_title[0][value]
${Inp_Service_ParentService}						name:field_service_parent_service[0][target_id]