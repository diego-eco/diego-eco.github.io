<?php
/**
 * personal Theme Customizer.
 *
 * @package personal
 */

/**
 * Add postMessage support for site title and description for the Theme Customizer.
 *
 * @param WP_Customize_Manager $wp_customize Theme Customizer object.
 */
function personal_customize_register( $wp_customize ) {
	$wp_customize->get_setting( 'blogname' )->transport         = 'postMessage';
	$wp_customize->get_setting( 'blogdescription' )->transport  = 'postMessage'; 
	$wp_customize->get_setting( 'header_textcolor' )->transport = 'postMessage';
	
	//-------------------------------------------------------------------------------------------------------------------//
// Move and Replace
//-------------------------------------------------------------------------------------------------------------------// 
	
	//Colors
	$wp_customize->add_panel( 'personal_colors_panel', array( 
    'priority'       => 40,
    'capability'     => 'edit_theme_options',
    'theme_supports' => '',
    'title'          => esc_html__( 'General Colors', 'personal' ),
    'description'    => esc_html__( 'Edit your general color settings.', 'personal' ),
	));
	
	// colors
	$wp_customize->add_section( 'colors', array(
	'title' => esc_html__( 'Theme Colors', 'personal' ),  
	'priority' => '10', 
	'panel' => 'personal_colors_panel' 
	) );
	
	// Move sections up 
	$wp_customize->get_section('static_front_page')->priority = 8; 
	$wp_customize->get_section('title_tagline')->priority = 10;
	$wp_customize->remove_section('header_image'); 
	
//-------------------------------------------------------------------------------------------------------------------//
// Hero Section
//-------------------------------------------------------------------------------------------------------------------//
	
	//Home Hero Section
    $wp_customize->add_section( 'personal_home_hero_section' , array(  
	    'title'       => esc_html__( 'Home Hero Section', 'personal' ),
		'active_callback' => 'is_front_page', 
	    'priority'    => 22, 
	    'description' => esc_html__( 'Edit the options for the Home Page Hero section.', 'personal'),
	));
	
	$wp_customize->add_setting( 'personal_home_bg_image', array( 
		'sanitize_callback' => 'esc_url_raw',
	));

	$wp_customize->add_control( new WP_Customize_Image_Control( $wp_customize, 'personal_home_bg_image', array( 
		'label'    => esc_html__( 'Background Image', 'personal' ),
		'type'     => 'image', 
		'section'  => 'personal_home_hero_section', 
		'settings' => 'personal_home_bg_image', 
		'priority' => 10,
	)));
	
	$wp_customize->add_setting( 'personal_hero_bg_color', array(
        'default'     => '#ececec', 
        'sanitize_callback' => 'sanitize_hex_color',
    ));
 
    $wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, 'personal_hero_bg_color', array(
        'label'	   => esc_html__( 'Background Color', 'personal' ),
		'description' => esc_html__( 'If not using a background image, set your background color here.', 'personal' ),
        'section'  => 'personal_home_hero_section',
        'settings' => 'personal_hero_bg_color',
		'priority' => 15
    ))); 
	
//-------------------------------------------------------------------------------------------------------------------//
// Navigation Colors
//-------------------------------------------------------------------------------------------------------------------//

	// Nav Colors
    $wp_customize->add_section( 'personal_nav_colors_section' , array(  
	    'title'       => esc_html__( 'Navigation', 'personal' ),
	    'priority'    => 10, 
	    'description' => esc_html__( 'Set your theme navigation colors.', 'personal'),
	));

	$wp_customize->add_setting( 'personal_nav_link_color', array(
        'default'     => '#ffffff',
        'sanitize_callback' => 'sanitize_hex_color',
    ));
 
    $wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, 'personal_nav_link_color', array(
        'label'	   => esc_html__( 'Navigation Link', 'personal' ),
        'section'  => 'personal_nav_colors_section',
        'settings' => 'personal_nav_link_color', 
		'priority' => 5, 
    )));
	
