<?php


add_action( 'wp_ajax_get-mappalic-view', 'ajax_call_get_mappalic_view' );



function ajax_call_get_mappalic_view(){







    $content =  do_shortcode('[mapplic id="1"]');

    echo $content;



}