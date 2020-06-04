<?php
/**
 * The header for our theme.
 *
 * This is the template that displays all of the <head> section and everything up until <div id="content">
 *
 * @link https://developer.wordpress.org/themes/basics/template-files/#template-partials
 *
 * @package personal
 */

?><!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
<meta charset="<?php bloginfo( 'charset' ); ?>">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="profile" href="http://gmpg.org/xfn/11">
<link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>"> 
<?php wp_head(); ?>
</head>

<body <?php body_class(); ?>>
<div id="page" class="site animsition">
	<a class="skip-link screen-reader-text" href="#content"><?php esc_html_e( 'Skip to content', 'personal' ); ?></a>

	<?php if ( get_theme_mod( 'personal_home_bg_image' ) ) : ?>
		<header id="masthead" class="site-header" role="banner" style="background-image: url('<?php echo esc_url( get_theme_mod( 'personal_home_bg_image' )); ?>');">
    <?php else: ?>
		<header id="masthead" class="site-header" role="banner">
    <?php endif; ?>
    
		<div class="site-branding">
        
        	<?php if ( has_custom_logo( $blog_id = 0 ) ) : ?> 
                    
				<?php if ( function_exists( 'the_custom_logo' )) : ?>
                	
                    <h1 class="site-title">
                    	<a href="<?php echo esc_url( home_url( '/' ) ); ?>" class="transition-link" rel="home">
							<?php the_custom_logo( $blog_id = 0 ); ?> 
            			</a>
                    </h1>
                            
            	<?php endif; ?>
                
      		
			<?php else : ?>
                
            <?php
			if ( is_front_page() && is_home() ) : ?>
				<h1 class="site-title">
                	<a href="<?php echo esc_url( home_url( '/' ) ); ?>" class="transition-link" rel="home">
						<?php bloginfo( 'name' ); ?>
                    </a>
                </h1>
			<?php else : ?>
            
				<p class="site-title">
                	<a href="<?php echo esc_url( home_url( '/' ) ); ?>" class="transition-link" rel="home">
						<?php bloginfo( 'name' ); ?>
                    </a>
                </p>
			<?php
			endif; ?>
                			
			<?php endif; ?>
			
			<?php $description = get_bloginfo( 'description', 'display' );
			if ( $description || is_customize_preview() ) : ?>
				<p class="site-description">
					<?php echo $description; /* WPCS: xss ok. */ ?>
                </p>
			<?php
			endif; ?>
            
		</div><!-- .site-branding -->

		<nav id="site-navigation" class="main-navigation" role="navigation">
			<button class="menu-toggle" aria-controls="primary-menu" aria-expanded="false"><?php esc_html_e( 'Menu', 'personal' ); ?></button>
			<?php wp_nav_menu( array( 'theme_location' => 'primary', 'menu_id' => 'primary-menu' ) ); ?>
		</nav><!-- #site-navigation -->
        
        <?php if( get_theme_mod( 'active_social' ) == '') : ?>
        
       		<?php get_template_part( 'menu', 'social' ); ?> 
            
        <?php endif; ?> 
        
	</header><!-- #masthead -->

	<div id="content" class="site-content">
