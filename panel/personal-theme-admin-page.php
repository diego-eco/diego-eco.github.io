<?php

     
    add_action('admin_menu', 'personal_setup_menu');
     
    function personal_setup_menu(){
    	add_theme_page( esc_html__('Personal Theme Details', 'personal' ), esc_html__('Personal Theme Details', 'personal' ), 'edit_theme_options', 'personal-setup', 'personal_init' ); 
    }  
      
 	function personal_init(){
		
		wp_enqueue_style( 'personal-font-awesome-admin', get_template_directory_uri() . '/fonts/font-awesome.css' ); 
		wp_enqueue_style( 'personal-style-admin', get_template_directory_uri() . '/panel/css/theme-admin-style.css' ); 
		
	 	echo '<div class="grid grid-pad"><div class="col-1-1"><h1 style="text-align: center;">';
		printf(esc_html__('Thank you for using personal!', 'personal' )); 
        echo "</h1></div></div>";
			
		echo '<div class="grid grid-pad" style="border-bottom: 1px solid #ccc; padding-bottom: 40px; margin-bottom: 30px;" ><div class="col-1-3"><h2>'; 
		printf(esc_html__('Post Formats', 'personal' ));
        echo '</h2>';
		
		echo '<p>';
		printf(esc_html__('Use post formats in order to add content to your professional pages.', 'personal' )); 
		echo '</p>';
		
		echo '<a href="https://modernthemes.net/personal-documentation/personal-work-experience/" target="_blank"><button>'; 
		printf(esc_html__('View Tutorial', 'personal' )); 
		echo "</button></a></div>";
		
		echo '<div class="col-1-3"><h2>'; 
		printf(esc_html__('Documentation', 'personal' ));
        echo '</h2>';  
		
		echo '<p>';
		printf(esc_html__('Check out our documentation for tutorials on theme functions and how to get the most out of personal.', 'personal' ));   
		echo '</p>'; 
		
		echo '<a href="https://modernthemes.net/personal-documentation/" target="_blank"><button>';
		printf(esc_html__('Read Docs', 'personal' )); 
		echo "</button></a></div>";
		
		echo '<div class="col-1-3"><h2>'; 
		printf(esc_html__('ModernThemes', 'personal' )); 
        echo '</h2>';  
		
		echo '<p>';
		printf(esc_html__('Need some more themes? We have a large selection of both free and premium themes to add to your collection.', 'personal' ));
		echo '</p>';
		
		echo '<a href="https://modernthemes.net/" target="_blank"><button>';
		printf(esc_html__('Visit Us', 'personal' ));
		echo '</button></a></div></div>';
		
		
		echo '<div class="grid grid-pad senswp"><div class="col-1-1"><h1 style="padding-bottom: 30px; text-align: center;">';
		printf( esc_html__('Premium Membership. Premium Experience.', 'personal' ));
		echo '</h1></div>';
		
        echo '<div class="col-1-4"><i class="fa fa-cogs"></i><h4>'; 
		printf( esc_html__('Plugin Compatibility', 'personal' ));
		echo '</h4>';
		
        echo '<p>';
		printf( esc_html__('Use our new free plugins with this theme to add functionality for things like projects, clients, team members and more. Compatible with all premium themes!', 'personal' ));
		echo '</p></div>';
		
		echo '<div class="col-1-4"><i class="fa fa-desktop"></i><h4>'; 
        printf( esc_html__('Agency Designed Themes', 'personal' ));
		echo '</h4>';
		
        echo '<p>';
		printf( esc_html__('Look as good as can be with our new premium themes. Each one is agency designed with modern styles and professional layouts.', 'personal' ));
		echo '</p></div>'; 
		
        echo '<div class="col-1-4"><i class="fa fa-users"></i><h4>';
        printf( esc_html__('Membership Options', 'personal' )); 
		echo '</h4>';
		
        echo '<p>';
		printf( esc_html__('We have options to fit every budget. Choose between a single theme, or access to all current and future themes for a year, or forever!', 'personal' ));
		echo '</p></div>'; 
		
		echo '<div class="col-1-4"><i class="fa fa-calendar"></i><h4>'; 
		printf( esc_html__( 'Access to New Themes', 'personal' )); 
		echo '</h4>';
		
        echo '<p>';
		printf( esc_html__( 'New themes added monthly! When you purchase a premium membership you get access to all premium themes, with new themes added monthly.', 'personal' ));   
		echo '</p></div>';
		
		
		echo '<div class="grid grid-pad" style="border-bottom: 1px solid #ccc; padding-bottom: 50px; margin-bottom: 30px;"><div class="col-1-1"><a href="https://modernthemes.net/premium-wordpress-themes/" target="_blank"><button class="pro">'; 
		printf( esc_html__( 'Get Premium Membership', 'personal' ));
		echo '</button></a></div></div>';
		
		
		
		echo '<div class="grid grid-pad"><div class="col-1-1"><h2 style="text-align: center;">'; 
		printf( esc_html__( 'Changelog' , 'personal' ) ); 
        echo "</h2>";
		
		echo '<p style="text-align: center;">'; 
		printf( esc_html__('1.0.1 - Font Selector bug fix', 'personal' )); 
		echo '</p>';
		
		echo '<p style="text-align: center;">'; 
		printf( esc_html__('1.0.0 - New Theme!', 'personal' )); 
		echo '</p></div></div>';
		
    }
?>