<?php
/*
function get buiding exterior sides

if id is passed then get the buiding exterior sides by id
*/

function get_unit_status($id = 0){

    return get_default_data('unit-status',$id);

}





function add_default_unit_status(){

    $default_unit_status = array();

    $default_unit_status[] = array("master_type"	=>"unit-status","value"=>"Sold","data"=>"");

    $default_unit_status[] = array("master_type"	=>"unit-status","value"=>"Available","data"=>"");

    $return = set_defaults_data($default_unit_status);

    return;
}

//add custom fields to unit post type


function add_unit_metaboxes() {

    add_meta_box('units_add_variant', 'Add Variant', 'add_variant', 'unit', 'normal', 'default');

}

add_action( 'add_meta_boxes', 'add_unit_metaboxes' );

// The Event Location Metabox
function add_variant() {
    global $post;
    // Noncename needed to verify where the data originated

    $unit_variant =   get_post_meta($post->ID, 'unit_variant', true);

    $unit_building =   get_post_meta($post->ID, 'building', true);

    $floor =   get_post_meta($post->ID, 'floor', true);

    $unit_variant =   get_post_meta($post->ID, 'unit_variant', true);

    $unit_status =   get_post_meta($post->ID, 'unit_status', true);

    $unit_type = get_unit_type_by_unit_variant($unit_variant);

    // Noncename needed to verify where the data originated
    echo '<input type="hidden" name="pagemeta_add_variant" id="pagemeta_add_variant" value="' .wp_create_nonce( plugin_basename(__FILE__) ) . '" />';
    ?>
     <table>
        <tr>
            <td>Select Unit Type</td>
            <td><select  name="unit_type" id="unit_type"  style="width:95%" >

                    <option value="">Select</option>
                    <?php

                    $unit_types = get_unit_types();

                    foreach ($unit_types as $unit_type_item){

                        ?>
                        <option value="<?php echo $unit_type_item['id']; ?>"  <?php if($unit_type==$unit_type_item['id']){ echo "selected"; }?>><?php echo  $unit_type_item['name']?></option>
                    <?php } ?>
                </select>
            </td>
        </tr>
         <tr>
             <td>Select Unit Variant</td>
             <td><select  name="unit_variant" id="unit_variant"  style="width:95%" >
                     <option value="">Select</option>
                     <?php
                         $unit_variants = get_unit_variants_by_unit_type($unit_type);
                         foreach ($unit_variants as $unit_variant_item){

                         ?>
                         <option value="<?php echo $unit_variant_item['variant_id']; ?>"  <?php if($unit_variant==$unit_variant_item['variant_id']){ echo "selected"; }?>><?php echo  $unit_variant_item['variant_name']?></option>
                        <?php }

                     ?>
                 </select>
             </td>
         </tr>
         <tr>
             <td>Select Floor</td>
             <td><select  name="floor" id="floor"  style="width:95%" >
                     <option value="">Select</option>
                     <?php
                     for($i=1;$i<=15;$i++){
                         ?>
                        <option value="<?php echo $i;?>" <?php if($floor==$i){ echo "selected"; }?>><?php echo $i;?></option>
                        <?php
                     }
                     ?>
                 </select>
             </td>
         </tr>
         <tr>
             <td>Select Building</td>
             <td><select  name="building" id="building"  style="width:95%" >
                     <option value="">Select</option>
                     <?php
                        $buildings = get_buildings();
                        foreach($buildings as $building){
                        ?>
                            <option value="<?php echo $building['id']; ?>" <?php if($unit_building==$building['id']){ echo "selected"; }?>><?php echo  $building['name']?></option>
                        <?php
                        }
                     ?>
                 </select>
             </td>
         </tr>
         <tr>
             <td>Select Status</td>
             <td><select  name="unit_status" id="unit_status"  style="width:95%" >

                     <option value="">Select</option>
                     <?php
                     $unit_statuses = get_unit_status();

                     foreach($unit_statuses as $unit_status_item){
                         ?>

                         <option value="<?php echo $unit_status_item["id"];?>" <?php if($unit_status==$unit_status_item["id"]){ echo "selected"; }?>><?php echo $unit_status_item["name"];?></option>

                         <?php
                     }

                     ?>
                 </select>
             </td>
         </tr>
     </table>
<?php
}

function unit_enqueue_scripts($hook) {

    wp_enqueue_script( 'backend_custom', get_template_directory_uri() . '/js/src/backend-custom.js' );
}
add_action( 'admin_enqueue_scripts', 'unit_enqueue_scripts' );

