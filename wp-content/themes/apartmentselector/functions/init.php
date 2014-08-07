<?php


//load the custom-post-types
require_once (get_template_directory().'/functions/custom-post-types.php');

//create custom tables
require_once (get_template_directory().'/functions/custom-tables.php');



/*
function to register custom post types
*/

function register_custom_post_types(){

	register_post_type_unit();
}


function do_init_routines(){

	define('CUSTOMTBLPREFIX','sp_');

	register_custom_post_types();

	create_custom_tables();

	add_default_room_types();

	add_default_room_type_for_sizes();

    add_default_facings();

    add_default_unit_status();

    add_default_views();

    add_default_phases();

    add_default_flats_and_floors();

}
add_action('init','do_init_routines');

//change wp-login logo and text


function my_login_logo() { ?>
    <style type="text/css">
        body.login div#login h1 a {
            background-image: url(<?php echo get_stylesheet_directory_uri(); ?>/images/skyi-logoS-1.png);
            padding-bottom: 30px;
			margin-bottom: 15px;
			background-size: 67px 100px;
        }
    </style>
<?php }
add_action( 'login_enqueue_scripts', 'my_login_logo' );

function my_login_logo_url() {
    return home_url();
}
add_filter( 'login_headerurl', 'my_login_logo_url' );

function my_login_logo_url_title() {
    return 'SKYI Apartmentselector';
}
add_filter( 'login_headertitle', 'my_login_logo_url_title' );


function my_login_redirect($redirect_to, $request, $user ) { 

$current_user = wp_get_current_user(); 
	if( $user->allcaps['manage_apartments']==1)
		{
			$redirect_to = site_url() . '/apartments';
		}
    

    return $redirect_to;
}

add_filter( 'login_redirect', 'my_login_redirect',10,3 );

function manage_roles()
{
	global $wp_roles;

    if ( ! isset( $wp_roles ) )
        $wp_roles = new WP_Roles(); 

	$custom_update_roles = "1";

	if(get_option('custom_update_roles') < $custom_update_roles || get_option('custom_update_roles')=="" ){

		update_option('custom_update_roles',$custom_update_roles);

 		$custom_roles_update = array(array('role'=>'Project Master','clone_role'=>'editor','capabilities'=>array('manage_apartments','manage_buildings','manage_settings','manage_project_master'))
									,array('role'=>'ERP Team','clone_role'=>'editor','capabilities'=>array('manage_apartments','manage_buildings')));

		$existing_custom_roles = maybe_unserialize(get_option('custom_roles'));
		
		$existing_custom_roles =  is_array($existing_custom_roles)?$existing_custom_roles:array();
		 

		foreach($custom_roles_update as $custom_role){

			$role_slug = strtolower(str_replace(" ", "_", $custom_role['role']));
		 
			if(!in_array($custom_role['role'], $existing_custom_roles)   ){
				
				$adm = $wp_roles->get_role($custom_role['clone_role']);
				
				$wp_roles->add_role($role_slug, $custom_role['role'], $adm->capabilities);
    			
    			$existing_custom_roles[] = $custom_role['role'];
			}

			foreach($custom_role['capabilities'] as $capability){

				$role_check = get_role($role_slug);

				if( ! $role_check->has_cap($capability))
				{
					$role_check->add_cap($capability);
				}
			}
		}
		update_option('custom_roles',$existing_custom_roles);
	}
 
}

 add_filter( 'init', 'manage_roles' );


