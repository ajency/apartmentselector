<?php
if(!current_user_can('manage_settings') && !current_user_can('manage_options')){
echo "dddd";
    wp_redirect(site_url('no-access'));

    exit;
    
}   

$settings = get_apratment_selector_settings();

$vat = isset($settings["vat"])?$settings["vat"]:0; 
$sales_tax = isset($settings["sales_tax"])?$settings["sales_tax"]:0;  
$infrastructure_charges = isset($settings["infrastructure_charges"])?$settings["infrastructure_charges"]:0;  
$membership_fees = isset($settings["membership_fees"])?$settings["membership_fees"]:0;   
 
?>
<div class="page-title"> <i class="icon-custom-left"></i>
    <h3>General Settings</h3>

</div>
<div class="row">
    <div class="col-md-6">
        <div class="grid simple">
            <div class="grid-title no-border">

            </div>
            <div class="grid-body no-border">
                <form id="form_edit_settings" action="" novalidate="novalidate">
                    <input type="hidden" name="action" id="action" value="save_settings" />
                    <?php echo wp_nonce_field( plugin_basename( __FILE__ ), 'custom_save_apartment',true,false);?>
                     <br/>
                    <div class="form-group">
                        
                        <div class="input-with-icon  right">
						<div class="row">
						<div class="col-md-4">
                            <label class="form-label form-label-inline" for="vat">VAT</label>
                        <span class="help"></span>
                            <label class="form-label form-label-prefix">  </label></div><div class="col-md-7"><input type="text" name="vat" id="vat" class="form-control" value="<?php echo @$vat;?>"></div><div class="col-md-1"><label class="form-label form-label-inline"> %</label></div>
							</div>
                        </div>
                    </div>
                    <div class="form-group">
                        
                        <div class="input-with-icon  right">
						<div class="row">
						<div class="col-md-4">
                            <label class="form-label form-label-inline">Sales tax</label>
                                <span class="help"></span>
                            <label class="form-label form-label-prefix"> </label></div><div class="col-md-7"><input type="text" name="sales_tax" id="sales_tax" class="form-control" value="<?php echo @$sales_tax;?>"></div><div class="col-md-1"><label class="form-label form-label-inline"> %</label></div>
							</div>
                        </div>
                    </div>
                    <div class="form-group">
                        
                        <div class="input-with-icon  right">
						<div class="row">
						<div class="col-md-3">
                            <label class="form-label form-label-prefix">Infrastructure Charges</label>
                                <span class="help"></span></div><div class="col-md-1">
                             <label class="form-label form-label-inline"> Rs.</label></div>
							 <div class="col-md-7">
							 <input type="text" name="infrastructure_charges" id="infrastructure_charges" class="form-control" value="<?php echo @$infrastructure_charges;?>"></div>
							 </div>
                        </div>
                    </div>
                    <div class="form-group">
                       <div class="input-with-icon  right">
					   <div class="row">
					   <div class="col-md-3">
                             <label class="form-label form-label-inline">Membership Fees</label>
                        <span class="help"></span></div>
                        <div class="col-md-1">
						<label class="form-label form-label-inline">
                            Rs.</label></div>
							<div class="col-md-7">
							<input type="text" name="membership_fees" id="membership_fees" class="form-control" value="<?php echo @$membership_fees;?>"></div>
							</div>
                        </div>
                    </div>
                     
                     

                    <div class="form-actions">
                        <button type="button" class="btn btn-success btn-cons" name="save_settings"  id="save_settings"><i class="icon-ok"></i> Submit</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>