function save_unit($post_id, $post){



    if($post->post_type!="unit"){
        return $post->ID;
    }


    $unit_variant = $_REQUEST["unit_variant"];

    $floor = $_REQUEST["floor"];

    $building = $_REQUEST["building"];

    $unit_status = $_REQUEST["unit_status"];

    $unit_assigned = $_REQUEST["unit_assigned"];

    $views = $_REQUEST["views"];

    update_post_meta($post->ID, 'unit_variant', $unit_variant);

    update_post_meta($post->ID, 'floor', $floor);

    update_post_meta($post->ID, 'building', $building);

    update_post_meta($post->ID, 'unit_status', $unit_status);

    update_post_meta($post->ID, 'unit_assigned', $unit_assigned);

    update_post_meta($post->ID, 'apartment_views', $views);

    return $post->ID;
}
add_action('save_post', 'save_unit', 1, 2);

//delete building
function ajax_delete_unit(){

    $unit = $_REQUEST["id"];

    wp_delete_post( $unit, 1 );
 

$response = json_encode( array('msg'=> 'Successfully Deleted Apartment') );

header( "Content-Type: application/json" );

echo $response;

exit;
}
add_action('wp_ajax_delete_unit','ajax_delete_unit'); 

function ajax_get_unit_variants(){

    $unit_type = $_REQUEST["unit_type"];

    $unit_variants = get_unit_variants_by_unit_type($unit_type);

    $response = json_encode( $unit_variants );

    header( "Content-Type: application/json" );

    echo $response;

    exit;

}
add_action('wp_ajax_get_unit_variants','ajax_get_unit_variants');
add_action('wp_ajax_nopriv_get_unit_variants','ajax_get_unit_variants');

/*get unit variants by unit type*/
function get_unit_variants_by_unit_type($unit_type=0){

    global $wpdb;

    $query = "  SELECT  ITEMMASTERNAME.meta_value as variant_name, ITEMMASTERNAME.item_id variant_id FROM ".$wpdb->prefix."frm_items ITEMS JOIN ".$wpdb->prefix."frm_item_metas ITEMMASTERUNITTYPE ON ITEMS.id = ITEMMASTERUNITTYPE.item_id AND ITEMMASTERUNITTYPE.meta_value = '".$unit_type."' AND ITEMMASTERUNITTYPE.field_id = (select id from ".$wpdb->prefix."frm_fields where `type` = 'unittype' and form_id = 24) AND ITEMS.form_id = 24 JOIN ".$wpdb->prefix."frm_item_metas ITEMMASTERNAME ON ITEMMASTERUNITTYPE.item_id = ITEMMASTERNAME.item_id AND ITEMMASTERNAME.field_id = (select id from ".$wpdb->prefix."frm_fields where `field_key` = 'name' and form_id = 24) ";
 
    $unit_variants = $wpdb->get_results( $query,ARRAY_A);

    return $unit_variants;
}


function get_unit_type_by_unit_variant($unit_variant=0){

    global $wpdb;

    $query = "Select meta_value as unit_type from ".$wpdb->prefix."frm_item_metas where item_id = $unit_variant and field_id = (select ID from ".$wpdb->prefix."frm_fields where form_id = 24 and  type = 'unittype')";

    $unit_type = $wpdb->get_var( $query);

    return $unit_type;
}



/*get unit variants by unit type*/
function get_unit_variants($variant_id=0){

    global $frm_entry;


    if($variant_id==0){
     $results=   $frm_entry->getAll(array('it.form_id' => 24),'','',true);
    }else{
       $results=   $frm_entry->getAll(array('it.id' => $variant_id),'','',true);  
    }
   
 


    $unit_variants = array();
    foreach($results as $result){

        $persqftprice = is_null($result->metas['persqftprice'])?0:$result->metas['persqftprice'];
        
        $url2dlayout_image_id = $result->metas['2dlayout'];

        $url2dlayout_image = wp_get_attachment_image_src( $url2dlayout_image_id, 'large'    ); 
        
        $url3dlayout_image_id = $result->metas['3dlayout'];

        $url3dlayout_image = wp_get_attachment_image_src( $url3dlayout_image_id, 'large'    ); 

        $unit_variants[] = array(   'id'=>intval($result->id),
                                    'name'=>$result->metas['name'] ,
                                    'carpetarea'=>$result->metas['carpetarea'] ,
                                    'sellablearea'=>$result->metas['sellablearea'],
                                    'terracearea'=>$result->metas['terracearea'], 
                                    'url2dlayout_image'=>$url2dlayout_image[0],
                                    'url3dlayout_image'=>$url3dlayout_image[0],
                                    'roomsizes'=>get_room_type_for_sizes_name($result->metas['roomsizes']),
                                    'terraceoptions'=>$result->metas['terraceoptions']
                                    );
    }

    return $unit_variants;
}


