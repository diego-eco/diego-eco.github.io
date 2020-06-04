<?php
/**
 * personal Theme Customizer
 *
 * @package personal
 */


/**
 * Add CSS in <head> for styles handled by the theme customizer
 *
 * @since 1.5
 */
function personal_add_customizer_css( $personal_customizer_styles ) {
	
?>
	
<!-- personal customizer CSS -->   

	<style> 
		
		<?php if ( get_theme_mod( 'personal_hero_bg_color' ) ) : ?>
		.site-header { background-color: <?php echo esc_attr( get_theme_mod( 'personal_hero_bg_color', '#ececec' )) ?>; }
		<?php endif; ?>
		
		<?php if ( get_theme_mod( 'personal_nav_link_color' ) ) : ?>
		.main-navigation a { color: <?php echo esc_attr( get_theme_mod( 'personal_nav_link_color', '#ffffff' )) ?>; }
		<?php endif; ?>
		
		
		<?php if ( get_theme_mod( 'personal_text_color' ) ) : ?> 
		body, textarea, p { color: <?php echo esc_attr( get_theme_mod( 'personal_text_color', '#404040' )) ?>; }
		<?php endif; ?>
		
		<?php if ( get_theme_mod( 'personal_heading_color' ) ) : ?> 
		h1, h2, h3, h4, h5, h6, .comment-form-comment { color: <?php echo esc_attr( get_theme_mod( 'personal_heading_color', '#404040' )) ?>; }
		<?php endif; ?>
		
		<?php if ( get_theme_mod( 'personal_link_color' ) ) : ?> 
		a { color: <?php echo esc_attr( get_theme_mod( 'personal_link_color', '#000000' )) ?>; } 
		<?php endif; ?>
		
		<?php if ( get_theme_mod( 'personal_entry' ) ) : ?>
		.entry-title { color: <?php echo esc_attr( get_theme_mod( 'personal_entry', '#404040' )) ?>; }
		<?php endif; ?>
		
		<?php if ( get_theme_mod( 'personal_body_size' ) ) : ?>
		body, p { font-size: <?php echo esc_attr( get_theme_mod( 'personal_body_size', '16' )) ?>px; } 
		<?php endif; ?>
		
		
		
		<?php if ( get_theme_mod( 'personal_social_color' ) ) : ?>
		.social-media-icons li .fa, #menu-social li a::before { color: <?php echo esc_attr( get_theme_mod( 'personal_social_color', '#000000' )) ?>;  } 
		<?php endif; ?>
		
		<?php if ( get_theme_mod( 'personal_social_color_hover' ) ) : ?>
		.social-media-icons li .fa:hover, #menu-social li a:hover::before, #menu-social li a:focus::before { color: <?php echo esc_attr( get_theme_mod( 'personal_social_color_hover', '#000000' )) ?>; }
		<?php endif; ?>
		
		<?php if ( get_theme_mod( 'personal_social_text_size' ) ) : ?> 
		.social-media-icons li .fa, #menu-social li a::before { font-size: <?php echo esc_attr( get_theme_mod( 'personal_social_text_size', '16' )) ?>px; }
		<?php endif; ?> 
		
		
		
		<?php if ( get_theme_mod( 'personal_custom_color' ) ) : ?> 
		button, input[type="button"], input[type="reset"], input[type="submit"] { border-color: <?php echo esc_attr( get_theme_mod( 'personal_custom_color', '#222222' )) ?>; }   
		<?php endif; ?>
		
		<?php if ( get_theme_mod( 'personal_button_text_color' ) ) : ?> 
		button, input[type="button"], input[type="reset"], input[type="submit"] { color: <?php echo esc_attr( get_theme_mod( 'personal_button_text_color', '#222222' )) ?>; }   
		<?php endif; ?>
		
		<?php if ( get_theme_mod( 'personal_custom_color_hover' ) ) : ?>
		button:hover, input[type="button"]:hover, input[type="reset"]:hover, input[type="submit"]:hover { background: <?php echo esc_attr( get_theme_mod( 'personal_custom_color_hover', '#222222' )) ?>; } 
		<?php endif; ?>
		
		<?php if ( get_theme_mod( 'personal_custom_color_hover' ) ) : ?>
		button:hover, input[type="button"]:hover, input[type="reset"]:hover, input[type="submit"]:hover { border-color: <?php echo esc_attr( get_theme_mod( 'personal_custom_color_hover', '#222222' )) ?>; }   
		<?php endif; ?>
		
		<?php if ( get_theme_mod( 'personal_button_text_hover_color' ) ) : ?>
		button:hover, input[type="button"]:hover, input[type="reset"]:hover, input[type="submit"]:hover { color: <?php echo esc_attr( get_theme_mod( 'personal_button_text_hover_color', '#ffffff' )) ?>; } 
		<?php endif; ?>
		
		
		  
	</style>
    
   <?php wp_add_inline_style( 'personal-customizer-styles', $personal_customizer_styles ); 	
    
}


add_action( 'wp_head', 'personal_add_customizer_css' );

