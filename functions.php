<?php
/**
 * personal functions and definitions.
 *
 * @link https://developer.wordpress.org/themes/basics/theme-functions/
 *
 * @package personal
 */
 
/**
 * register the theme update
 */ 
require 'theme-updates/theme-update-checker.php';
$MyThemeUpdateChecker = new ThemeUpdateChecker(
'personal_mt', //Theme slug. Usually the same as the name of its directory.
'http://modernthemes.net/updates/?action=get_metadata&slug=personal_mt' //Metadata URL.
);
 

if ( ! function_exists( 'personal_setup' ) ) :
/**
 * Sets up theme defaults and registers support for various WordPress features.
 *
 * Note that this function is hooked into the after_setup_theme hook, which
 * runs before the init hook. The init hook is too late for some features, such
 * as indicating support for post thumbnails.
 */
function personal_setup() {
	/*
	 * Make theme available for translation.
	 * Translations can be filed in the /languages/ directory.
	 * If you're building a theme based on personal, use a find and replace
	 * to change 'personal' to the name of your theme in all the template files.
	 */
	load_theme_textdomain( 'personal', get_template_directory() . '/languages' );

	// Add default posts and comments RSS feed links to head.
	add_theme_support( 'automatic-feed-links' );

	/*
	 * Let WordPress manage the document title.
	 * By adding theme support, we declare that this theme does not use a
	 * hard-coded <title> tag in the document head, and expect WordPress to
	 * provide it for us.
	 */
	add_theme_support( 'title-tag' );

	/*
	 * Enable support for Post Thumbnails on posts and pages.
	 *
	 * @link https://developer.wordpress.org/themes/functionality/featured-images-post-thumbnails/
	 */
	add_theme_support( 'post-thumbnails' );
	add_image_size( 'blog-image', 350, 350, true );
	add_image_size( 'personal-portfolio', 300, 100, true );

	// This theme uses wp_nav_menu() in one location.
	register_nav_menus( array(
		'primary' => esc_html__( 'Primary Menu', 'personal' ),
		'social'  => esc_html__( 'Social', 'personal' ), 
	) );
	
	/*
	 * Enable support for Post Formats.
	 * See https://developer.wordpress.org/themes/functionality/post-formats/
	 */
	add_theme_support( 'post-formats', array(
		'status',
		'image',
	) );
	
	/*
	 * Switch default core markup for search form, comment form, and comments
	 * to output valid HTML5.
	 */
	add_theme_support( 'html5', array(
		'search-form',
		'comment-form',
		'comment-list',
		'gallery',
		'caption',
	) );
	
	// Set logo support
    add_theme_support( 'custom-logo' ); 

	// Set up the WordPress core custom background feature.
	add_theme_support( 'custom-background', apply_filters( 'personal_custom_background_args', array(
		'default-color' => 'ffffff',
		'default-image' => '', 
	))); 
	
	add_theme_support( 'custom-header', apply_filters( 'mod_custom_header_args', array(
		'default-text-color'     => 'ffffff',
	))); 
	
	// Indicate widget sidebars can use selective refresh in the Customizer.
	add_theme_support( 'customize-selective-refresh-widgets' );
}
endif;
add_action( 'after_setup_theme', 'personal_setup' );

/**
 * Set the content width in pixels, based on the theme's design and stylesheet.
 *
 * Priority 0 to make it available to lower priority callbacks.
 *
 * @global int $content_width
 */
function personal_content_width() {
	$GLOBALS['content_width'] = apply_filters( 'personal_content_width', 640 );
}
add_action( 'after_setup_theme', 'personal_content_width', 0 );

/**
 * Register widget area.
 *
 * @link https://developer.wordpress.org/themes/functionality/sidebars/#registering-a-sidebar
 */
function personal_widgets_init() {
	register_sidebar( array(
		'name'          => esc_html__( 'Sidebar', 'personal' ),
		'id'            => 'sidebar-1',
		'description'   => esc_html__( 'Add widgets here.', 'personal' ),
		'before_widget' => '<section id="%1$s" class="widget %2$s">',
		'after_widget'  => '</section>',
		'before_title'  => '<h2 class="widget-title">',
		'after_title'   => '</h2>',
	) );
}
add_action( 'widgets_init', 'personal_widgets_init' );



