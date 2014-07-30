<?php


function add_default_flats_and_floors(){

    $default_facings = array();

    $default_facings[] = array("master_type"	=>"max-no-of-flats","value"=>"15","data"=>"");

    $default_facings[] = array("master_type"	=>"max-no-of-floors","value"=>"20","data"=>"");


    $return = set_defaults_data($default_facings);

}
function add_default_facings(){

    $default_facings = array();

    $default_facings[] = array("master_type"	=>"facings","value"=>"East","data"=>"");

    $default_facings[] = array("master_type"	=>"facings","value"=>"West","data"=>"");

    $default_facings[] = array("master_type"	=>"facings","value"=>"North","data"=>"");

    $default_facings[] = array("master_type"	=>"facings","value"=>"South","data"=>"");

    $default_facings[] = array("master_type"	=>"facings","value"=>"North-East","data"=>"");

    $default_facings[] = array("master_type"	=>"facings","value"=>"North-West","data"=>"");

    $default_facings[] = array("master_type"	=>"facings","value"=>"South-East","data"=>"");

    $default_facings[] = array("master_type"	=>"facings","value"=>"South-West","data"=>"");

    $return = set_defaults_data($default_facings);

    return;
}
function add_default_phases(){

    $default_phases = array();

    $default_phases[] = array("master_type"	=>"phases","value"=>"Phase 1","data"=>"");

    $default_phases[] = array("master_type"	=>"phases","value"=>"Phase 2","data"=>"");

    $default_phases[] = array("master_type"	=>"phases","value"=>"Phase 3","data"=>"");

    $default_phases[] = array("master_type"	=>"phases","value"=>"Phase 4","data"=>"");

    $return = set_defaults_data($default_phases);

    return;
}


function add_default_views(){

    $default_views = array();

    $default_views[] = array("master_type"	=>"views","value"=>"Standard View","data"=>"");

    $default_views[] = array("master_type"	=>"views","value"=>"Ocean View","data"=>"");

    $default_views[] = array("master_type"	=>"views","value"=>"Partial Ocean View","data"=>"");

    $default_views[] = array("master_type"	=>"views","value"=>"Poolside Gardens View","data"=>"");

    $default_views[] = array("master_type"	=>"views","value"=>"Island Gardens View","data"=>"");

    $default_views[] = array("master_type"	=>"views","value"=>"Garden View","data"=>"");

    $default_views[] = array("master_type"	=>"views","value"=>"Beach View","data"=>"");

    $default_views[] = array("master_type"	=>"views","value"=>"City View","data"=>"");

    $return = set_defaults_data($default_views);

    return;
}



//add custom fields for building taxonomy


function extra_building_fields($tag){

    $term_id = $tag->term_id;

    $building_facings_view = maybe_unserialize(get_option( "building_".$term_id."_facings_view",true));

    $building_phase = get_option( "building_".$term_id."_phase");


    if (is_null($term_id)){
        ?>
        <div class="form-field">
            <label for="tag-slug">Facings</label>
            <?php
                $buiding_facings = get_facings();

                $views =  get_views();

                $buiding_facing_ids = array();

                foreach($buiding_facings as $buiding_facing){

                    ?>
                    <div><?php echo ($buiding_facing['value']);?>:</div>

                    <table bgcolor="white" width="95%">
                            <?php
                                $c = 1;
                                foreach($views as $view){

                                    if($c==1){
                                        ?><tr><?php
                                    }

                                    ?>
                                    <td width="50%"><input style="width:5%" type="checkbox"  name="facing-views-<?php echo $buiding_facing['id'];?>[]" value="<?php echo $view["id"];?>"><?php echo $view["name"];?></td>
                                    <?php
                                    $c++;
                                    if($c==3){

                                    ?>
                                    </tr>
                                    <?php
                                        $c=1;
                                    }

                                }
                            if($c>1){
                                ?></tr><?php
                            }
                            ?>

                    </table>
                    <?php
                    $buiding_facing_ids[] = $buiding_facing['id'];
                }
            ?>
            <input type="hidden" name="buiding_facing_ids" id="buiding_facing_ids" value="<?php echo implode(",",$buiding_facing_ids);?>">
            <p><?php _e( 'select the views for each building facings' ); ?></p>
        </div>
        <div class="form-field">
        <label for="tag-slug">Phase</label>
            <select  name="building_phase" id="building_phase"  style="width:95%" >

                <option value="">Select</option>
                <?php

                $phases = get_phases();

                foreach ($phases as $phase){

                    ?>
                    <option value="<?php echo $phase['id']; ?>"  <?php if($building_phase==$phase['id']){ echo "selected"; }?>><?php echo  $phase['name']?></option>
                <?php } ?>
            </select>
        </div>
    <?php
    }else{
        ?>
        <tr class="form-field textbook_fields" >
            <th scope="row" valign="top"><?php _e( 'Facings' ); ?>
               </label></th>
            <td>
                <div class="row form-input">
                    <?php
                    $buiding_facings = get_facings();

                    $views =  get_views();

                    $buiding_facing_ids = array();

                    foreach($buiding_facings as $buiding_facing){

                        ?>
                        <div><?php echo ($buiding_facing['value']);?>:</div>

                        <table bgcolor="white" width="95%">
                            <?php
                            $c = 1;
                            foreach($views as $view){

                            if($c==1){
                            ?><tr><?php
                        }

                        ?>
                        <td width="25%"><input style="width:5%" type="checkbox"  name="facing-views-<?php echo $buiding_facing['id'];?>[]" value="<?php echo $view["id"];?>" <?php if(is_array($building_facings_view[$buiding_facing['id']])){ if(in_array($view["id"],$building_facings_view[$buiding_facing['id']])){ echo "checked"; }}?>><?php echo $view["name"];?></td>
                        <?php
                        $c++;
                        if($c==5){

                        ?>
                        </tr>
                            <?php
                            $c=1;
                            }

                            }
                            if($c>1){
                            ?></tr><?php
                        }
                        ?>

                        </table>
                        <?php
                        $buiding_facing_ids[] = $buiding_facing['id'];
                    }
                    ?>
                    <input type="hidden" name="buiding_facing_ids" id="buiding_facing_ids" value="<?php echo implode(",",$buiding_facing_ids);?>">

                    <br>
                    <span class="description"><?php _e( 'select the views for each building facings' ); ?></span>
                </div>
                <div class="form-field">
                    <label for="tag-slug">Phase</label>
                    <select  name="building_phase" id="building_phase"  style="width:95%" >

                        <option value="">Select</option>
                        <?php

                        $phases = get_phases();

                        foreach ($phases as $phase){

                            ?>
                            <option value="<?php echo $phase['id']; ?>"  <?php if($building_phase==$phase['id']){ echo "selected"; }?>><?php echo  $phase['name']?></option>
                        <?php } ?>
                    </select>
                </div>
            </td>
        </tr>
    <?php
    }
    ?>


<?php
}

