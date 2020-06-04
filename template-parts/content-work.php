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
	$personal_work_page_query = new WP_Query( array(  
	
		'posts_per_page' => -1,
		
		'tax_query' => 	
						
				array(
				
					array(
      				'taxonomy' => 'post_format',
      				'field' => 'slug',
      				'terms' => 'post-format-status', 
 				
		)))); 
		
	?>
		
	<?php if ( $personal_work_page_query->have_posts() ) : ?> 
	<!-- pagination here -->
		
	<section id="mt-work">
                	
		<!-- the loop -->
		<?php while ( $personal_work_page_query->have_posts() ) : $personal_work_page_query->the_post(); ?>
                    
        		
			<?php if ( has_post_format( 'status' )) :  ?> 
            
				<div class="col-1-1">  
                	<div class="work-item">
                    
                    <h5><?php the_title(); ?>
                    	
                        <span class="date">
                        
                        <?php global $post; $work_date = get_post_meta( $post->ID, '_personal_date', true ); ?>  
                                
                        	<?php if ( $work_date ): ?>
                            
                    			<?php global $post; $work_date = get_post_meta( $post->ID, '_personal_date', true ); echo wp_kses_post( $work_date ); ?>
                                            
                       		<?php endif; ?>
                        
                        </span>
                        
               		</h5>
                          
                	<?php global $post; $work_employer = get_post_meta( $post->ID, '_personal_employer', true ); ?>  
										
                    	<?php if ( $work_employer ): ?> 
                                        
               				<h6><?php global $post; $work_employer = get_post_meta( $post->ID, '_personal_employer', true ); echo wp_kses_post( $work_employer ); ?></h6>
                                            
                		<?php endif; ?>
                        
              						
                    <?php the_content(); ?> 
                                       
                	</div><!-- work item --> 
				</div> 
                                   
                            
         	<?php endif; ?> 
                        
		<?php endwhile; ?>
		<!-- end of the loop --> 
        
					
   	<?php else : ?> 
                
                
		<p><?php esc_html__( 'Sorry, no Work Experience has been added yet!', 'personal' ); ?></p>
                    
                    
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
