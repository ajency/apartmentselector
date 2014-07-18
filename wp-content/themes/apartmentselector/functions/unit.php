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

    update_post_meta($post->ID, 'unit_variant', $unit_variant);

    update_post_meta($post->ID, 'floor', $floor);

    update_post_meta($post->ID, 'building', $building);

    update_post_meta($post->ID, 'unit_status', $unit_status);

    return $post->ID;
}
add_action('save_post', 'save_unit', 1, 2);

function ajax_get_unit_variants(){

    $unit_type = $_REQUEST["unit_type"];

    $unit_variants = get_unit_variants_by_unit_type($unit_type);

    $response = json_encode( $unit_variants );

    header( "Content-Type: application/json" );

    echo $response;

    exit;

}
add_action('wp_ajax_get_unit_variants','ajax_get_unit_variants');

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
function get_unit_variants(){

    global $frm_entry;

    $results=   $frm_entry->getAll(array('it.form_id' => 24),'','',true);



    $unit_variants = array();
    foreach($results as $result){
        $unit_variants[] = array('id'=>$result->id ,'name'=>$result->metas['name'] ,'carpet_area'=>$result->metas['carpet_area'] ,'sellable_area'=>$result->metas['sellable_area']);
    }

    return $unit_variants;
}



/*get all units*/
function get_units(){

    $results = get_posts(array(

                'post_type'=>'unit'

                )
    );

    $units = array();

    foreach($results as $result){

        $unit_variant =   get_post_meta($result->ID, 'unit_variant', true);

        $unit_building =   get_post_meta($result->ID, 'building', true);

        $floor =   get_post_meta($result->ID, 'floor', true);

        $unit_variant =   get_post_meta($result->ID, 'unit_variant', true);

        $unit_status =   get_post_meta($result->ID, 'unit_status', true);

        $unit_type = get_unit_type_by_unit_variant($unit_variant);

        $units[] = array(   'id'=>$result->ID,
                            'name'=>$result->post_title,
                            'unit_type'=>$unit_type,
                            'unit_variant'=>$unit_variant,
                            'building'=>$unit_building,
                            'floor'=>$floor,
                            'status'=>$unit_status,
                        );

    }

    return $units;
}


/*get unit by id*/
function get_unit_by_id($id){

    $result = get_post($id);

    $unit_variant =   get_post_meta($result->ID, 'unit_variant', true);

    $unit_building =   get_post_meta($result->ID, 'building', true);

    $floor =   get_post_meta($result->ID, 'floor', true);

    $unit_variant =   get_post_meta($result->ID, 'unit_variant', true);

    $unit_status =   get_post_meta($result->ID, 'unit_status', true);

    $unit_type = get_unit_type_by_unit_variant($unit_variant);

    return array(   'id'=>$result->ID,
                    'name'=>$result->post_title,
                    'unit_type'=>$unit_type,
                    'unit_variant'=>$unit_variant,
                    'building'=>$unit_building,
                    'floor'=>$floor,
                    'status'=>$unit_status
                );
}


function ajax_save_apartment(){

    $msg = "";
    $data  = "";
    $error = false;

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


$response = json_encode( array('msg'=>$msg,'error'=>$error,'data'=> array('apartment_id'=>$apartment_id)) );

header( "Content-Type: application/json" );

echo $response;

exit;
}
add_action('wp_ajax_save_apartment','ajax_save_apartment');