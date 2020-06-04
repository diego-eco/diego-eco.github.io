<?php



class personal_Video_Widget extends WP_Widget {



// constructor

    function personal_video_widget() {

		$widget_ops = array('classname' => 'personal_video_widget_widget', 'description' => esc_html__( 'Video for your sidebar.', 'personal') ); 

        parent::__construct(false, $name = esc_html__('MT - Video Widget', 'personal'), $widget_ops); 

		$this->alt_option_name = 'personal_video_widget';


		add_action( 'save_post', array($this, 'flush_widget_cache') ); 

		add_action( 'deleted_post', array($this, 'flush_widget_cache') );

		add_action( 'switch_theme', array($this, 'flush_widget_cache') );		

    } 

	

	// widget form creation

	function form($instance) {



	// Check values

		$title     = isset( $instance['title'] ) ? esc_attr( $instance['title'] ) : '';

		$url    = isset( $instance['url'] ) ? esc_url( $instance['url'] ) : '';

	?>



	<p>

	<label for="<?php echo sanitize_text_field( $this->get_field_id('title')); ?>"><?php esc_html_e('Title', 'personal'); ?></label>

	<input class="widefat" id="<?php echo sanitize_text_field( $this->get_field_id('title')); ?>" name="<?php echo sanitize_text_field( $this->get_field_name('title')); ?>" type="text" value="<?php echo esc_attr( $title ); ?>" /> 

	</p>



	<p><label for="<?php echo sanitize_text_field( $this->get_field_id( 'url' )); ?>"><?php esc_html_e( 'Paste the URL of the video (only from a network that supports oEmbed, like Youtube, Vimeo etc.):', 'personal' ); ?></label>

	<input class="widefat" id="<?php echo sanitize_text_field( $this->get_field_id( 'url' )); ?>" name="<?php echo sanitize_text_field( $this->get_field_name( 'url' )); ?>" type="text" value="<?php echo esc_url( $url ); ?>" size="3" /></p>

	 

	<?php

	}



	// update widget

	function update($new_instance, $old_instance) {

		$instance = $old_instance;

		$instance['title'] = esc_attr($new_instance['title']);

		$instance['url'] = esc_url_raw($new_instance['url']);

		$this->flush_widget_cache();



		$alloptions = wp_cache_get( 'alloptions', 'options' );

		if ( isset($alloptions['personal_video_widget']) )

			delete_option('personal_video_widget');		  

		  

		return $instance;

	}

	

	function flush_widget_cache() {

		wp_cache_delete('personal_video_widget', 'widget');

	}

	

	// display widget

	function widget($args, $instance) {

		$cache = array();

		if ( ! $this->is_preview() ) {

			$cache = wp_cache_get( 'personal_video_widget', 'widget' );

		}



		if ( ! is_array( $cache ) ) {

			$cache = array();

		}



		if ( ! isset( $args['widget_id'] ) ) {

			$args['widget_id'] = $this->id;

		}



		if ( isset( $cache[ $args['widget_id'] ] ) ) {

			echo wp_kses_post( $cache[ $args['widget_id'] ] );

			return;

		}



		ob_start();

		extract($args); 



		$title = ( ! empty( $instance['title'] ) ) ? esc_attr( $instance['title'] ) : esc_html__( 'Video', 'personal' ); 



		$title = apply_filters( 'widget_title', esc_attr( $title ), $instance, $this->id_base ); 



		$url   = isset( $instance['url'] ) ? esc_url( $instance['url'] ) : '';



		echo wp_kses_post( $before_widget );  

		

		if ( $title ) echo wp_kses_post( $before_title ) . esc_attr( $title ) . $after_title;

		

		if( ($url) ) {

			echo wp_oembed_get( $url );

		}

		echo wp_kses_post( $after_widget ); 





		if ( ! $this->is_preview() ) {

			$cache[ $args['widget_id'] ] = ob_get_flush();

			wp_cache_set( 'personal_video_widget', $cache, 'widget' );

		} else {

			ob_end_flush();

		}

	}

	

}	