add_action( 'building_add_form_fields', 'extra_building_fields', 10, 2 );

add_action( 'building_edit_form_fields', 'extra_building_fields', 10, 2 );


// save extra building taxonomy fields callback function
function save_extra_building_fields( $term_id ) {
 
    $no_of_floors = $_REQUEST["no_of_floors"];
    $no_of_flats_count = $_REQUEST["no_of_flats"]; 

    $no_of_flats = array();
    for($i=1;$i<=$no_of_flats_count;$i++){

        $image_id = $_REQUEST["image_id".$i];
        $no_of_flats[] = array("flat_no"=>$i,
                                "image_id"=>$image_id,
                                );
    }

     $building_phase =  $_REQUEST['building_phase'];


    $exceptions = array();
     $exceptions_count =  $_REQUEST['exceptions_count'];

     for($e = 1;$e<=$exceptions_count;$e++){
        $exception_floors = $_REQUEST['exception_floors'.$e];
        $exception_flats_count = $_REQUEST['no_of_flats'.$e];
        $no_of_exception_flats = array();
        for($i=1;$i<=$exception_flats_count;$i++){

                $image_id = $_REQUEST['exception_'.$e.'_image_id'.$i];
                $no_of_exception_flats[] = array("flat_no"=>$i,
                                        "image_id"=>$image_id,
                                        );
            }
        $exceptions[] = array(  'floors'=>$exception_floors,
                                'flats'=>$no_of_exception_flats
                            );


     }
    $floor_rise = array();
     for($i=1;$i<=$no_of_floors;$i++){
        
        $floor_rise[$i] = $_REQUEST["floor_rise_".$i];

     }
 
        //save the option array


    update_option( "building_".$term_id."_phase", $building_phase );

    update_option( "building_".$term_id."_no_of_floors", $no_of_floors );

    update_option( "building_".$term_id."_no_of_flats", $no_of_flats );

    update_option( "building_".$term_id."_exceptions", $exceptions ); 

    update_option( "building_".$term_id."_floor_rise", $floor_rise ); 


    return;
}
add_action( 'created_building', 'save_extra_building_fields', 10, 2 );

add_action( 'edited_building', 'save_extra_building_fields', 10, 2 );
/*
function get facings

if id is passed then get the bfacings sides by id
*/

function get_facings($id = 0){

    return get_default_data('facings',$id);

}

/*
function get phases

if id is passed then get the phases by id
*/

function get_phases($id = 0){

    return get_default_data('phases',$id);

}


/*
function get max no of floors

*/

function get_max_no_of_floors(){

    $max_no_of_floors = get_default_data('max-no-of-floors');

    return intval($max_no_of_floors[0]["name"]);

}

