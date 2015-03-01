# WP-CLI AppArmor Profile

Keeping WP-CLI (http://wp-cli.org/) safe no matter how you use it. There are several attack vectors with automated WP-CLI execution in shared environments which can be avoided by confining it using AppArmor (http://wiki.apparmor.net/index.php/Main_Page).

## Running

Running `wp-confined.sh` must be done with root privileges in order to confine it with the generated profile.

The following environent variables need to be set:

	- `PROFILE_NAME` - ('default') the name of the AppArmor profile. Since AppArmor caches profiles you can give different sites a different name.
	- `WP_CLI` - ('/usr/local/bin/wp') the path to the `wp` script, can be relative.
	- `PHP_BIN` - ('php') the PHP binary.
	- `WP_PATH` - ('/var/www/') the path to the WordPress directory to work on.
	- `AS_USER` - ('nobody') the user to run the script with.

Example:

`sudo AS_USER=dave WP_PATH=/home/dave/www/ ./wp-confined.sh core download`

## Notes

`wp core download` does no have permissions to create the `WP_PATH` directory, create the directory manually.

## License

GPLv3 (http://www.gnu.org/licenses/gpl-3.0.txt)
Copyright 2015 (c) Pressjitsu
