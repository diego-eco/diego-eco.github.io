<?php
/**
 * Template part for displaying page content
 *
 * @link https://codex.wordpress.org/Template_Hierarchy
 *
 * @package personal
 */

?>

<article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
	<header class="entry-header">
		<?php the_title( '<h1 class="entry-title">', '</h1>' ); ?>
	</header><!-- .entry-header -->

	<div class="entry-content">
		
    <?php
	
	the_content();
	
	// the query
	$personal_portfolio_page_query = new WP_Query( array(  
	
		'posts_per_page' => -1,
		
		'tax_query' => 	
						
				array(
				
					array(
      				'taxonomy' => 'post_format',
      				'field' => 'slug',
      				'terms' => 'post-format-image', 
 				
		)))); 
		
	?>
		
	<?php if ( $personal_portfolio_page_query->have_posts() ) : ?> 
	<!-- pagination here -->
		
	<section id="mt-portfolio">
                	
		<!-- the loop -->
		<?php while ( $personal_portfolio_page_query->have_posts() ) : $personal_portfolio_page_query->the_post(); ?>
                    
        	<?php if ( has_post_format( 'image' )) :  ?> 
            
				<div class="col-1-1">  
                	<div class="portfolio-item">  
                	
                    <?php if ( has_post_thumbnail() ): 
                                                
            			$personal_portfolio_src = wp_get_attachment_image_src( get_post_thumbnail_id(), 'personal-portfolio' ); ?>    
                                                
     					<img src="<?php echo esc_url( $personal_portfolio_src[0] ); ?>" class="aligncenter">     
                                            
                    <?php endif; ?>
                    
                    <?php the_title( '<h2>', '</h2>' ); ?>
                    <?php the_content(); ?> 
				
                	</div>
				</div> 
                            
         	<?php endif; ?> 
                        
		<?php endwhile; ?>
		<!-- end of the loop --> 
        
					
   	<?php else : ?> 
                
                
		<p><?php esc_html__( 'Sorry, no Portfolio has been added yet!', 'personal' ); ?></p>
                    
                    
	<?php endif; 
                                    
                         
   	// Reset the global $the_post as this query will have stomped on it  
	wp_reset_postdata();
	

	wp_link_pages( array(
		'before' => '<div class="page-links">' . esc_html__( 'Pages:', 'personal' ),
		'after'  => '</div>',
	) );
	?>
    
	</div><!-- .entry-content -->

	<?php if ( get_edit_post_link() ) : ?>
		<footer class="entry-footer">
			<?php
				edit_post_link(
					sprintf(
						/* translators: %s: Name of current post */
						esc_html__( 'Edit %s', 'personal' ),
						the_title( '<span class="screen-reader-text">"', '"</span>', false )
					),
					'<span class="edit-link">',
					'</span>'
				);
			?>
		</footer><!-- .entry-footer -->
	<?php endif; ?>
</article><!-- #post-## -->
