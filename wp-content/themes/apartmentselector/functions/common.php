<?php
/*
funtion to insert data in the wp_defaults table
*/

//get the current template php file name
function get_template_filename()
{

    global $post;
    $template_name = explode(".php",get_page_template_slug( $post->ID ));
    return $template_name[0];

}

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


    //get the collection of the main list view required
    $list = get_list($_REQUEST["list"]);

    //get all the masters required
    $masters = get_masters($_REQUEST["masters"]);

    $response = json_encode( array('list'=>$list ,'masters'=>$masters) );

    header( "Content-Type: application/json" );

    echo $response;

    exit;
}
add_action('wp_ajax_get_list_view','ajax_get_list_view');


function check_backend_template(){
    //check to load js only if not backend templates
    $array_backend_pages = array('apartments','buildings','add-edit-apartment','add-edit-building');

    if(in_array(get_template_filename(),$array_backend_pages)){

        return true;
    }
}


//upload files

function ajax_upload_file(){

		 $targetFolder = '/uploads'; // Relative to the root

            global $user_ID;

            $files = $_FILES['files'];


            if ($files['name']) {
                $file = array(
                    'name' => $files['name'],
                    'type' => $files['type'],
                    'tmp_name' => $files['tmp_name'],
                    'error' => $files['error'],
                    'size' => $files['size']
                );

                $_FILES = array("upload_attachment" => $file);



                $attach_data = array();

 
                foreach ($_FILES as $file => $array) { 
                    $attach_id = upload_attachment($file, 0, true);
                    $attachment_id = $attach_id;
                    $attachment_url = wp_get_attachment_thumb_url($attach_id);
                }
            }

					
					
	  
  $response = json_encode(array('attachment_id' => $attachment_id, 'attachment_url' => $attachment_url));

    header( "Content-Type: application/json" );

    echo $response;

    exit;
}
add_action('wp_ajax_upload_file','ajax_upload_file');



/**
 * Funtion upload_attachment()
 *
 * * Description: get all providers or for an ID.
 *
 * @param (int) ($file_handler) default = 0;
 * @param (int) ($post_id) the id of the post to assign the attachment to ;
 * @param (int) ($setthumb) default = false;
 * @return (int) ($attach_id) the attachment id
 *
 */
function upload_attachment($file_handler, $post_id, $setthumb = 'false') {

	// check to make sure its a successful upload
	if ($_FILES[$file_handler]['error'] !== UPLOAD_ERR_OK)
		__return_false();

	require_once(ABSPATH . "wp-admin" . '/includes/image.php');
	require_once(ABSPATH . "wp-admin" . '/includes/file.php');
	require_once(ABSPATH . "wp-admin" . '/includes/media.php');

	$attach_id = media_handle_upload($file_handler, $post_id);

	if ($setthumb)
		update_post_meta($post_id, '_thumbnail_id', $attach_id);
	return $attach_id;
}