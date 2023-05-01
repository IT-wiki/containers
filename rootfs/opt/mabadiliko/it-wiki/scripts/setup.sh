#!/bin/bash
 
# shellcheck disable=SC1090,SC1091

set -o errexit
set -o nounset
# set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load MediaWiki environment
. /opt/bitnami/scripts/mediawiki-env.sh

# Load library with logging functions
. /opt/bitnami/scripts/liblog.sh

# Configure extensions
/opt/mabadiliko/it-wiki/scripts/configure_extensions.sh
/opt/mabadiliko/it-wiki/scripts/create_bot.sh
