<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'tnolent' );

/** Database password */
define( 'DB_PASSWORD', 'pasword' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          'KIOWwp/rTGW*dOHj*t2&7byZm-O&QM5pxYI0wf hE{ozL9CHBY0HC[C)irlsx |G' );
define( 'SECURE_AUTH_KEY',   'Sk2}?;kP81_BXxlQO;+jd1Tjao1roO]((c];]-`VPRPewy`5!Urb^rA@f2KK$F[a' );
define( 'LOGGED_IN_KEY',     'GzH6v]WHE#-Lgfb(E->t/kL8PON<#)GHT1=mSW1M.#*H@k`rn.JlywQa>I*!XIL)' );
define( 'NONCE_KEY',         'i0xw(}Q#`etu^Ox+Rq2bz.<.^=[cBl)I}V~Y=SqO% soKzOZ6/F#!43jX*q(.USK' );
define( 'AUTH_SALT',         ',D^n^mp[/]uNF>tjL5qC6QQ(Nw)}wm(CHkdpcj]Vv3pjvURzrmnNE%Lnep33js+B' );
define( 'SECURE_AUTH_SALT',  'NcRJ|NZNXhOoT>U-M|5|+UMGe=<&6x@X~%aGTGDH)Ln3!e^MVUr:t,JOrTJGfYAj' );
define( 'LOGGED_IN_SALT',    'Tb2vD=f/oy^L$9N(kqFe@)<e#-oY_+((]Eq>F2!`S8X;.z6EO-o?(@+@TE2xec($' );
define( 'NONCE_SALT',        ';IJRv*nTLH1Dx)-sb0aOuDJL=Wb1#rQ&R8z%,GuyVwHC?ygocpXhtQ1h+itRezX*' );
define( 'WP_CACHE_KEY_SALT', 'w6;H-f$V)mj802[-iQF%NscDyv&B/g?tjImy^]OqKG_>x.e^l k*o9qE.Muy7BxN' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
