<?php

function get_apratment_selector_settings(){

	$settings = maybe_unserialize(get_option('apartment_selector_settings'));

	return $settings;
}

function ajax_save_settings(){

    $msg = ""; 

    $error = false;

    $vat = $_REQUEST["vat"];

    $sales_tax = $_REQUEST["sales_tax"]; 
    
    $stamp_duty = $_REQUEST["stamp_duty"]; 
    
    $registration_amount = $_REQUEST["registration_amount"]; 

    $infrastructure_charges = $_REQUEST["infrastructure_charges"];

    $membership_fees = $_REQUEST["membership_fees"]; 
 	
 	$settings = array('stamp_duty'=>$stamp_duty,'registration_amount'=>$registration_amount,'vat'=>$vat,'sales_tax'=>$sales_tax,'infrastructure_charges'=>$infrastructure_charges,'membership_fees'=>$membership_fees);
 	
 	update_option('apartment_selector_settings',serialize($settings));
 	
 	$msg = "Settings Updated Successfully!";
   
$response = json_encode( array('msg'=>$msg,'error'=>$error ) );

header( "Content-Type: application/json" );

echo $response;

exit;
}
add_action('wp_ajax_save_settings','ajax_save_settings'); 

