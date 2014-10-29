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

//load the functions related to apartment selector settings
require_once (get_template_directory().'/functions/settings.php');

//load the functions related to apartment selector payment plans
require_once (get_template_directory().'/functions/payment-plans.php');
//load the functions related to apartment selector users
require_once (get_template_directory().'/functions/users.php');

//load backend styles and scripts//
require_once (get_template_directory().'/functions/backend-scripts-styles.php');

//load all the classes//
require_once (get_template_directory().'/classes/autoload.php');

//load ajax call
require_once (get_template_directory().'/ajax-module.php');
//pdf generator library
require_once (get_template_directory().'/functions/tcpdf_include.php');
$bust = '?'.BUST; 

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

function get_data(){

    $building = get_buildings();
            $unit = get_units();
            $unit_type = get_unit_types();
            $buildingarray = array();
            $unitarray = array();
            $unittype = array();
            $temparray = array();
            $unit_typetemparray = array();
            $temparray1 = array();
            foreach ($building as $value) {
                if($value['phase'] == 26){
                    array_push($buildingarray, $value);
                    array_push($temparray, $value['id']);

                }

                # code...
            }
            
            foreach ($unit as $value) {
                if(in_array($value['building'], $temparray)){
                    array_push($unitarray, $value);
                    

                }

                # code...
            }
    return array($buildingarray,$unitarray);
}

if ( is_development_environment() ) {
 
    function apartmentselector_dev_enqueue_scripts() {

    //check not to enqueue frontend scritps for backend
        if(!check_backend_template()){
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
           

            

            $data = get_data();
            $buildings = $data[0];
            $units = $data[1];
            
           
            // localized variables
            wp_localize_script( "requirejs", "SITEURL", site_url() );
            wp_localize_script( "requirejs", "AJAXURL", admin_url( "admin-ajax.php" ) );
            wp_localize_script(  "requirejs", "ajaxurl", admin_url( "admin-ajax.php" ) );
            wp_localize_script( "requirejs", "UPLOADURL", admin_url( "async-upload.php" ) );
            wp_localize_script( "requirejs", "_WPNONCE", wp_create_nonce( 'media-form' ) );
            wp_localize_script( "requirejs", "BUILDINGS", $buildings );
            wp_localize_script( "requirejs", "UNITS", $units );
            wp_localize_script( "requirejs", "STATUS", get_unit_status() );
            wp_localize_script( "requirejs", "UNITTYPES", get_unit_types() );
            wp_localize_script( "requirejs", "TERRACEOPTIONS", get_terrace_options() );
            wp_localize_script( "requirejs", "UNITVARIANTS", get_unit_variants() );
            wp_localize_script( "requirejs", "VIEWS", get_views() );
            wp_localize_script( "requirejs", "FACINGS", get_facings() );
            wp_localize_script( "requirejs", "PAYMENTPLANS", get_payment_plans() );
            wp_localize_script( "requirejs", "MILESTONES", get_milestones() );
            wp_localize_script( "requirejs", "SETTINGS", get_apratment_selector_settings() );
            wp_localize_script( "requirejs", "USER", get_ap_current_user() );
            wp_localize_script( "requirejs", "EMAILFORM", FrmEntriesController::show_form(27, $key = '', $title=false, $description=true  ));
 

        }
    }
 
        add_action( 'wp_enqueue_scripts', 'apartmentselector_dev_enqueue_scripts' );
   

    function apartmentselector_dev_enqueue_styles() {

        $module = get_module_name();

        wp_enqueue_style( "$module-style", get_template_directory_uri() . "/css/{$module}.styles.css".$bust, array(), "", "screen" );

        wp_enqueue_style( "$module-print-style", get_template_directory_uri() . "/css/{$module}.print.css".$bust, array(), "", "print" );

    } 
        add_action( 'wp_enqueue_scripts', 'apartmentselector_dev_enqueue_styles' );
   
}

