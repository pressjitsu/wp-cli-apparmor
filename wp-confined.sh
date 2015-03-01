#!/bin/bash
# A save invocation of the WP-CLI binary
# Does confinement profile generation and invokes WP-CLI with the needed arguments
# All generated and added profiles can be reused with `aa-exec -p`
#
# GPLv3 (http://www.gnu.org/licenses/gpl-3.0.txt)
# Copyright 2015 (c) Pressjitsu
# 

set -x

# Runtime configuration
PROFILE_NAME=${PROFILE_NAME:-"default"}
WP_CLI=${WP_CLI:-"/usr/local/bin/wp"}
PHP_BIN=${PHP_BIN:-php}
WP_PATH=${WP_PATH:-"/var/www/"}
AS_USER=${AS_USER:-"nobody"}

# Resolve PHP binary and WP-CLI script full paths
PHP_BIN=$( (test -f $PHP_BIN && echo -n $PHP_BIN) || which $PHP_BIN )
PHP_BIN=$(readlink -f $PHP_BIN)
WP_CLI=$( (test -f $WP_CLI && echo -n $WP_CLI) || which $WP_CLI )
WP_CLI=$(readlink -f $WP_CLI)

# Generate profile and execute
aa-exec -f <(sed \
	\
	-e "s#%profile_name%#$PROFILE_NAME#g"	\
	-e "s#%php_bin%#$PHP_BIN#g"				\
	-e "s#%wp_cli%#$WP_CLI#g"				\
	-e "s#%wp_path%#$WP_PATH#g"				\
	\
	wp-cli-apparmor.ppt) -p wp-cli/$PROFILE_NAME -- sudo -u $AS_USER $PHP_BIN $WP_CLI --path=$WP_PATH $@
