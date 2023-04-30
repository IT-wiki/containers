#!/bin/bash
 
# shellcheck disable=SC1090,SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load MediaWiki environment
. /opt/bitnami/scripts/mediawiki-env.sh

# Load library with 'info' function
. /opt/bitnami/scripts/liblog.sh

info "** Setting up IT-wiki **"
cat /opt/mabadiliko/it-wiki/LocalSettings.txt >> "$MEDIAWIKI_CONF_FILE"

# cat >>"$MEDIAWIKI_CONF_FILE" <<EOF
# wfLoadExtension( 'VisualEditor' );
# wfLoadExtension( 'WikiEditor' );
# EOF
