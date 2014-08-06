<?
//form heading

if(!current_user_can('manage_buildings') && !current_user_can('manage_options')){

    wp_redirect(site_url('no-access'));

    exit;
    
} 
$heading = "Add";

$no_of_flats = 0;

$building_exceptions = array();

if(isset($_REQUEST["id"])){

$heading = "Edit";

    $building_id = $_REQUEST["id"];

    $building = (get_building_by_id($building_id));

    $building_name = $building["name"];

    $building_phase = $building["phase"];

    $no_of_floors = $building["nooffloors"];

    $building_no_of_flats = $building["noofflats"];

    $no_of_flats = count($building_no_of_flats);

    $floorrise = $building["floorrise"];

    $building_exceptions = $building["exceptions"]; 
}
?>
<div class="page-title">

    <i class="icon-custom-left">
    </i>
    <h3>
        <?php echo $heading;?> Building
    </h3>

</div>

<div class="row">
<div class="col-md-6">
<div class="grid simple">
<div class="grid-title no-border">
    <h4>
        Enter Building Details
    </h4>
</div>
<div class="grid-body no-border">
<form id="form_add_edit_building"  name = "form_add_edit_building" action="" novalidate="novalidate">
 
<?php echo wp_nonce_field( plugin_basename( __FILE__ ), 'custom_save_building',true,false);?>
<input type="hidden" name="building_id" id="building_id" value="<?php echo @$building_id;?>" />
                    <br/>
<div class="form-group">
    <label class="form-label">
        Building Name
    </label>
                  <span class="help">
                    ex: Block A
                  </span>
    <div class="input-with-icon  right">

        <i class="">
        </i>
        <input type="text" name="building_name" id="building_name" value="<?php echo $building_name;?>"class="form-control">

    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="form-group">
            <label class="form-label">
                Phase
            </label>

            <div class="input-with-icon  right">

                <i class="">
                </i>
                <select  name="building_phase" id="building_phase"  >

                    <option value="">Select</option>
                    <?php

                    $phases = get_phases();

                    foreach ($phases as $phase){

                        ?>
                        <option value="<?php echo $phase['id']; ?>"  <?php if($building_phase==$phase['id']){ echo "selected"; }?>><?php echo  $phase['name']?></option>
                    <?php } ?>
                </select>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="form-label">
                No of Floors
            </label>

            <div class="input-with-icon  right">

                <i class="">
                </i>
                <select name="no_of_floors" id="no_of_floors">
                    <option value="">
                        Please Select
                    </option>
                    <?php
                    $max_no_of_floors = get_max_no_of_floors();

                         for($i=1;$i<=$max_no_of_floors;$i++){
                            ?>
                            <option value="<?php echo $i;?>" <?php if($i==$no_of_floors){ ?>selected <?php } ?>>
                                <?php echo $i;?>
                            </option>
                            <?php

                        }
                    ?>

                </select>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label class="form-label">
                No of flats per floor
            </label>

            <div class="input-with-icon  right">

                <i class="">
                </i>
                <select name="no_of_flats" prev_flat_count="<?php echo $no_of_flats; ?>"  id="no_of_flats" class="no_of_flats" flats_container_id="flats_container" exception_no="">
                    <option value="">
                        Please Select
                    </option>
                    <?php
                    $max_no_of_flats = get_max_no_of_flats();

                    for($i=1;$i<=$max_no_of_flats;$i++){
                        ?>
                        <option value="<?php echo $i;?>" <?php if($i==$no_of_flats){ ?>selected <?php } ?>>
                            <?php echo $i;?>
                        </option>
                    <?php

                    }
                    ?>

                </select>
            </div>
        </div>
    </div>
</div>

<div class="well" id="flats_container" <?php if($no_of_flats==0){ ?> style="display:none"<?}?>  >
 
        <? 
            if($no_of_flats!=0){ 
                foreach($building_no_of_flats as $building_no_of_flat){
                    ?><div flatno ='<?php echo $building_no_of_flat['flat_no'];?>' class='flat_ui belongs_to_no_of_flats' >
                    <div class="form-group">   <label class="form-label">
       Flat No: <?php echo $building_no_of_flat['flat_no'];?>
        </label>
        <span class="help">
         </span> 
        <div class="row">
         <div class="col-md-4">
                  <span class="btn btn-success fileinput-button">
                    <i class="glyphicon glyphicon-plus"></i>
                    <span>Select files...</span>
                    <input type="hidden" class="image_id" name="image_id<?php echo $building_no_of_flat['flat_no'];?>" value="<?php echo $building_no_of_flat['image_id'];?>"><input id="fileupload<?php echo $building_no_of_flat['flat_no'];?>" class="fileupload" type="file" name="files">
                    </span>
                    <br>
                    <br>
                    <div id="progress<?php echo $building_no_of_flat['flat_no'];?>" class="progress" >
                    <div class="progress-bar progress-bar-success"></div>
                    </div>
                    <div id="files<?php echo $building_no_of_flat['flat_no'];?>" class="files"></div>
                    <br><div class="row-fluid">
                    <div class="col-md-12">
                    <img src="<?php echo $building_no_of_flat['image_url'];?>" class="image_display">
                    </div>
                    </div>
                     </div>
         </div>
         </div>
         <div class="row-fluid">
         <div class="col-md-12">
         <img src="">
         </div> </div></div>
                    <?php
                }
                ?><?php
            }
            ?>
        
 


