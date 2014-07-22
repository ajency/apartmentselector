<?
if(isset($_REQUEST["id"])){

    $apartment_id = $_REQUEST["id"];

    $unit = (get_unit_by_id($apartment_id));

    $flat_no = $unit["name"];

    $unit_type = $unit["unit_type"];

    $unit_variant = $unit["unit_variant"];

    $unit_building = $unit["building"];

    $unit_assigned = $unit["unit_assigned"];

    $floor = $unit["floor"];

    $unit_status = $unit["status"];
}
?>
<div class="page-title"> <i class="icon-custom-left"></i>
    <h3>Select your Apartment</h3>

</div>
<div class="row">
    <div class="col-md-6">
        <div class="grid simple">
            <div class="grid-title no-border">

            </div>
            <div class="grid-body no-border">
                <form id="form_add_edit_apartment" action="" novalidate="novalidate">
                    <input type="hidden" name="action" id="action" value="save_apartment" />
                    <?php echo wp_nonce_field( plugin_basename( __FILE__ ), 'custom_save_apartment',true,false);?>
                    <input type="hidden" name="apartment_id" id="apartment_id" value="<?php echo @$apartment_id;?>" />
                    <br/>
                    <div class="form-group">
                        <label class="form-label">Flat No</label>
                        <span class="help">e.g:A-123</span>
                        <div class="input-with-icon  right">
                            <i class=""></i>
                            <input type="text" name="flat_no" id="flat_no" class="form-control" value="<?php echo @$flat_no;?>">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">Unit Type</label>

                                <div class="input-with-icon  right">
                                    <i class=""></i>
                                    <select  name="unit_type" id="unit_type"    >

                                        <option value="">Select</option>
                                        <?php

                                        $unit_types = get_unit_types();

                                        foreach ($unit_types as $unit_type_item){

                                            ?>
                                            <option value="<?php echo $unit_type_item['id']; ?>"  <?php if($unit_type==$unit_type_item['id']){ echo "selected"; }?>><?php echo  $unit_type_item['name']?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">Unit Variant</label>

                                <div class="input-with-icon  right">
                                    <i class=""></i>
                                    <select  name="unit_variant" id="unit_variant"  >
                                        <option value="">Select</option>
                                        <?php
                                        $unit_variants = get_unit_variants_by_unit_type($unit_type);
                                        foreach ($unit_variants as $unit_variant_item){

                                            ?>
                                            <option value="<?php echo $unit_variant_item['variant_id']; ?>"  <?php if($unit_variant==$unit_variant_item['variant_id']){ echo "selected"; }?>><?php echo  $unit_variant_item['variant_name']?></option>
                                        <?php }

                                        ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Building</label>

                        <div class="input-with-icon  right">
                            <i class=""></i>
                            <select  name="building" id="building"  >
                                <option value="">Select</option>
                                <?php
                                $floors_option = 0;
                                $buildings = get_buildings();
                                foreach($buildings as $building){
                                    ?>
                                    <option  floors = "<?php echo $building['building_no_of_floors']; ?>" value="<?php echo $building['id']; ?>" <?php if($unit_building==$building['id']){ echo "selected";$floors_option=$building['building_no_of_floors']; }?>><?php echo  $building['name']?></option>
                                <?php
                                }
                                ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Floor</label>

                        <div class="input-with-icon  right">
                            <i class=""></i>
                            <select  name="floor" id="floor"  >
                                <option value="">Select</option>
                                <?php
                                for($i=1;$i<=$floors_option;$i++){
                                    ?>
                                    <option value="<?php echo $i;?>" <?php if($floor==$i){ echo "selected"; }?>><?php echo $i;?></option>
                                <?php
                                }
                                ?>
                            </select>
                        </div>
                    </div>
                     <div class="well">Select Flat:
                     <div id="flat_container">
                     <?php if(!empty($unit_building) && !empty($floor)){
                            $flats = get_flats_on_floor($unit_building ,$floor);
                            ?>
                                <div class="row-fluid" > <div class="row">
                            <?php
                            foreach($flats as $flat){
                                    ?>
                                        <div class="col-md-6"><input type="radio" name="unit_assigned"  <?php if($unit_assigned==$flat["flat_no"]){ echo "checked";}?> value="<?php echo $flat["flat_no"]?>"><?php echo $flat["flat_no"]?><br><img src="<?php echo $flat["image_url"]?>" class="image_display"></div>
                                    <?php
                            }
                            ?>
                                </div></div>
                            <?php
                        }
                        else{
                        ?>
                                <i>select building and floor</i>
                        <?php
                        }
                        ?>
                     </div>
                     </div>
                    <div class="form-group">
                        <label class="form-label">Status</label>

                        <div class="input-with-icon  right">
                            <i class=""></i>
                            <select  name="unit_status" id="unit_status"   >

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
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn btn-success btn-cons" name="save_apartment"  id="save_apartment"><i class="icon-ok"></i> Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>