//-------------------------------------------------------------------------------------------------------------------//
// General Colors
//-------------------------------------------------------------------------------------------------------------------//

	$wp_customize->add_setting( 'personal_text_color', array(
        'default'     => '#404040',
        'sanitize_callback' => 'sanitize_hex_color',
    ));
 
    $wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, 'personal_text_color', array(
        'label'	   => esc_html__( 'Text Color', 'personal' ),
        'section'  => 'colors',
        'settings' => 'personal_text_color',
		'priority' => 10 
    ))); 
	
	$wp_customize->add_setting( 'personal_heading_color', array(
        'default'     => '#404040',
        'sanitize_callback' => 'sanitize_hex_color',
    ));
 
    $wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, 'personal_heading_color', array(
        'label'	   => esc_html__( 'Heading Color', 'personal' ),
        'section'  => 'colors',
        'settings' => 'personal_heading_color', 
		'priority' => 11
    ))); 
	
    $wp_customize->add_setting( 'personal_link_color', array( 
        'default'     => '#000000',   
        'sanitize_callback' => 'sanitize_hex_color',
    ));
 
    $wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, 'personal_link_color', array(
        'label'	   => esc_html__( 'Link Color', 'personal'),
        'section'  => 'colors',
        'settings' => 'personal_link_color', 
		'priority' => 30
    )));
	
	//Page Colors
    $wp_customize->add_section( 'personal_page_colors_section' , array(  
	    'title'       => esc_html__( 'Page Colors', 'personal' ),
	    'priority'    => 20, 
	    'description' => esc_html__( 'Set your page colors.', 'personal'),
		'panel' => 'personal_colors_panel', 
	));
	
	$wp_customize->add_setting( 'personal_entry', array(
        'default'     => '#404040', 
        'sanitize_callback' => 'sanitize_hex_color',
    ));
 
    $wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, 'personal_entry', array(
        'label'	   => esc_html__( 'Entry Title Color', 'personal' ), 
        'section'  => 'personal_page_colors_section',
        'settings' => 'personal_entry',  
		'priority' => 20
    )));

	$wp_customize->add_setting( 'personal_custom_color', array(
        'default'     => '#222222',
        'sanitize_callback' => 'sanitize_hex_color',
    ));
 
    $wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, 'personal_custom_color', array(
        'label'	   => esc_html__( 'Button Border Color', 'personal' ),
        'section'  => 'personal_page_colors_section',
        'settings' => 'personal_custom_color',
		'priority' => 40 
    ))); 
	
	$wp_customize->add_setting( 'personal_button_text_color', array(
        'default'     => '#222222',
        'sanitize_callback' => 'sanitize_hex_color',
    ));
 
    $wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, 'personal_button_text_color', array(
        'label'	   => esc_html__( 'Button Text Color', 'personal' ),
         'section'  => 'personal_page_colors_section',
        'settings' => 'personal_button_text_color',
		'priority' => 45
    )));
	
	$wp_customize->add_setting( 'personal_custom_color_hover', array(
        'default'     => '#222222', 
        'sanitize_callback' => 'sanitize_hex_color',
    ));
 
    $wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, 'personal_custom_color_hover', array(
        'label'	   => esc_html__( 'Button Hover Color', 'personal' ),
        'section'  => 'personal_page_colors_section',
        'settings' => 'personal_custom_color_hover', 
		'priority' => 50  
    )));
	
	$wp_customize->add_setting( 'personal_button_text_hover_color', array(
        'default'     => '#ffffff',
        'sanitize_callback' => 'sanitize_hex_color',
    ));
 
    $wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, 'personal_button_text_hover_color', array(
        'label'	   => esc_html__( 'Button Hover Text Color', 'personal' ),
        'section'  => 'personal_page_colors_section',
        'settings' => 'personal_button_text_hover_color',
		'priority' => 55
    )));


