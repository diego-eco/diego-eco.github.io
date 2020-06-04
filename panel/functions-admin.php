<?php
/**
 * personal admin functions 
 *
 * @package personal 
 */

/**
 *TGM Plugin activation.
 */
require_once get_template_directory() . '/panel/class-tgm-plugin-activation.php'; 
 
add_action( 'tgmpa_register', 'personal_recommend_plugin' );
function personal_recommend_plugin() { 
 
    $plugins = array(
        // Include plugin from the WordPress Plugin Repository
		
		array(
			'name' 		=> esc_html__( 'Contact Form 7', 'personal' ), // http://wordpress.org/plugins/contact-form-7/
			'slug' 		=> 'contact-form-7',
			'required' 	=> false 
		), 
		
		array(
			'name' 		=> esc_html__( 'Simple Custom CSS', 'personal' ), // http://wordpress.org/plugins/simple-custom-css/
			'slug' 		=> 'simple-custom-css', 
			'required' 	=> false
		),
	    
    );
 
    tgmpa( $plugins ); 
 
}
