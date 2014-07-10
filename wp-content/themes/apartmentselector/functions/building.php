<?php

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
                                    <td width="50%"><input style="width:5%" type="checkbox"  name="facing-views-<?php echo $buiding_facing['id'];?>[]" value="<?php echo $view["id"];?>"><?php echo $view["value"];?></td>
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
                    <option value="<?php echo $phase['id']; ?>"  <?php if($building_phase==$phase['id']){ echo "selected"; }?>><?php echo  $phase['value']?></option>
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
                        <td width="25%"><input style="width:5%" type="checkbox"  name="facing-views-<?php echo $buiding_facing['id'];?>[]" value="<?php echo $view["id"];?>" <?php if(is_array($building_facings_view[$buiding_facing['id']])){ if(in_array($view["id"],$building_facings_view[$buiding_facing['id']])){ echo "checked"; }}?>><?php echo $view["value"];?></td>
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
                            <option value="<?php echo $phase['id']; ?>"  <?php if($building_phase==$phase['id']){ echo "selected"; }?>><?php echo  $phase['value']?></option>
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

    if (isset($_REQUEST['buiding_facing_ids'])) {

        $buiding_facing_ids =  explode(",",$_REQUEST['buiding_facing_ids'] ) ;

        $building_facings = array();

        foreach($buiding_facing_ids as $buiding_facing_id){

            $facing_views = $_REQUEST['facing-views-'.$buiding_facing_id];

            $building_facings[$buiding_facing_id] =   $facing_views;

        }

        $building_phase =  $_REQUEST['building_phase'];
        //save the option array
       update_option( "building_".$term_id."_facings_view", $building_facings );
        //save the option array
        update_option( "building_".$term_id."_phase", $building_phase );

    }
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
function get views

if id is passed then get the views by id
*/

function get_views($id = 0){

    return get_default_data('views',$id);

}

/* get building taxonomy items ,if by id then id should be passed*/

function get_buildings($ids=array())
{

    $unit_types = array();

    $categories = get_terms( 'building', array(
        'hide_empty' => 0,
        'include'	=> $ids
    ) );

    foreach($categories as $category){

        $building_facings = get_option( "building_".$category->term_id."_facings",true);

        $buildings[] = array('id'=>$category->term_id,"name"=>$category->name,"building_facings"=>$building_facings);

    }
    return $buildings;
}