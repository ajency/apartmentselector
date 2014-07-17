<?php
/**
 * Template Name: Add Edit Apartment
 * The template for displaying all pages
 *
 * @package WordPress
 * @subpackage Twenty_Fourteen
 * @since Twenty Fourteen 1.0
 */?>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <meta charset="utf-8" />
    <title>Add Option</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!-- BEGIN PLUGIN CSS -->
    <?php wp_head(); ?>
    <!-- END CSS TEMPLATE -->
</head>
<!-- BEGIN BODY -->
<body class="">
<!-- BEGIN HEADER -->
<div class="header navbar navbar-inverse ">
    <!-- BEGIN TOP NAVIGATION BAR -->
    <div class="navbar-inner">
        <div class="header-seperation">
            <ul class="nav pull-left notifcation-center" id="main-menu-toggle-wrapper" style="display:none">
                <li class="dropdown">
                    <a id="main-menu-toggle" href="#main-menu"  class="" >
                        <div class="iconset top-menu-toggle-white"></div>
                    </a>
                </li>
            </ul>
            <!-- BEGIN LOGO -->
            <a href="index.html"><img src="<?php echo get_template_directory_uri() . "/css/backend/img/";?>skyi-logo.png" class="logo" alt=""  data-src="<?php echo get_template_directory_uri() . "/css/backend/img/";?>skyi-logo.png" height="40px" /></a>

            <!-- END LOGO -->
        </div>
        <!-- END RESPONSIVE MENU TOGGLER -->
        <div class="header-quick-nav" >
            <!-- BEGIN TOP NAVIGATION MENU -->
            <div class="pull-left">
            </div>
            <!-- END TOP NAVIGATION MENU -->
            <!-- BEGIN CHAT TOGGLER -->
            <div class="pull-right">
                <div class="chat-toggler">
                    <a href="#" class="dropdown-toggle" id="my-task-list" data-placement="bottom"  data-content='' data-toggle="dropdown" >
                        <div class="user-details">
                            <div class="username">
                                John Smith
                            </div>
                        </div>
                        <div class="iconset top-chat-dark pull-right"></div>
                    </a>
                    <div id="notification-list" style="display:none">
                        <div style="width:200px">
                            <div class="notification-messages success">
                                <div class="message-wrapper">
                                    <div class="heading"> James Richard </div>
                                    <div class="description"> @Admin</div>
                                    <div class="date pull-left"> An hour ago </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <button type="button" class="btn btn-white btn-xs btn-mini" onclick="location.href='dashbord.html';">Dashbord</button>
                            <button type="button" class="btn btn-primary btn-xs btn-mini" onclick="location.href='index.html';">Logout</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END CHAT TOGGLER -->
        </div>
        <!-- END TOP NAVIGATION MENU -->
    </div>
    <!-- END TOP NAVIGATION BAR -->
</div>

<!-- END HEADER -->
<!-- BEGIN CONTAINER -->
<div class="page-container row">
    <!-- BEGIN SIDEBAR -->
    <div class="page-sidebar" id="main-menu">
        <!-- BEGIN MINI-PROFILE -->
        <div class="page-sidebar-wrapper" id="main-menu-wrapper">
            <!-- END MINI-PROFILE -->
            <!-- BEGIN SIDEBAR MENU -->
            <p class="menu-title">BROWSE <span class="pull-right"><a href="javascript:;"><i class="fa fa-refresh"></i></a></span></p>
            <ul>
                <li class="active">
                    <a href="javascript:;"> <span class="title">Home</span> </a>
                </li>
                <li class="active">
                    <a href="javascript:;"> <span class="title">Location</span> </a>
                </li>
                <li class="active">
                    <a href="javascript:;"> <span class="title">iHome Concept</span> </a>
                </li>
                <li class="active">
                    <a href="javascript:;"> <span class="title">Residences</span> </a>
                </li>
                <li class="active">
                    <a href="javascript:;"> <span class="title">Express your Interest</span> </a>
                </li>
                <li class="active">
                    <a href="javascript:;"> <span class="title">eBrochure</span> </a>
                </li>
            </ul>
            <div class="clearfix"></div>
            <!-- END SIDEBAR MENU -->
        </div>
    </div>
    <a href="#" class="scrollup">Scroll</a>
    <div class="footer-widget">
        <div class="pull-right">
            <a href="lockscreen.html"><i class="fa fa-power-off"></i></a>
        </div>
    </div>
    <!-- END SIDEBAR -->

    <!-- BEGIN PAGE CONTAINER-->
    <div class="page-content">
        <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
        <div id="portlet-config" class="modal hide">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button"></button>
                <h3>Widget Settings</h3>
            </div>
            <div class="modal-body"> Widget settings form goes here </div>
        </div>
        <div class="clearfix"></div>
        <div class="content">

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
                                            $buildings = get_buildings();
                                            foreach($buildings as $building){
                                                ?>
                                                <option value="<?php echo $building['id']; ?>" <?php if($unit_building==$building['id']){ echo "selected"; }?>><?php echo  $building['name']?></option>
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
                                            for($i=1;$i<=15;$i++){
                                                ?>
                                                <option value="<?php echo $i;?>" <?php if($floor==$i){ echo "selected"; }?>><?php echo $i;?></option>
                                            <?php
                                            }
                                            ?>
                                        </select>
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

        </div>
        <?php wp_footer(); ?>
</body>
</html>