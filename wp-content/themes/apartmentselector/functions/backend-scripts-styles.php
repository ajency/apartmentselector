<?php
//check if the current page called is a backend page and and load required css and js files


function apartmentselector_backend_enqueue_scripts(){

    global $post;

    $array_backend_pages = array('apartments','add-edit-apartment');

    if(in_array($post->post_name,$array_backend_pages)){

        wp_enqueue_script( "jquery",
            get_template_directory_uri() . "/js/backend/jquery-1.8.3.min.js", array(), false, true
        );

        wp_enqueue_script( "jquery-ui",
            get_template_directory_uri() . "/js/backend/jquery-ui-1.10.1.custom.min.js",
            array( "jquery" ) , false, true);

        wp_enqueue_script( "jquery-bootstrap",
            get_template_directory_uri() . "/js/backend/bootstrap.min.js",
            array( "jquery" ), false, true );

        wp_enqueue_script( "breakpoints",
            get_template_directory_uri() . "/js/backend/breakpoints.js",
            array( "jquery" ), false, true );

        wp_enqueue_script( "jquery-unveil",
            get_template_directory_uri() . "/js/backend/jquery.unveil.min.js",
            array( "jquery" ), false, true );


        wp_enqueue_script( "jqueryblockui",
            get_template_directory_uri() . "/js/backend/jqueryblockui.js",
            array( "jquery" ) , false, true);

        wp_enqueue_script( "jquery-sidr",
            get_template_directory_uri() . "/js/backend/jquery.sidr.min.js",
            array( "jquery" ), false, true );

        wp_enqueue_script( "jquery-animateNumbers",
            get_template_directory_uri() . "/js/backend/jquery.animateNumbers.js",
            array( "jquery" ), false, true );

        wp_enqueue_script( "pace",
            get_template_directory_uri() . "/js/backend/pace.min.js",
            array( "jquery" ), false, true );

        wp_enqueue_script( "bootstrap-datepicker",
            get_template_directory_uri() . "/js/backend/bootstrap-datepicker.js",
            array( "jquery" ) , false, true);

        wp_enqueue_script( "select2",
            get_template_directory_uri() . "/js/backend/select2.min.js",
            array( "jquery" ), false, true );


        wp_enqueue_script( "jquery-slimscroll",
            get_template_directory_uri() . "/js/backend/jquery.slimscroll.min.js",
            array( "jquery" ) , false, true);


        wp_enqueue_script( "bootstrap-wizard",
            get_template_directory_uri() . "/js/backend/jquery.bootstrap.wizard.min.js",
            array( "jquery" ), false, true );


        wp_enqueue_script( "jquery-validate",
            get_template_directory_uri() . "/js/backend/jquery.validate.min.js",
            array( "jquery" ), false, true );

        wp_enqueue_script( "form_validations",
            get_template_directory_uri() . "/js/backend/form_validations.js",
            array( "jquery" ), false, true );

        wp_enqueue_script( "underscore",
            get_template_directory_uri() . "/js/backend/underscore.js",
            array( "jquery" ), false, true );

        ///load unit.js if any of the specifed is loaded
        if(in_array($post->post_name,array('apartments','add-edit-apartment'))){
            wp_enqueue_script( 'unit',
                get_template_directory_uri() . "/js/backend/unit.js",
                array( "jquery" ), false, true );
        }

        ///load unit.js if any of the specifed is loaded
        if(in_array($post->post_name,array('apartments'))){
            wp_enqueue_script( 'tablesorter',
                get_template_directory_uri() . "/js/backend/jquery.tablesorter.min.js",
                array( "jquery" ), false, true );

            wp_enqueue_script( 'tablesorter-widgets',
                get_template_directory_uri() . "/js/backend/jquery.tablesorter.widgets.min.js",
                array( "jquery" ), false, true );

            wp_enqueue_script( 'tablesorter-widgets-filter',
                get_template_directory_uri() . "/js/backend/jquery.tablesorter.widgets-filter-formatter.min.js",
                array( "jquery" ), false, true );

            wp_enqueue_script( 'jui-theme-switch',
                get_template_directory_uri() . "/js/backend/jquery.jui_theme_switch.min.js",
                array( "jquery" ), false, true );


        }


        wp_localize_script( "jquery", "SITEURL", site_url() );

        wp_localize_script( "jquery", "AJAXURL", admin_url( "admin-ajax.php" ) );
    }



}

add_action( 'wp_enqueue_scripts', 'apartmentselector_backend_enqueue_scripts' );



function apartmentselector_backend_enqueue_styles() {

    global $post;

    $array_backend_pages = array('apartments','add-edit-apartment');

    if(in_array($post->post_name,$array_backend_pages)){
        wp_enqueue_style( "pace-theme-flash", get_template_directory_uri() . "/css/backend/css/pace-theme-flash.css" );
        wp_enqueue_style( "bootstrap-tagsinput", get_template_directory_uri() . "/css/backend/css/bootstrap-tagsinput.css" );
        wp_enqueue_style( "jquery.sidr.light", get_template_directory_uri() . "/css/backend/css/jquery.sidr.light.css" );
        wp_enqueue_style( "bootstrap.min", get_template_directory_uri() . "/css/backend/css/bootstrap.min.css" );
        wp_enqueue_style( "bootstrap-theme.min", get_template_directory_uri() . "/css/backend/css/bootstrap-theme.min.css" );
        wp_enqueue_style( "font-awesome", get_template_directory_uri() . "/css/backend/css/font-awesome.css" );
        wp_enqueue_style( "animate.min", get_template_directory_uri() . "/css/backend/css/animate.min.css" );
        wp_enqueue_style( "style", get_template_directory_uri() . "/css/backend/css/style.css" );
        wp_enqueue_style( "responsive", get_template_directory_uri() . "/css/backend/css/responsive.css" );
        wp_enqueue_style( "custom-icon-set", get_template_directory_uri() . "/css/backend/css/custom-icon-set.css" );
        wp_enqueue_style( "custom", get_template_directory_uri() . "/css/backend/css/custom.css" );

        ///load unit.js if any of the specifed is loaded
        if(in_array($post->post_name,array('apartments'))){
            wp_enqueue_style( "filter-formatter", get_template_directory_uri() . "/css/backend/css/filter.formatter.css" );
            wp_enqueue_style( "theme-jui", get_template_directory_uri() . "/css/backend/css/theme.jui.css" );
        }
    }

}

add_action( 'wp_enqueue_scripts', 'apartmentselector_backend_enqueue_styles'  );