if ( ! function_exists( 'personal_body_fonts_url' ) ) :

function personal_body_fonts_url() {

	$body_font = esc_html( get_theme_mod('body_fonts' ));
	
	$body_font_url = '';
	$fonts     = array();
	$subsets   = 'latin,latin-ext';
		
	if( $body_font ) :
		
		$fonts[] = $body_font;
		
	else :
		
		$fonts[] = 'PT+Serif:400,400italic,700italic,700';
		
	endif;

	
	if ( $fonts ) {
		
		$body_font_url = add_query_arg( array(
			'family' => urlencode( implode( '|', $fonts ) ),
			'subset' => urlencode( $subsets ),
		), 'https://fonts.googleapis.com/css' );
			
	}

	return $body_font_url;
	
}

endif;


if ( ! function_exists( 'personal_headings_fonts_url' ) ) :

function personal_headings_fonts_url() {
	
	$headings_font = esc_html( get_theme_mod('headings_fonts' ));
	
	$headings_font_url = '';
	$fonts     = array();
	$subsets   = 'latin,latin-ext';
		
	if( $headings_font ) :
		
		$fonts[] = $headings_font;
		 
	else :
		
		$fonts[] = 'Lusitana:400,700';
		
	endif;

	
	if ( $fonts ) {
		
		$headings_font_url = add_query_arg( array(
			'family' => urlencode( implode( '|', $fonts ) ),
			'subset' => urlencode( $subsets ),
		), 'https://fonts.googleapis.com/css' );
			
	}

	return $headings_font_url;
	
}

endif;






/**
 * Enqueue scripts and styles.
 */
function personal_scripts() {
	wp_enqueue_style( 'personal-style', get_stylesheet_uri() );
	
	wp_enqueue_style( 'personal-headings-google-fonts', personal_headings_fonts_url(), array(), null ); 
	
	wp_enqueue_style( 'personal-body-google-fonts', personal_body_fonts_url(), array(), null ); 
	
	wp_enqueue_style( 'font-awesome', get_template_directory_uri() . '/fonts/font-awesome.css' );
	
	wp_enqueue_style( 'personal-animsition', get_template_directory_uri() . '/css/animsition.css' );

	wp_enqueue_script( 'personal-navigation', get_template_directory_uri() . '/js/navigation.js', array(), '20151215', true );

	wp_enqueue_script( 'personal-skip-link-focus-fix', get_template_directory_uri() . '/js/skip-link-focus-fix.js', array(), '20151215', true );

	wp_enqueue_script( 'personal-animsition', get_template_directory_uri() . '/js/animsition.js', array('jquery'), false, true );

	wp_enqueue_script( 'personal-animsition-script', get_template_directory_uri() . '/js/animsition.script.js', array(), false, true );

	if ( is_singular() && comments_open() && get_option( 'thread_comments' ) ) {
		wp_enqueue_script( 'comment-reply' );
	}
}
add_action( 'wp_enqueue_scripts', 'personal_scripts' );

/**
 * Load html5shiv
 */
function personal_html5shiv() {
    echo '<!--[if lt IE 9]>' . "\n";
    echo '<script src="' . esc_url( get_template_directory_uri() . '/js/html5shiv.js' ) . '"></script>' . "\n";
    echo '<![endif]-->' . "\n";
}
add_action( 'wp_head', 'personal_html5shiv' );

/**
 * Change the excerpt length
 */
function personal_excerpt_length( $length ) {
	
	$excerpt = esc_attr( get_theme_mod('exc_length', '30')); 
	return $excerpt; 

}

add_filter( 'excerpt_length', 'personal_excerpt_length', 999 );

/**
 * Implement the Custom Header feature.
 */
require get_template_directory() . '/inc/custom-header.php';

/**
 * Customizer additions.
 */
require get_template_directory() . '/inc/customizer.php';
require get_template_directory() . '/inc/personal-styles.php';
require get_template_directory() . '/inc/personal-sanitize.php';
require get_template_directory() . '/inc/personal-active-options.php';

/**
 * Google Fonts  
 */
require get_template_directory() . '/inc/gfonts.php';