//-------------------------------------------------------------------------------------------------------------------//
// Social Icons
//-------------------------------------------------------------------------------------------------------------------//

	
	//Social Section
	$wp_customize->add_section( 'personal_settings', array(
            'title'          => esc_html__( 'Social Media Icons', 'personal' ),
			'description'    => esc_html__( 'Edit your social media icons', 'personal' ),
            'priority'       => 38,
    ) );
	
	//Hide Social Section 
	$wp_customize->add_setting('active_social',
	    array(
	        'sanitize_callback' => 'personal_sanitize_checkbox',
	)); 
	
	$wp_customize->add_control( 
    'active_social', 
    array(
        'type' => 'checkbox',
        'label' => esc_html__( 'Hide Social Media Icons', 'personal' ),
        'section' => 'personal_settings',  
		'priority'   => 10
    ));
	
	//social font size
    $wp_customize->add_setting( 
        'personal_social_text_size',
        array(
            'sanitize_callback' => 'absint',
            'default'           => '16', 
        )
    );
	
    $wp_customize->add_control( 'personal_social_text_size', array(
        'type'        => 'number', 
        'priority'    => 15,
        'section'     => 'personal_settings', 
        'label'       => esc_html__('Social Icon Size', 'personal'), 
        'input_attrs' => array(
            'min'   => 10,
            'max'   => 32, 
            'step'  => 1,
            'style' => 'margin-bottom: 10px;',
        ),
  	));
		
	//Social Icon Colors
	$wp_customize->add_setting( 'personal_social_color', array( 
        'default'     => '#ffffff',  
		'sanitize_callback' => 'sanitize_hex_color', 
    ));
	
	$wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, 'personal_social_color', array(
        'label'	   => esc_html__( 'Social Icon', 'personal' ),
        'section'  => 'personal_settings',
        'settings' => 'personal_social_color', 
		'priority' => 20
    )));


	
