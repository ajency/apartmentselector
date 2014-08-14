<?php


function get_sales_users(){

	$sales_users = array();
	$users = get_users();

	foreach($users as $user){

			$user_chk = new WP_User( $user->ID );
			if ($user_chk->has_cap( 'sales') && !$user_chk->has_cap( 'manage_options')){

				$sales_users[] = array("id"=>$user->ID,"name"=>$user->display_name);
			}
	}

	return  $sales_users ;
}