if (! is_development_environment() ) {

    function apartmentselector_production_enqueue_script() {

    //check not to enqueue frontend scritps for backend
    if(!check_backend_template()){
           $module = get_module_name();

            if ( is_single_page_app( $module ) )

                $path = get_template_directory_uri() . "/production/{$module}.spa.min.js".$bust;
            else
                $path = get_template_directory_uri() . "/production/{$module}.scripts.min.js".$bust;

            wp_enqueue_script( "$module-script",
                $path,
                array(),
                get_current_version(),
                TRUE );

            $data = get_data();
            $buildings = $data[0];
            $units = $data[1];
            
            wp_localize_script(  "$module-script", "SITEURL", site_url() );
            wp_localize_script(  "$module-script", "AJAXURL", admin_url( "admin-ajax.php" ) );
            wp_localize_script(  "$module-script", "ajaxurl", admin_url( "admin-ajax.php" ) );
            wp_localize_script(  "$module-script", "UPLOADURL", admin_url( "async-upload.php" ) );
            wp_localize_script(  "$module-script", "_WPNONCE", wp_create_nonce( 'media-form' ) );
            wp_localize_script( "$module-script", "BUILDINGS", $buildings );
            wp_localize_script( "$module-script", "UNITS", $units );
            wp_localize_script( "$module-script", "STATUS", get_unit_status() );
            wp_localize_script( "$module-script", "UNITTYPES", get_unit_types() );
            wp_localize_script( "$module-script", "TERRACEOPTIONS", get_terrace_options() );
            wp_localize_script( "$module-script", "UNITVARIANTS", get_unit_variants() );
            wp_localize_script( "$module-script", "VIEWS", get_views() );
            wp_localize_script( "$module-script", "FACINGS", get_facings() );
            wp_localize_script( "$module-script", "PAYMENTPLANS", get_payment_plans() );
            wp_localize_script( "$module-script", "MILESTONES", get_milestones() );
            wp_localize_script( "$module-script", "SETTINGS", get_apratment_selector_settings() );
            wp_localize_script( "$module-script", "USER", get_ap_current_user() );
            wp_localize_script( "$module-script", "EMAILFORM", FrmEntriesController::show_form(27, $key = '', $title=false, $description=true  ));
        }
    }

       add_action( 'wp_enqueue_scripts', 'apartmentselector_production_enqueue_script' );
  
    
    function apartmentselector_production_enqueue_styles() {

    //check not to enqueue frontend scritps for backend
    if(!check_backend_template()){
        $module = get_module_name();

        wp_enqueue_style( "$module-style",
            get_template_directory_uri() . "/production/{$module}.styles.min.css".$bust,
            array(),
            get_current_version(),
            "screen" );

        wp_enqueue_style( "$module-print-style",
            get_template_directory_uri() . "/css/{$module}.print.css".$bust,
            array(),
            "",
            "print" );

        
        }

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
    $spa_pages = array( 'apartment-selector','apartmentsselector','wishlist' );

    return in_array( $module_name, $spa_pages );

}


function get_module_name() {

    $module = "";

    // TODO: Handle with project specific logic here to define module names
    if ( is_page() )
        $module = sanitize_title( get_the_title() );
   

    return $module;

}


function generate_pdf_data($unit_id,$tower_id,$wishlist){

    // create new PDF document
        $pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

        // set document information
        $pdf->SetCreator(PDF_CREATOR);
        $pdf->SetAuthor('Nicola Asuni');
        $pdf->SetTitle('TCPDF Example 001');
        $pdf->SetSubject('TCPDF Tutorial');
        $pdf->SetKeywords('TCPDF, PDF, example, test, guide');
        $pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);
        

        $pdf->AddPage();

       
    
        $units_data = get_post($unit_id);
        

        $unit_variant =   get_post_meta($units_data->ID, 'unit_variant', true);
        
        $building =   get_post_meta($units_data->ID, 'building', true);

        $apartment_views =   get_post_meta($units_data->ID, 'apartment_views', true);

        $facings_data =   get_post_meta($units_data->ID, 'facing', true);

        $floor = get_post_meta($units_data->ID, 'floor', true);

        $unit_type = get_unit_type_by_unit_variant($unit_variant);

        $unitytpes = get_unit_type_by_id($unit_type);
        $views = "";
        $facings = "";
        if(count($apartment_views)>0 && $apartment_views != "" )
            {
            foreach($apartment_views as $value){

                $viewsdata = get_views($value);
                
                $views .= $viewsdata[0]['name'].'<br/>';

            }
        }
        if(count($facings_data)>0 && $facings_data != "")
            {
            foreach($facings_data as $value){

                $facingsdata = get_facings($value);
               
                $facings .= $facingsdata[0]['name'].'<br/>';

            }
        }


    

        $unitvariant = get_unit_variants($unit_variant);

        $rangname = "";
        $buildingmodel = get_building_by_id($building);
        $image_attributes = wp_get_attachment_image_src( $buildingmodel['zoomedinimage']['id'] );
        $zoomed_in_image = $image_attributes[0];
        
        $attachment = get_attached_file($buildingmodel['zoomedinimage']['id']);
        $floorriserange = $buildingmodel['floorriserange'];
        foreach($floorriserange as $value){
            
            $range = array();
            $start = intval($value['start']);
            $end = intval($value['end']);
            $i = $start;
            while($i<=$end){
                array_push($range,$i);
                $i++;


            }
            
            $rangname = "";
            
            
            if(in_array($floor, $range)){
               
                if($value['name'] == 'medium')
                    $rangname = 'mid';
                else
                    $rangname = $value['name'];


                
                $rangname = $rangname."rise";

            }


        }
       
        $result = ucfirst($rangname);
        $html = "";
        $image = '<div><img src="'.$attachment.'" /></div>';
    // $pdf->writeHTML($image, true, 0, true, 0);
    // $pdf->Image($zoomed_in_imag , 0, 0, 210, 297, '', '', '', true, 150);

    // $html .= "<span>Flat No. </span><span>".$units_data->post_name."</span><br/><span>".$buildingmodel['name']."
    //         </span><br/><span>Floor Range: </span>".$result."<span>".$unitytpes->name;

        $html .= '
                    
                        <div class="col-sm-6 head">
                            <h1>Flat No: <strong><span id="flatno">'.$units_data->post_name.'</span></strong></h1>
                        </div>
                        <div class="col-sm-6 head">
                            <h1 id="towerno">'.$buildingmodel['name'].'</h1>
                        </div>
                    
                    
                        <div class="col-sm-6 head">
                            <h2>Flat Type: <strong><span id="unittypename">'.$unitytpes->name.'</span></strong>(<span id="area">'.$unitvariant[0]['sellablearea'].'</span> sq. ft.)</h2>
                        </div>
                        <!--<div class="col-sm-6 head">
                            <h2>Floor Range: <strong><span id="floorrise"></span></strong></h2>
                        </div>-->';
    
    

                
                foreach($unitvariant[0]['roomsizes'] as $value){
                    
                    $html .= '<div class="rooms">
                                    <span>'.$value['room_type'].'</span>: '.$value['room_size'].' sq ft
                                </div>';


                }

    $html .= '<span>Views :</span>'.$views;
    $html .= '<span>Facings: </span>'.$facings;
    // print_r($unitvariant);
    
    
    $upload_dir = wp_upload_dir();
    $destination_dir = $upload_dir['basedir'].'/2014/pdfuplaods';

    if (!file_exists($destination_dir)){

    mkdir($destination_dir);

    }

    $filename = "unitdetails".date('dmyhis');

    $pdf->WriteHTML( $html );
    $image = '<div><img src="'.$unitvariant[0]['url2dlayout_image'].'" /></div>';
    $pdf->writeHTML($image, true, 0, true, 0);
    $image = '<div><img src="'.$unitvariant[0]['url3dlayout_image'].'" /></div>';
    $pdf->writeHTML($image, true, 0, true, 0);

    
    $wishlistarray = explode(',', $wishlist);
    
    foreach($wishlistarray as $value){

        $wish = "";
        
        $units_data = get_post($value);

        $unit_variant =   get_post_meta($units_data->ID, 'unit_variant', true);
        
        $building =   get_post_meta($units_data->ID, 'building', true);

        $floor = get_post_meta($units_data->ID, 'floor', true);

        $buildingmodel = get_building_by_id($building);

        
        $unit_type = get_unit_type_by_unit_variant($unit_variant);

        $unitytpes = get_unit_type_by_id($unit_type);

        

        $unitvariant = get_unit_variants($unit_variant);

        $floorriserange = $buildingmodel['floorriserange'];
        foreach($floorriserange as $value){
            
            $range = array();
            $start = intval($value['start']);
            $end = intval($value['end']);
            $i = $start;
            while($i<=$end){
                array_push($range, $i);
                $i++;


            }
            
            $rangname = "";

            
            if(in_array($floor, $range)){
               
                if($value['name'] == 'medium')
                    $rangname = 'mid';
                else
                    $rangname = $value['name'];


                
                $rangname = $rangname."rise";

            }


        }
        $result = ucfirst($rangname);
        $apartment_views =   get_post_meta($units_data->ID, 'apartment_views', true);

        $facings_data =   get_post_meta($units_data->ID, 'facing', true);

        $views = "";
        $facings = "";
        if(count($apartment_views)>0 && $apartment_views != "" )
            {
            foreach($apartment_views as $value){

                $viewsdata = get_views($value);
                
                $views .= $viewsdata[0]['name'].'<br/>';

            }
        }
        if(count($facings_data)>0 && $facings_data != "")
            {
            foreach($facings_data as $value){

                $facingsdata = get_facings($value);
               
                $facings .= $facingsdata[0]['name'].'<br/>';

            }
        }
    $roomsizes = $unitvariant[0]['roomsizes'];
    $roomTypeArr = array(68,71,72);
    $roomsizearr = array();
    $roomTest= "";
    $mainArr =array();
    foreach ($roomTypeArr as $key => $value) {

        $roomTest .= $value['room_type'];
        foreach ($roomsizes as $key => $value1) {
            if($value1['room_type_id'] == $value){
                $roomTest .= $value1['room_type'].'-'.$value1['room_size'].'<br/>';
            }
            # code...
        }
        $roomTest .= '<br/>';
        # code...
    }

   
        $image = "";
        $wish .= '<h1>Flat No: <strong><span id="flatno">'.$units_data->post_name.'</span></strong></h1>
        <h1 id="towerno">'.$buildingmodel['name'].'</h1>
        <h2>Flat Type: <strong><span id="unittypename">'.$unitytpes->name.'</span></strong>(<span id="area">'.$unitvariant[0]['sellablearea'].'</span> sq. ft.)</h2>
        <!--<h2>Floor Range: <strong><span id="floorrise"></span></strong></h2>-->
        <h2>Floor: <strong><span id="floorrise">'.$floor.'</span></strong></h2>
        <h2>Views: <strong><span id="floorrise">'.$views.'</span></strong></h2>
        <h2>Facings: <strong><span id="floorrise">'.$facings.'</span></strong></h2>
        <h2>Total Area: <strong><span id="floorrise">'.$unitvariant[0]['sellablearea'].'</span></strong></h2>
        <h2>Carpet Area: <strong><span id="floorrise">'.$unitvariant[0]['carpetarea'].'</span></strong></h2>
        <h2>Terrace Area: <strong><span id="floorrise">'.$unitvariant[0]['terracearea'].'</span></strong></h2>
        <h2>Room Sizes: <strong><span id="floorrise">'.$roomTest.'</span></strong></h2>';

        $pdf->WriteHTML( $wish );
        $image = '<img src="'.$unitvariant[0]['url2dlayout_image'].'"  />';
        $pdf->writeHTML($image, true, 0, true, 0);
        $image = '<img src="'.$unitvariant[0]['url3dlayout_image'].'" />';
        $pdf->writeHTML($image, true, 0, true, 0);
        $image = '<img src="'.$buildingmodel['positioninproject']['image_url'].'"  />';
        $pdf->writeHTML($image, true, 0, true, 0);
        
    



    }
   



    
    $output_link=$destination_dir.'/'.$filename.'.pdf';
    
   
   $attachment = $pdf->Output($output_link, 'F');

   return $output_link;
}