/**
 * Custom template tags for this theme.
 */
require get_template_directory() . '/inc/template-tags.php';

/**
 * Custom functions that act independently of the theme templates.
 */
require get_template_directory() . '/inc/extras.php';
 
/**
 * Load Jetpack compatibility file.
 */
require get_template_directory() . '/inc/jetpack.php';

/**
 * Include additional custom admin panel features. 
 */
require get_template_directory() . '/panel/functions-admin.php';
require get_template_directory() . '/panel/personal-theme-admin-page.php'; 

/**
 * register your custom widgets
 */ 
include( get_template_directory() . '/inc/widgets.php' );

/**
 * Meta Box
 */
require get_template_directory() . '/inc/personal_meta_box.php';

// allow skype names in social menu
function personal_allow_skype_protocol( $protocols ){
    $protocols[] = 'skype';
    return $protocols;
}
add_filter( 'kses_allowed_protocols' , 'personal_allow_skype_protocol' ); 

//rename some post formats for our good sake
function personal_rename_post_formats( $personal_safe_text ) {
	
    if ( $personal_safe_text == 'Status' )
        return 'Work Experience';
		
	if ( $personal_safe_text == 'Image' )
        return 'Portfolio';

    return $personal_safe_text;
}
add_filter( 'esc_html', 'personal_rename_post_formats' );


//rename in posts list table
function personal_live_rename_formats() { 
    global $current_screen;

    if ( $current_screen->id == 'edit-post' ) { ?>
        <script type="text/javascript">
        jQuery('document').ready(function() { 

            jQuery("span.post-state-format").each(function() { 
                if ( jQuery(this).text() == "Status" ) 
                    jQuery(this).text("Work Experience");
					
				if ( jQuery(this).text() == "Image" ) 
                    jQuery(this).text("Portfolio"); 
					    
            });

        });      
        </script>
<?php }  
} 


/**
 * new icons for post formats
 */
function personal_admin_menu_icons_css() {
    ?>
    <style>
		.post-format-icon.post-format-status::before, .post-state-format.post-format-status::before, a.post-state-format.format-status::before {
  			content: "\f481";
		}
		.home .format-status .entry-title h2:before { 
   			content: "\f481"; 
		}
    </style>
    <?php
}

add_action( 'admin_head', 'personal_admin_menu_icons_css' );


/**
 * Add meta boxes to posts 
 */
 
function personal_featured_metaboxes( $meta_boxes ) {
    $prefix = '_personal_'; // Prefix for all fields
	$meta_boxes['work'] = 
	array(
        'id' => 'work',
        'title' => 'Work Experience Options',
        'pages' => array('post'), // post type
        'context' => 'normal',
        'priority' => 'high',
        'show_names' => true, // Show field names on the left
        'fields' => array(
			array(
    			'name' => esc_html__( 'Date', 'personal' ),
    			'id' => $prefix . 'date',
    			'type' => 'text',
				),
			array(
    			'name' => esc_html__( 'Employer', 'personal' ),
    			'id' => $prefix . 'employer', 
    			'type' => 'text', 
				),
        ),
		
    );

    return $meta_boxes;
}
add_filter( 'cmb_meta_boxes', 'personal_featured_metaboxes' );  

/**
 * Initialize custom meta 
 */
add_action( 'init', 'personal_be_initialize_cmb_meta_boxes', 9999 );
function personal_be_initialize_cmb_meta_boxes() { 
    if ( !class_exists( 'cmb_Meta_Box' ) ) {
        require_once( 'meta/init.php' );
    }
}

/**
 * get out of that loop
 */
function personal_exclude_post_formats_from_blog( $personal_blog_query ) {

	if( $personal_blog_query->is_main_query() && $personal_blog_query->is_home() ) {
		$personal_tax_query = array( array(
			'taxonomy' => 'post_format',
			'field' => 'slug',
			'terms' => array( 'post-format-image', 'post-format-status' ), 
			'operator' => 'NOT IN', 
		) );
		$personal_blog_query->set( 'tax_query', $personal_tax_query ); 
	}

}
add_action( 'pre_get_posts', 'personal_exclude_post_formats_from_blog' ); 