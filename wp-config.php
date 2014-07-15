<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'apartmentselector');

/** MySQL database username */
define('DB_USER', 'root');

/** MySQL database password */
define('DB_PASSWORD', '');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '!hfFV3=k&[-=8D8E.,fBD$oJcx}}CBX{c9?9&Kq )kzTb$M;8yQf.v<3DeNOBC$;');
define('SECURE_AUTH_KEY',  'yut?>eh<OKr56T}}iGNK[_0O]JfEimc1|jaPLDez#p}_x~~7>.jB}(OIyO(=YvDB');
define('LOGGED_IN_KEY',    ' -#$MmQ{F{A!:8YPc|ei0* MdqlMK?*Z`?Dm/XFFvo0y;JYIs_`ghi([d@b>6$ul');
define('NONCE_KEY',        '3O=y9urMDD6+@_;|nCl09DE|cfU#d?gy[1C7%b!Yk{3%whkNQTjZ|%3ms2^JyP|6');
define('AUTH_SALT',        's>z:b@6pfRDN*2N]gAV];<:qt&I^sbz[*o(Jt#8 %pA,2bsh<?-IhR)niPg%XryS');
define('SECURE_AUTH_SALT', 'z>h6|z6T7u1_aUjYS3j&dXUeDNf9<ArMx=Jn+Clfy`__G$D.9:]A5E2JLO f?mUI');
define('LOGGED_IN_SALT',   '/`$T`wQH.@!Y`U-jP/rllxOc/Z;FfPC@gePCGP}N6}E^h* !*|,Lfia~f_%8Y_=K');
define('NONCE_SALT',       'Xz.g~0.L7T`rIdpT^y|+qaeFu]4Q3x7LNl~8S;pc5;rDryz&Kfp9w(O:n <Y*ozb');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

define( 'ENV','production');


/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');




/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
