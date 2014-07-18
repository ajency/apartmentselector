
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
    <?php
    require_once( get_template_directory().'/functions/backend-menu.php')
    ?>
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

           <?php
            get_template_part( 'backend-content-templates/'.get_template_filename() ); ?>

        </div>
        <?php wp_footer(); ?>
</body>
</html>