//-------------------------------------------------------------------------------------------------------------------//
// Fonts
//-------------------------------------------------------------------------------------------------------------------//	
	
    $wp_customize->add_section(
        'personal_typography',
        array(
            'title' => esc_html__('Fonts', 'personal' ),   
            'priority' => 45, 
    ));
	
    $font_choices = 
        array(
			' ',
			'Lusitana:400,700' => 'Lusitana',
			'PT Serif:400,700' => 'PT Serif', 
			'Montserrat:400,700' => 'Montserrat', 
			'Lato:400,700,400italic,700italic' => 'Lato',
			'Open Sans:400italic,700italic,400,700' => 'Open Sans',
			'Playfair Display:400,700,400italic' => 'Playfair Display',
			'Source Sans Pro:400,700,400italic,700italic' => 'Source Sans Pro',
			'Oswald:400,700' => 'Oswald',
			'Raleway:400,700' => 'Raleway',
            'Droid Sans:400,700' => 'Droid Sans', 
            'Arvo:400,700,400italic,700italic' => 'Arvo',
            'Lora:400,700,400italic,700italic' => 'Lora',
			'Merriweather:400,300italic,300,400italic,700,700italic' => 'Merriweather',
			'Oxygen:400,300,700' => 'Oxygen',
            'PT Sans:400,700,400italic,700italic' => 'PT Sans',
            'PT Sans Narrow:400,700' => 'PT Sans Narrow',
			'Cabin:400,700,400italic' => 'Cabin',
			'Fjalla One:400' => 'Fjalla One',
			'Francois One:400' => 'Francois One',
			'Josefin Sans:400,300,600,700' => 'Josefin Sans',  
			'Libre Baskerville:400,400italic,700' => 'Libre Baskerville',
            'Arimo:400,700,400italic,700italic' => 'Arimo',
            'Ubuntu:400,700,400italic,700italic' => 'Ubuntu',
            'Bitter:400,700,400italic' => 'Bitter',
            'Droid Serif:400,700,400italic,700italic' => 'Droid Serif',
			'Lobster:400' => 'Lobster',
            'Roboto:400,400italic,700,700italic' => 'Roboto',
            'Open Sans Condensed:700,300italic,300' => 'Open Sans Condensed',
            'Roboto Condensed:400italic,700italic,400,700' => 'Roboto Condensed',
            'Roboto Slab:400,700' => 'Roboto Slab',
            'Yanone Kaffeesatz:400,700' => 'Yanone Kaffeesatz',
            'Mandali:400' => 'Mandali',
			'Vesper Libre:400,700' => 'Vesper Libre',
			'NTR:400' => 'NTR',
			'Dhurjati:400' => 'Dhurjati',
			'Faster One:400' => 'Faster One',
			'Mallanna:400' => 'Mallanna',
			'Averia Libre:400,300,700,400italic,700italic' => 'Averia Libre',
			'Galindo:400' => 'Galindo',
			'Titan One:400' => 'Titan One',
			'Abel:400' => 'Abel',
			'Nunito:400,300,700' => 'Nunito',
			'Poiret One:400' => 'Poiret One',
			'Signika:400,300,600,700' => 'Signika',
			'Muli:400,400italic,300italic,300' => 'Muli',
			'Play:400,700' => 'Play',
			'Bree Serif:400' => 'Bree Serif',
			'Archivo Narrow:400,400italic,700,700italic' => 'Archivo Narrow',
			'Cuprum:400,400italic,700,700italic' => 'Cuprum',
			'Noto Serif:400,400italic,700,700italic' => 'Noto Serif',
			'Pacifico:400' => 'Pacifico',
			'Alegreya:400,400italic,700italic,700,900,900italic' => 'Alegreya',
			'Asap:400,400italic,700,700italic' => 'Asap',
			'Maven Pro:400,500,700' => 'Maven Pro',
			'Dancing Script:400,700' => 'Dancing Script',
			'Karla:400,700,400italic,700italic' => 'Karla',
			'Merriweather Sans:400,300,700,400italic,700italic' => 'Merriweather Sans',
			'Exo:400,300,400italic,700,700italic' => 'Exo',
			'Varela Round:400' => 'Varela Round',
			'Cabin Condensed:400,600,700' => 'Cabin Condensed',
			'PT Sans Caption:400,700' => 'PT Sans Caption',
			'Cinzel:400,700' => 'Cinzel',
			'News Cycle:400,700' => 'News Cycle',
			'Inconsolata:400,700' => 'Inconsolata',
			'Architects Daughter:400' => 'Architects Daughter',
			'Quicksand:400,700,300' => 'Quicksand',
			'Titillium Web:400,300,400italic,700,700italic' => 'Titillium Web',
			'Quicksand:400,700,300' => 'Quicksand',
			'Monda:400,700' => 'Monda',
			'Didact Gothic:400' => 'Didact Gothic',
			'Coming Soon:400' => 'Coming Soon',
			'Ropa Sans:400,400italic' => 'Ropa Sans',
			'Tinos:400,400italic,700,700italic' => 'Tinos',
			'Glegoo:400,700' => 'Glegoo',
			'Pontano Sans:400' => 'Pontano Sans',
			'Fredoka One:400' => 'Fredoka One',
			'Lobster Two:400,400italic,700,700italic' => 'Lobster Two',
			'Quattrocento Sans:400,700,400italic,700italic' => 'Quattrocento Sans',
			'Covered By Your Grace:400' => 'Covered By Your Grace',
			'Changa One:400,400italic' => 'Changa One',
			'Marvel:400,400italic,700,700italic' => 'Marvel',
			'BenchNine:400,700,300' => 'BenchNine',
			'Orbitron:400,700,500' => 'Orbitron',
			'Crimson Text:400,400italic,600,700,700italic' => 'Crimson Text',
			'Bangers:400' => 'Bangers',
			'Courgette:400' => 'Courgette',
    );
	
	//body font size
    $wp_customize->add_setting(
        'personal_body_size',
        array(
            'sanitize_callback' => 'absint',
            'default'           => '16', 
        )
    );
	
    $wp_customize->add_control( 'personal_body_size', array(
        'type'        => 'number', 
        'priority'    => 10,
        'section'     => 'personal_typography',
        'label'       => esc_html__('Body Font Size', 'personal'), 
        'input_attrs' => array(
            'min'   => 10,
            'max'   => 28,
            'step'  => 1,
            'style' => 'margin-bottom: 10px;',
        ),
  	));
    
    $wp_customize->add_setting(
        'headings_fonts',
        array(
            'sanitize_callback' => 'personal_sanitize_fonts',
    ));
    
    $wp_customize->add_control(
        'headings_fonts',
        array(
            'type' => 'select',
			'default'           => '20', 
            'description' => esc_html__('Select your desired font for the headings. Lusitana is the default Heading font.', 'personal'),
            'section' => 'personal_typography',
            'choices' => $font_choices
    ));
    
    $wp_customize->add_setting(
        'body_fonts',
        array(
            'sanitize_callback' => 'personal_sanitize_fonts',
    ));
    
    $wp_customize->add_control(
        'body_fonts',
        array(
            'type' => 'select',
			'default'           => '30', 
            'description' => esc_html__( 'Select your desired font for the body. PT Serif is the default Body font.', 'personal' ), 
            'section' => 'personal_typography',   
            'choices' => $font_choices 
    ));
	

