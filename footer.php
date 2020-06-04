<?php
/**
 * The template for displaying the footer.
 *
 * Contains the closing of the #content div and all content after.
 *
 * @link https://developer.wordpress.org/themes/basics/template-files/#template-partials
 *
 * @package personal
 */

?>

	</div><!-- #content -->

	<footer id="colophon" class="site-footer" role="contentinfo">
		
        <?php if( get_theme_mod( 'active_byline' ) == '') : ?>
    
		<div class="site-info"> 
        
        	<?php if ( get_theme_mod( 'personal_footerid' ) ) : ?> 
                
        		<?php echo wp_kses_post( get_theme_mod( 'personal_footerid' )); // footer id ?>
                     
			<?php else : ?> 
                            
           		<?php printf( esc_html__( 'THEME: %1$s by %2$s', 'personal' ), 'Personal', '<a href="https://modernthemes.net/" rel="designer">modernthemes.net</a>' ); ?> 
                    
			<?php endif; ?>
            
		</div><!-- .site-info -->
        
         <?php endif; ?>
        
	</footer><!-- #colophon -->
</div><!-- #page -->

<?php wp_footer(); ?>

</body>
</html>
