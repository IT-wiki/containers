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

# Create a init bot user
BOT_PWD=$(cat /dev/urandom | tr -dc '[:alnum:]' | fold -w ${1:-32} | head -n 1)
cd /opt/bitnami/mediawiki
php maintenance/createBotPassword.php ${MEDIAWIKI_USERNAME^} $BOT_PWD --appid initbot --grants basic,createeditmovepage,delete,uploadeditmovefile,editsiteconfig
