<?php

function add_default_building_exterior_sides(){

    $default_building_exterior_sides = array();

    $default_building_exterior_sides[] = array("master_type"	=>"building-exterior-side","value"=>"Front","data"=>"");

    $default_building_exterior_sides[] = array("master_type"	=>"building-exterior-side","value"=>"Back","data"=>"");

    $default_building_exterior_sides[] = array("master_type"	=>"building-exterior-side","value"=>"Left","data"=>"");

    $default_building_exterior_sides[] = array("master_type"	=>"building-exterior-side","value"=>"Right","data"=>"");

    $return = set_defaults_data($default_building_exterior_sides);

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
    
    $building_ext_view = maybe_unserialize(get_option( "building_".$term_id."_ext_view",true));


    if (is_null($term_id)){
        ?>
        <div class="form-field">
            <label for="tag-slug">Exterior Side Views</label>
            <?php
                $buiding_exterior_sides = get_buiding_exterior_sides();

                $views =  get_views();

                $buiding_exterior_side_ids = array();

                foreach($buiding_exterior_sides as $buiding_exterior_side){

                    ?>
                    <div><?php echo ($buiding_exterior_side['value']);?>:</div>

                    <table bgcolor="white" width="95%">
                            <?php
                                $c = 1;
                                foreach($views as $view){

                                    if($c==1){
                                        ?><tr><?php
                                    }

                                    ?>
                                    <td width="50%"><input style="width:5%" type="checkbox"  name="exterior-side-views-<?php echo $buiding_exterior_side['id'];?>[]" value="<?php echo $view["id"];?>"><?php echo $view["value"];?></td>
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
                    $buiding_exterior_side_ids[] = $buiding_exterior_side['id'];
                }
            ?>
            <input type="hidden" name="buiding_exterior_side_ids" id="buiding_exterior_side_ids" value="<?php echo implode(",",$buiding_exterior_side_ids);?>">
            <p><?php _e( 'select the views for each exterior side of the building' ); ?></p>
        </div>
    <?php
    }else{
        ?>
        <tr class="form-field textbook_fields" >
            <th scope="row" valign="top"><?php _e( 'Exterior Side Views' ); ?>
               </label></th>
            <td>
                <div class="row form-input">
                    <?php
                    $buiding_exterior_sides = get_buiding_exterior_sides();

                    $views =  get_views();

                    $buiding_exterior_side_ids = array();

                    foreach($buiding_exterior_sides as $buiding_exterior_side){

                        ?>
                        <div><?php echo ($buiding_exterior_side['value']);?>:</div>

                        <table bgcolor="white" width="95%">
                            <?php
                            $c = 1;
                            foreach($views as $view){

                            if($c==1){
                            ?><tr><?php
                        }

                        ?>
                        <td width="25%"><input style="width:5%" type="checkbox"  name="exterior-side-views-<?php echo $buiding_exterior_side['id'];?>[]" value="<?php echo $view["id"];?>" <?php if(in_array($view["id"],$building_ext_view[$buiding_exterior_side['id']])){ echo "checked"; }?>><?php echo $view["value"];?></td>
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
                        $buiding_exterior_side_ids[] = $buiding_exterior_side['id'];
                    }
                    ?>
                    <input type="hidden" name="buiding_exterior_side_ids" id="buiding_exterior_side_ids" value="<?php echo implode(",",$buiding_exterior_side_ids);?>">

                    <br>
                    <span class="description"><?php _e( 'select the views for each exterior side of the building' ); ?></span>
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

    if (isset($_REQUEST['buiding_exterior_side_ids'])) {

        $buiding_exterior_side_ids =  explode(",",$_REQUEST['buiding_exterior_side_ids'] ) ;

        $building_ext_view = array();

        foreach($buiding_exterior_side_ids as $buiding_exterior_side_id){

            $exterior_side_views = $_REQUEST['exterior-side-views-'.$buiding_exterior_side_id];

            $building_ext_view[$buiding_exterior_side_id] =   $exterior_side_views;

        }

        //save the option array
       update_option( "building_".$term_id."_ext_view", $building_ext_view );

    }
    return;
}
add_action( 'created_building', 'save_extra_building_fields', 10, 2 );

add_action( 'edited_building', 'save_extra_building_fields', 10, 2 );
/*
function get buiding exterior sides

if id is passed then get the buiding exterior sides by id
*/

function get_buiding_exterior_sides($id = 0){

    return get_default_data('building-exterior-side',$id);

}

/*
function get views

if id is passed then get the views by id
*/

function get_views($id = 0){

    return get_default_data('views',$id);

}