//function to get names of the room types for sizes 
function get_room_type_for_sizes_name($data){

    $updated_data = array();

    if(is_array($data)){
         foreach ($data as $key => $value) {

        $room_type_for_sizes = get_room_type_for_sizes($value["room_type"]);
     
        $value["room_type"] =  $room_type_for_sizes[0]["name"];

         $updated_data[] = $value;
    }

    }
   
    return $updated_data;
}

/*get all units*/
function get_units(){

    $results = get_posts(array(

                'post_type'=>'unit',
                'posts_per_page' => -1

                )
    );

    $units = array();

    foreach($results as $result){

        $unit_variant =   get_post_meta($result->ID, 'unit_variant', true);

        $unit_building =   get_post_meta($result->ID, 'building', true);

        $floor =   get_post_meta($result->ID, 'floor', true);

        $unit_variant =   get_post_meta($result->ID, 'unit_variant', true);

        $unit_status =   get_post_meta($result->ID, 'unit_status', true);

        $unit_assigned =   get_post_meta($result->ID, 'unit_assigned', true);

        $views =   get_post_meta($result->ID, 'apartment_views', true);

        $unit_type = get_unit_type_by_unit_variant($unit_variant);

        $unitprice = get_unit_price($result->ID);//(parseInt( unitVariantmodel.get('persqftprice')) + parseInt(floorRiseValue)) * parseInt(unitVariantmodel.get 'sellablearea')
        
        $premiumunitprice = get_premium_unit_price($result->ID);//(parseInt( unitVariantmodel.get('persqftprice')) + parseInt(floorRiseValue)) * parseInt(unitVariantmodel.get 'sellablearea')
        
        $units[] = array(   'id'=>intval($result->ID),
                            'name'=>$result->post_title,
                            'unitType'=>intval($unit_type),
                            'unitVariant'=>intval($unit_variant),
                            'building'=>intval($unit_building),
                            'floor'=>intval($floor),
                            'views'=>($views),
                            'status'=>intval($unit_status),
                            'unitAssigned'=>intval($unit_assigned),
                            'unitPrice'=> ($unitprice),
                            'premiumUnitPrice'=> ($premiumunitprice),
                        );

    }

    return $units;
}

/* get_unit_price*/

function get_unit_price($unit_id)
{
    $unit_variant =   get_post_meta($unit_id, 'unit_variant', true);
 
    $unit_building =   get_post_meta($unit_id, 'building', true);

    $floor =   get_post_meta($unit_id, 'floor', true);

    $variant_data = (get_unit_variants($unit_variant));
     
    $persqftprice =  ($variant_data[0]["persqftprice"]=="")?0:$variant_data[0]["persqftprice"];

    $sellablearea = ($variant_data[0]["sellablearea"]=="")?0:$variant_data[0]["sellablearea"]; 

    $floorrise = get_building_floorrise($unit_building,$floor);

    return  (intval($persqftprice)+intval($floorrise))* intval($sellablearea);
  
}

/*
get_premium_unit_price
*/
function get_premium_unit_price($unit_id){
    
    $unit_variant =   get_post_meta($unit_id, 'unit_variant', true);
 
    $unit_building =   get_post_meta($unit_id, 'building', true);

    $floor =   get_post_meta($unit_id, 'floor', true);

    $variant_data = (get_unit_variants($unit_variant));
     
    $persqftprice =  ($variant_data[0]["persqftprice"]=="")?0:$variant_data[0]["persqftprice"];

    $sellablearea = ($variant_data[0]["sellablearea"]=="")?0:$variant_data[0]["sellablearea"]; 

    $floorrise = get_building_floorrise($unit_building,$floor);

    return  (intval($persqftprice)+intval($floorrise))* intval($sellablearea);
}
/*get unit by id*/
function get_unit_by_id($id){

    $result = get_post($id);

    $unit_variant =   get_post_meta($result->ID, 'unit_variant', true);

    $unit_building =   get_post_meta($result->ID, 'building', true);

    $floor =   get_post_meta($result->ID, 'floor', true);

    $unit_variant =   get_post_meta($result->ID, 'unit_variant', true);

    $unit_status =   get_post_meta($result->ID, 'unit_status', true);

    $unit_assigned =   get_post_meta($result->ID, 'unit_assigned', true);

    $apartment_views =   get_post_meta($result->ID, 'apartment_views', true);

    $unit_type = get_unit_type_by_unit_variant($unit_variant);

    return array(   'id'=>$result->ID,
                    'name'=>$result->post_title,
                    'unit_type'=>$unit_type,
                    'unit_variant'=>$unit_variant,
                    'building'=>$unit_building,
                    'floor'=>$floor,
                    'unit_assigned'=>$unit_assigned,
                    'apartment_views'=>$apartment_views,
                    'status'=>$unit_status
                );
}


