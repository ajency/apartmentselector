<?php

/**
 * apartmentselector functions file
 *
 * @package    WordPress
 * @subpackage apartmentselector
 * @since      apartmentselector 0.0.1
 */
//load the common file having commonly containing funtions
require_once (get_template_directory().'/functions/common.php');

//load the init file
require_once (get_template_directory().'/functions/init.php');

//load the functions for formidable plugin hooks
require_once (get_template_directory().'/functions/formidable.php');

//load the functions related to rooms
require_once (get_template_directory().'/functions/rooms.php');

//load the functions related to unit
require_once (get_template_directory().'/functions/unit.php');

//load the functions related to unit type
require_once (get_template_directory().'/functions/unit-type.php');

//load the functions related to building
require_once (get_template_directory().'/functions/building.php');

//load backend styles and scripts//
require_once (get_template_directory().'/functions/backend-scripts-styles.php');

//load all the classes//
require_once (get_template_directory().'/classes/autoload.php');


//formatted echo using pre tags can be used to echo out data for testing purpose

function formatted_echo($data){

    echo "<pre>";

    print_r($data);

    echo "</pre>";

}

function apartmentselector_theme_setup() {

    // load language
    load_theme_textdomain( 'apartmentselector', get_template_directory() . '/languages' );

    // add theme support
    add_theme_support( 'post-formats', array( 'image', 'quote', 'status', 'link' ) );
    add_theme_support( 'post-thumbnails' );
    add_theme_support( 'menus' );
    add_theme_support( 'automatic-feed-links' );
    add_theme_support( 'html5', array( 'search-form', 'comment-form', 'comment-list' ) );

    // define you image sizes here
    add_image_size( 'apartmentselector-full-width', 1038, 576, TRUE );

    // This theme uses its own gallery styles.
    add_filter( 'use_default_gallery_style', '__return_false' );

}

add_action( 'after_setup_theme', 'apartmentselector_theme_setup' );


function apartmentselector_after_init() {

    show_admin_bar( FALSE );
}

add_action( 'init', 'apartmentselector_after_init' );


if ( is_development_environment() ) {

    function apartmentselector_dev_enqueue_scripts() {

        if(check_backend_template())
            return;

        // TODO: handle with better logic to define patterns and folder names
        $module = get_module_name();

        $pattern     = 'scripts';
        $folder_path = 'js/src';

        if ( is_single_page_app( $module ) ) {
            $pattern     = 'spa';
            $folder_path = 'spa/src';
        }

        wp_enqueue_script( "requirejs",
            get_template_directory_uri() . "/js/src/bower_components/requirejs/require.js",
            array(),
            get_current_version(),
            TRUE );

        wp_enqueue_script( "require-config",
            get_template_directory_uri() . "/{$folder_path}/require.config.js",
            array( "requirejs" ),
            get_current_version(),
            TRUE);



        wp_enqueue_script( "$module-script",
            get_template_directory_uri() . "/{$folder_path}/{$module}.{$pattern}.js",
            array( "require-config" ) );

        // localized variables
        wp_localize_script( "requirejs", "SITEURL", site_url() );
        wp_localize_script( "requirejs", "AJAXURL", admin_url( "admin-ajax.php" ) );
        wp_localize_script( "requirejs", "UPLOADURL", admin_url( "async-upload.php" ) );
        wp_localize_script( "requirejs", "_WPNONCE", wp_create_nonce( 'media-form' ) );
    }

    add_action( 'wp_enqueue_scripts', 'apartmentselector_dev_enqueue_scripts' );

    function apartmentselector_dev_enqueue_styles() {

        if(check_backend_template())
            return;

        $module = get_module_name();

        wp_enqueue_style( "$module-style", get_template_directory_uri() . "/css/{$module}.styles.css" );

    }

    add_action( 'wp_enqueue_scripts', 'apartmentselector_dev_enqueue_styles' );
}

if (! is_development_environment() ) {

    function apartmentselector_production_enqueue_script() {
 

        if(check_backend_template())
            return;

        $module = get_module_name(); 

        if ( is_single_page_app( $module ) )

            $path = get_template_directory_uri() . "/production/{$module}.spa.min.js";
        else
            $path = get_template_directory_uri() . "/production/{$module}.scripts.min.js";

        wp_enqueue_script( "$module-script",
            $path,
            array(),
            get_current_version(),
            TRUE );
        wp_localize_script(  "$module-script", "SITEURL", site_url() );
        wp_localize_script(  "$module-script", "AJAXURL", admin_url( "admin-ajax.php" ) );
        wp_localize_script( "$module-script", "UPLOADURL", admin_url( "async-upload.php" ) );
        wp_localize_script(  "$module-script", "_WPNONCE", wp_create_nonce( 'media-form' ) );

    }

    add_action( 'wp_enqueue_scripts', 'apartmentselector_production_enqueue_script' );

    function apartmentselector_production_enqueue_styles() {


        if(check_backend_template())
            return;

        $module = get_module_name();

        wp_enqueue_style( "$module-style",
            get_template_directory_uri() . "/production/{$module}.styles.min.css",
            array(),
            get_current_version(),
            "all" );

    }

    add_action( 'wp_enqueue_scripts', 'apartmentselector_production_enqueue_styles' );
}


function is_development_environment() {

    if ( defined( 'ENV' ) && ENV === "production" )
        return FALSE;

    return TRUE;
}


function get_current_version() {

    global $wp_version;

    if ( defined( 'VERSION' ) )
        return VERSION;

    return $wp_version;

}

function is_single_page_app( $module_name ) {

    // add slugs of SPA pages here
    $spa_pages = array( 'apartment-selector' );

    return in_array( $module_name, $spa_pages );

}


function get_module_name() {

    $module = "";

    // TODO: Handle with project specific logic here to define module names
    if ( is_page() )
        $module = sanitize_title( get_the_title() );

    return $module;

}