/*
function get max no of flats

*/

function get_max_no_of_flats(){

    $max_no_of_flats = get_default_data('max-no-of-flats');

    return intval($max_no_of_flats[0]["name"]);

}


/*
function get views

if id is passed then get the views by id
*/

function get_views($id = 0){

    return get_default_data('views',$id);

}

/* get building taxonomy items ,if by id then id should be passed*/

function get_buildings($ids=array())
{


    $categories = get_terms( 'building', array(
        'hide_empty' => 0,
        'include'	=> $ids
    ) );


    foreach($categories as $category){

        $building_no_of_floors = get_option( "building_".$category->term_id."_no_of_floors",true);
        
        $building_phase = get_option( "building_".$category->term_id."_phase",true);

        $building_floor_rise =  maybe_unserialize(get_option('building_'.$category->term_id.'_floor_rise')) ;
   
        $floor = array();

        //needs to be chnaged later with real data
        for ($i=1; $i<=$building_no_of_floors;$i++){
            $floor[$i] = $i;
        }
        $buildings[] = array('id'=>intval($category->term_id),"name"=>$category->name,"phase"=>intval($building_phase),"nooffloors"=>$building_no_of_floors,"floorrise"=> array_map('floatval', $building_floor_rise));

    }

    return $buildings;
}

//saving building

function ajax_save_building(){

    $msg = "";
    $data  = "";
    $error = false;

             if(empty($_REQUEST['building_id'])){
 
 

// Insert the term building
                 $building_id = wp_insert_term( $_REQUEST["building_name"],
                                                'building',
                                                array('parent'=>0));

                 

                if(is_wp_error($building_id)) {

                    $error = true;

                    $msg = "Error Creating Building!";

                 }
                 $msg = "Building Created Successfully!";

             }
            else{ 
                $building_id = $_REQUEST['building_id'];
                
                wp_update_term($building_id, 'building', array(
                                  'name' =>  $_REQUEST["building_name"]  
                                )) ;

                $msg = "Building Updated Successfully!";
            }


$response = json_encode( array('msg'=>$msg,'error'=>$error,'data'=> array('building_id'=>$building_id)) );

header( "Content-Type: application/json" );

echo $response;

exit;
}
add_action('wp_ajax_save_building','ajax_save_building');
add_action('wp_ajax_nopriv_save_building','ajax_save_building'); 

//delete building
function ajax_delete_building(){

    $building = $_REQUEST["id"];

    wp_delete_term( $_REQUEST["id"], 'building' );

    delete_option( "building_".$building."_phase" );

    delete_option( "building_".$building."_no_of_floors" );

    delete_option( "building_".$building."_no_of_flats" );

    delete_option( "building_".$building."_exceptions" ); 

$response = json_encode( array('msg'=> 'Successfully Deleted Building') );

header( "Content-Type: application/json" );

echo $response;

exit;
}
add_action('wp_ajax_delete_building','ajax_delete_building');
add_action('wp_ajax_nopriv_delete_building','ajax_delete_building');
//get building data by id
function get_building_by_id($building_id){

   $building =  get_term_by('id', $building_id, 'building');

   $building_phase = get_option('building_'.$building_id.'_phase');

   $building_no_of_floors = get_option('building_'.$building_id.'_no_of_floors');
   
   $building_no_of_flats = maybe_unserialize(get_option('building_'.$building_id.'_no_of_flats'));
 
   $building_no_of_flats = get_flats_details($building_no_of_flats);

   $building_floor_rise =  maybe_unserialize(get_option('building_'.$building_id.'_floor_rise')) ;
   
   $building_floor_rise = is_array($building_floor_rise)?$building_floor_rise:array();
   $building_exceptions = maybe_unserialize(get_option('building_'.$building_id.'_exceptions'));
   
   $building_exceptions_updated = array();
   
   foreach($building_exceptions as $building_exception){
 
        $building_exception["flats"] = get_flats_details($building_exception["flats"]);

        $building_exceptions_updated[] = $building_exception;
   }
   
   $building_exceptions = $building_exceptions_updated;
   
   $result = array('id'=>intval($building->term_id) ,'name'=>$building->name,'phase'=>$building_phase,'nooffloors'=>$building_no_of_floors,'noofflats'=>$building_no_of_flats,'exceptions'=>$building_exceptions,'floorrise'=>$building_floor_rise );
 
   return ($result);
}

//get additional info of flats and pass to the flats array as additional attributes e.g. image path
function get_flats_details($flats){

    $flats_updated = array();

     foreach($flats as $flat){

            $flat['image_url'] =  wp_get_attachment_thumb_url($flat["image_id"]);
            
            $flat['image_url']  = $flat['image_url'] ==false?get_no_image_150x150():$flat['image_url']; 
            $flats_updated[]  =  $flat;
        }

    return $flats_updated;
}
