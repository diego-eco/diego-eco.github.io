<?php	

/**
 * check to see if MT Services is active 
 */
add_action( 'after_setup_theme', 'personal_network_services_support' );
    function personal_network_services_support() {
		
		// Check if plugin is active
		if ( class_exists( 'MT_Services_Widgets' ) ) { 
    		add_theme_support('mt_services');
		} 
			
    } 
	
/**
 * check to see if MT Projects is active
 */
add_action( 'after_setup_theme', 'personal_projects_support' );
    function personal_projects_support() {
	
		// Check if plugin is active
		if ( class_exists( 'MT_Projects_Widgets' ) ) {
    		add_theme_support('mt_projects');  
		} 
		
	}
	
/**
 * check to see if MT Skills is active
 */
add_action( 'after_setup_theme', 'personal_skills_support' );
    function personal_skills_support() {
	
		// Check if plugin is active
		if ( class_exists( 'MT_Skills_Widgets' ) ) {
    		add_theme_support('mt_skills'); 
		} 
		 	
    }
	
/**
 * check to see if MT Testimonials is active
 */
add_action( 'after_setup_theme', 'personal_testimonials_support' );
    function personal_testimonials_support() {
		
		// Check if plugin is active
		if ( class_exists( 'MT_Testimonials_Widgets' ) ) {
    		add_theme_support('mt_testimonials'); 
		} 
			
    }
	
/**
 * check to see if MT Team Members is active
 */
add_action( 'after_setup_theme', 'personal_members_support' );
    function personal_members_support() {
		
		// Check if plugin is active
		if ( class_exists( 'MT_Members_Widgets' ) ) {
    		add_theme_support('mt_members');
		}    
			
    }
	
/**
 * check to see if MT Details is active
 */
add_action( 'after_setup_theme', 'personal_details_support' );
    function personal_details_support() {
		
		// Check if plugin is active
		if ( class_exists( 'MT_Details_Widgets' ) ) {
    		add_theme_support('mt_details'); 
		} 
 	
    }
	
/**
 * check to see if MT Columns is active
 */
add_action( 'after_setup_theme', 'personal_columns_support' );
    function personal_columns_support() {
		
		// Check if plugin is active
		if ( class_exists( 'MT_Columns_Widgets' ) ) {
    		add_theme_support('mt_columns');    
		} 
 		
    } 
	
	
/**
 * check to see if MT Columns is active
 */
add_action( 'after_setup_theme', 'personal_categories_support' );
    function personal_categories_support() {
		
		// Check if plugin is active
		if ( class_exists( 'personal_category_posts' ) ) {
    		add_theme_support('mt_categories');    
		} 
 		
    }  