</div>

<div id="exceptions" <?php if(count($building_exceptions)==0){?>style="display:none"<?php } ?>>
    <b>Add Exceptions</b>  <button style="display:none" type="button" class="btn " id="add_exceptions"exception_count="0"> 
    <input type="hidden" name="exceptions_count" value="<?php echo count($building_exceptions);?>" id="exceptions_count">
    <i class="icon-ok"></i>
        +
    </button>
    <div class="exception_container">
        <div class="form-group"> 
            <div class="input-with-icon  right exception_floors"><br><br>
                <?php
                $exception_count = 1;
                foreach($building_exceptions as $building_exception){
                  $building_exception["floors"] =  is_array($building_exception["floors"])?$building_exception["floors"]:array();
                ?>
                 <div id="exception_floors_container<?php echo($exception_count);?>">
                   <?php 
                    for($i=1;$i<=$no_of_floors;$i++){
                       ?><div class="col-md-4">
                        <div class='exception_floor checkbox check-default' id='<?php echo($exception_count);?>exception_floor_item<?php echo($i);?>'> <input type="checkbox" name="exception_floors<?php echo($exception_count);?>[]" id='<?php echo($exception_count);?>exception_floors<?php echo($i);?>' value="<?php echo $i;?>" <?php if(in_array($i,$building_exception["floors"])){ echo "checked";}?>> <label for="<?php echo($exception_count);?>exception_floors<?php echo($i);?>"><?php echo $i;?></label></div></div>
                    <?php    
                    }
                     
                    $no_of_flats = count($building_exception["flats"]);
 
                    ?>
                </div>
                <div style="clear:both"></div>
                <div class="form-group">
                    <label class="form-label">
                        No Of Flats
                    </label>
                    <div class="input-with-icon  right">
                        <i class="">
                        </i>
                        <select name="no_of_flats<?php echo($exception_count);?>"  class="no_of_flats"  id="no_of_flats<?php echo($exception_count);?>" flats_container_id="flats_container<?php echo($exception_count);?>" exception_no="<?php echo($exception_count);?>">'
                            <option value="">Please Select</option>'

                            <?php $max_no_of_flats = get_max_no_of_flats();

                            for($i=1;$i<=$max_no_of_flats;$i++){
                            ?><option value="<?php echo $i;?>" <?php if($i==$no_of_flats){ ?>selected <?php } ?>><?php echo $i;?></option>
                            <?php  
                            }?>
                        </select>
                    </div>
                </div>
                <div class="well" id="flats_container<?php echo($exception_count);?>" <?php if($no_of_flats==0){ ?> style="display:none"<?}?>>
                <?php 
                if($no_of_flats!=0){
                     foreach($building_exception["flats"] as $building_no_of_flat){
                     ?>
                     <div flatno ='<?php echo $building_no_of_flat['flat_no'];?>' class='flat_ui belongs_to_no_of_flats<?php echo($exception_count);?>' ><div class="form-group">
                            <label class="form-label">
                                Flat No: <?php echo $building_no_of_flat['flat_no'];?>
                            </label>
                            <span class="help">
                            </span>
                                      <div class="row">
                                <div class="col-md-4">
                                    <span class="btn btn-success fileinput-button">
                                    <i class="glyphicon glyphicon-plus"></i>
                                    <span>Select files...</span> 
                                        <input type="hidden" class="image_id" name="exception_<?php echo($exception_count);?>_image_id<?php echo $building_no_of_flat['flat_no'];?>" value="<?php echo $building_no_of_flat['image_id'];?>"><input id="fileuploadexception_<?php echo($exception_count);?>_<?php echo $building_no_of_flat['flat_no'];?>" class="fileupload" type="file" name="files" >
                                    </span>
                                    <br>
                                    <br>
                                    <div id="progress<?php echo $building_no_of_flat['flat_no'];?>" class="progress">
                                        <div class="progress-bar progress-bar-success"></div>
                                    </div>
                                    <div id="files<?php echo $building_no_of_flat['flat_no'];?>" class="files"></div>
                                    <br>
                                    <div class="row-fluid">
                                        <div class="col-md-12">
                                            <img src="<?php echo $building_no_of_flat['image_url'];?>" class="image_display">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <div class="row-fluid">
                        <div class="col-md-12">
                             <img src="">
                        </div> 
                    </div>
                    </div>
                     <?php   
                    }

                    ?>

                    <?php
                }

                ?> 
                </div>
                <?}
                ?> 
            </div>
        </div>
    </div> 
    <div style="clear:both"></div>
    <b>Floor Rise</b>
    <div class="well" id="flats_container">
        <div id="floor_rise_container">
             <?php
                for($floor=1;$floor<=$no_of_floors;$floor++){

                    $floor_rise =  $floorrise[$floor] ==""?0:  $floorrise[$floor];
                    ?>
                <div class='floor_rise form-group' id='floor_rise_item<?php echo $floor?>'> Floor<label class="form-label"><?php  echo $floor;?></label>: <input type='text' class='form-control' value='<?php echo $floor_rise?>' name='floor_rise_<?php echo $floor?>'></div>
                    <?php
                }
             ?>

        </div>
    </div>
</div>  



<div class="form-actions">

    <button type="button" class="btn btn-success btn-cons" id="save_building">
        <i class="icon-ok">
        </i>
        Submit
    </button>
</div>
</form>
</div>
</div>
</div>
</div>