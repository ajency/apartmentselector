<?php
/*
funtion to insert data in the wp_defaults table
*/

function set_defaults_data($args){

	global $wpdb;

	$defaults_set = array();

	$defaults = array(

				"id"	=>"NULL",

				"master_type"	=>"",

				"value"			=>"",

				"data"			=>""
			);

	foreach($args as $arg){

		$arg = wp_parse_args( $arg, $defaults );

		extract( $arg, EXTR_OVERWRITE );

		if($id == 0){
		 	$query = "SELECT id FROM ".$wpdb->prefix .CUSTOMTBLPREFIX. "defaults  WHERE master_type = '$master_type' and value = '$value'";
 
		 	$defaults_id = $wpdb->get_var($query);
 
		  	if(empty($defaults_id)){

		  		$query = "INSERT INTO ".$wpdb->prefix .CUSTOMTBLPREFIX. "defaults (master_type, value, data)
						 VALUES
						( '$master_type', '$value', '$data')  ";

				$wpdb->query($query);

				$defaults_id = $wpdb->insert_id;

		 	}

			$defaults_set[] = $defaults_id;

		}else{

			$query = "	UPDATE ".$wpdb->prefix .CUSTOMTBLPREFIX. "defaults SET master_type = '$master_type', value = '$value', data = '$data' WHERE id = ".$id; 

			$wpdb->query($query);
		}

	}

	return ($defaults_set);

}


function get_default_data($master_type,$id=0){

	global $wpdb;

	$default_data = array();

	$where_clause = "";

	if($id !=0){

		$where_clause = " id = ".$id;

	}
	$query = "SELECT id as id,value as name,master_type as master_type,data as data FROM ".$wpdb->prefix .CUSTOMTBLPREFIX. "defaults WHERE master_type = '$master_type'".$where_cluse;

	$default_data = $wpdb->get_results($query,ARRAY_A);
 
 	return $default_data;


}
function get_list($list)
{
    $get_list = "get_".$list;

    return $get_list();
}

function get_masters($masters){

    $return_masters = array();

    foreach($masters as $master){

        $get_master = "get_".$master;

        $return_masters[$master] = $get_master();

    }

    return $return_masters;

}

function ajax_get_list_view(){


    $list = get_list($_REQUEST["list"]);

    $masters = get_masters($_REQUEST["masters"]);

    $response = json_encode( array('list'=>$list ,'masters'=>$masters) );

    header( "Content-Type: application/json" );

    echo $response;

    exit;
}
add_action('wp_ajax_get_list_view','ajax_get_list_view');