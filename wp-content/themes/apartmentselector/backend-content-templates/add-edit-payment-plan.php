<?
//form heading

if(!current_user_can('manage_buildings') && !current_user_can('manage_options')){

    wp_redirect(site_url('no-access'));

    exit;
    
} 
$heading = "Add"; 

if(isset($_REQUEST["id"])){

$heading = "Edit";

    $payment_plan_id = $_REQUEST["id"];

    $payment_plan = (get_payment_by_id($payment_plan_id));
 
    $payment_plan_name = $payment_plan["option_name"];
 
    $payment_milestones = maybe_unserialize($payment_plan["milestones"]);

     
}
?>
<div class="page-title">

    <i class="icon-custom-left">
    </i>
    <h3>
        <?php echo $heading;?> Payment Plan
    </h3>

</div>

<div class="row">
<div class="col-md-6">
<div class="grid simple">
<div class="grid-title no-border">
    <h4>
        Enter Payment Plan Details
    </h4>
</div>
<div class="grid-body no-border">
<form id="form_add_edit_payment_plan"  name = "form_add_edit_payment_plan" action="" novalidate="novalidate">
 
<?php echo wp_nonce_field( plugin_basename( __FILE__ ), 'custom_save_payment_plan',true,false);?>
<input type="hidden" name="payment_plan_id" id="payment_plan_id" value="<?php echo @$building_id;?>" />
                    <br/>
<div class="form-group">
    <label class="form-label">
        Payment Plan Name
    </label> 
    <div class="input-with-icon  right">

        <i class="">
        </i>
        <input type="text" name="payment_plan_name" id="payment_plan_name" value="<?php echo $payment_plan_name;?>"class="form-control">

    </div>
</div>
<div class="form-group">
    <label class="form-label">
        Milestones
    </label> 
    <div class="input-with-icon  right">

        <i class="">
        </i>
       <ul id="milestone-list">

       <?php
       ?>
          <li class="sortable-items" item="1">
              
              <select  name="milestone" id="milestone_1"   class="milestone form-control form-control-medium">
              <option value="">Select Milestone</option>
              <option value="+" class="select-add-item ">Add New Milestone</option>
              <?php
              $milestones = get_milstones();

              foreach($milestones as $milestone)
              {

                ?>
                <option value="<?php echo $milestone["id"];?>"  ><?php echo $milestone["name"];?></option>
                <?
              }
              ?>
              </select>
              <input type="text" name="payment_percentage" id="payment_percentage_1" value="" class="form-control  form-control-small"> %
              <a href="javascript:void(0)" item="1" class="milestone-remove">x</a>
          </li>
          
        </ul>
            <a href="javascript:void(0)" id="add-more-milstones" count="1">Add More</a>
            <div editing-element="" class="modal fade" id="milestone-form" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">Create New Milestone</h4>
                  </div>
                  <div class="modal-body">
                    Milestone : <input type='text' id="milestone_name">
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="save-milestone">Create</button>
                  </div>
                </div>
              </div>
            </div>
    </div>
</div>
  



<div class="form-actions">

    <button type="button" class="btn btn-success btn-cons" id="save_payment_plan">
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