//-------------------------------------------------------------------------------------------------------------------//
// Blog Layout
//-------------------------------------------------------------------------------------------------------------------//

    $wp_customize->add_section( 'personal_layout_section' , array( 
	    'title'       => esc_html__( 'Blog', 'personal' ),
	    'priority'    => 38, 
	    'description' => 'Change how Personal displays posts',
	));
	
	//Blog Colors
	$wp_customize->add_setting( 'personal_post_nav_bg', array( 
        'default'     => '#3d3d41', 
		'sanitize_callback' => 'sanitize_hex_color', 
    )); 
	
	$wp_customize->add_control( new WP_Customize_Color_Control( $wp_customize, 'personal_post_nav_bg', array(
        'label'	   => esc_html__( 'Post Navigation Background', 'personal' ), 
        'section'  => 'personal_layout_section',
        'settings' => 'personal_post_nav_bg',
		'priority' => 40
    ))); 
	
	//Post Content
	$wp_customize->add_setting( 'personal_post_content', array(
		'default'	        => 'option1',
		'sanitize_callback' => 'personal_sanitize_index_content',
	));

	$wp_customize->add_control( new WP_Customize_Control( $wp_customize, 'personal_post_content', array(
		'label'    => esc_html__( 'Post content', 'personal' ),
		'section'  => 'personal_layout_section',
		'settings' => 'personal_post_content', 
		'type'     => 'radio',
		'priority'   => 30, 
		'choices'  => array(
			'option1' => esc_html__( 'Excerpts', 'personal' ), 
			'option2' => esc_html__( 'Full content', 'personal' ), 
			),
	)));
	
	//Excerpt
    $wp_customize->add_setting(
        'exc_length',
        array(
            'sanitize_callback' => 'absint',
            'default'           => '30',
    ));
	
    $wp_customize->add_control( 'exc_length', array( 
        'type'        => 'number',
        'priority'    => 2, 
        'section'     => 'personal_layout_section',
        'label'       => esc_html__( 'Excerpt length', 'personal' ),
		'priority'   => 40,
        'description' => esc_html__( 'Default: 30 words', 'personal' ),
        'input_attrs' => array(
            'min'   => 10,
            'max'   => 200,
            'step'  => 5
        ), 
	));
	
	//Excluded Terms
	$wp_customize->add_setting( 'personal_post_nav_terms',
	    array(
	        'sanitize_callback' => 'personal_sanitize_text',
	));  

	$wp_customize->add_control( new WP_Customize_Control( $wp_customize, 'personal_post_nav_terms', array(
		'label'    => esc_html__( 'Post Navigation Excluded Categories', 'personal' ),
		'description'    => esc_html__( 'If you would like to exclude certain categories from the navigation at the bottom of single post pages, enter in the category numbers in the field below. Separate each number with a comma. For example: 15, 17, 18', 'personal' ),
		'section'  => 'personal_layout_section',   
		'settings' => 'personal_post_nav_terms',
		'priority'   => 50
	))); 
	
}
add_action( 'customize_register', 'personal_customize_register' );

/**
 * Binds JS handlers to make Theme Customizer preview reload changes asynchronously.
 */
function personal_customize_preview_js() {
	wp_enqueue_script( 'personal_customizer', get_template_directory_uri() . '/js/customizer.js', array( 'customize-preview' ), '20151215', true );
}
add_action( 'customize_preview_init', 'personal_customize_preview_js' );