function ajax_save_apartment(){

    $msg = "";
    $data  = "";
    $error = false;

    $floor = $_REQUEST["floor"];

    $building = $_REQUEST["building"]; 

    $apartment_id = $_REQUEST["apartment_id"]==""?0:$_REQUEST["apartment_id"]; 

    $flats_info = get_flats_on_floor($building ,$floor,$apartment_id);

    if($flats_info["created_flats"]==count($flats_info["flats"]) && empty($_REQUEST['apartment_id'])){
         $msg = "Cannot add more apartments on the selected floor and building!";
         $error = true;
    }

    if(duplicate_apartment($_REQUEST)){

        $msg = "Apartment Already Exists!";
        $error = true;

    }
    if($error == false){

         if(empty($_REQUEST['apartment_id'])){

                 // Create post object
                 $unit = array(
                     'post_title'    => $_REQUEST["flat_no"],
                     'post_status'   => 'publish',
                     'post_type'   => 'unit',
                 );

// Insert the post into the database
                 $apartment_id = wp_insert_post( $unit );

                if(is_wp_error($apartment_id)) {

                    $error = true;

                    $msg = "Error Creating Apartment!";

                 }
                 $msg = "Apartment Created Successfully!";

             }
            else{
                $unit = array(
                    'ID'    => $_REQUEST['apartment_id'],
                    'post_title'    => $_REQUEST["flat_no"],
                    'post_status'   => 'publish',
                    'post_type'   => 'unit',
                );
// Insert the post into the database
                $apartment_id = wp_update_post( $unit );

                $msg = "Apartment Updated Successfully!";
            }

    }

            


$response = json_encode( array('msg'=>$msg,'error'=>$error,'data'=> array('apartment_id'=>$apartment_id)) );

header( "Content-Type: application/json" );

echo $response;

exit;
}
add_action('wp_ajax_save_apartment','ajax_save_apartment'); 


function get_flats_on_floor($building ,$floor,$apartment_id){

    global $wpdb;

    $flats = array();

    $building_exceptions = maybe_unserialize(get_option('building_'.$building.'_exceptions'));
    
    //var to check if floor is found in exception
    $floor_in_exception = 0;
    foreach($building_exceptions as $building_exception){

        $building_exception["floors"] =  is_null($building_exception["floors"])?array():$building_exception["floors"];
            if(in_array($floor,$building_exception["floors"])){

                $flats = $building_exception["flats"];

                $floor_in_exception = 1;
            }
            if($floor_in_exception ==0){
                
                $flats = maybe_unserialize(get_option('building_'.$building.'_no_of_flats'));
    
            }
    }


    $query = "select count(*) from ".$wpdb->prefix."postmeta flat_floor join ".$wpdb->prefix."postmeta flat_building on flat_building.post_id = flat_floor.post_id where  flat_building.meta_key = 'building' and flat_building.meta_value = $building and  flat_floor.meta_key = 'floor' and flat_floor.meta_value = $floor    ";
    $created_flats = $wpdb->get_var($query);

    $apartment_building = get_post_meta($apartment_id,"building",true);

    $apartment_floor = get_post_meta($apartment_id,"floor",true);

    if( $apartment_floor==$floor && $apartment_building==$building){
        $created_flats--;
    }

    return (array("flats"=>get_flats_details($flats),"created_flats"=>$created_flats));
}
function ajax_get_flats_on_floor(){

    $building = $_REQUEST["building"];

    $floor = $_REQUEST["floor"];

    $apartment_id = $_REQUEST["apartment_id"]==""?0:$_REQUEST["apartment_id"]; 

    $flats = get_flats_on_floor($building ,$floor, $apartment_id);

    $response = json_encode( $flats );

    header( "Content-Type: application/json" );

    echo $response;

    exit;
}
add_action('wp_ajax_get_flats_on_floor','ajax_get_flats_on_floor');
add_action('wp_ajax_nopriv_get_flats_on_floor','ajax_get_flats_on_floor');


//function to check for duplicate apartments


function duplicate_apartment($data){
  
    $args = array( 
    'exclude' => $data["apartment_id"],
    'post_type' => 'unit',
    'meta_query' => array(
        array(
            'key' => 'unit_variant',
            'value' =>  $data["unit_variant"],
        ),
        array(
            'key' => 'floor',
            'value' => $data["floor"],
        ),
        array(
            'key' => 'building',
            'value' => $data["building"],
        ),
        array(
            'key' => 'unit_status',
            'value' => $data["unit_status"],
        ),
        array(
            'key' => 'unit_assigned',
            'value' => $data["unit_assigned"],
        ),
    )
 );


$apartments = get_posts( $args );

$return = false;

foreach($apartments as $apartment){
 
        if($apartment->post_title==$data["flat_no"]){
            $return = true;
        }

}  

return $return;
    
}