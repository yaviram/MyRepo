#!/bin/bash
#create_pi.sh

NSX_MANAGER="192.168.110.42"
NSX_USER="admin"
CERTIFICATE_ID='c295a16c-242a-45e1-9063-cf2cd6fda9a7'

PI_NAME="pks-nsx-t-superuser"
NSX_SUPERUSER_CERT_FILE="pks-nsx-t-superuser.crt"
NSX_SUPERUSER_KEY_FILE="pks-nsx-t-superuser.key"
NODE_ID=$(cat /proc/sys/kernel/random/uuid)

stty -echo
printf "Password: "
read NSX_PASSWORD
stty echo

pi_request=$(cat <<END
    {
         "display_name": "$PI_NAME",
         "name": "$PI_NAME",
         "permission_group": "superusers",
         "certificate_id": "$CERTIFICATE_ID",
         "node_id": "$NODE_ID"
    }
END
)

curl -k -X POST \
    "https://${NSX_MANAGER}/api/v1/trust-management/principal-identities" \
    -u "$NSX_USER:$NSX_PASSWORD" \
    -H 'content-type: application/json' \
    -d "$pi_request"

curl -k -X GET \
    "https://${NSX_MANAGER}/api/v1/trust-management/principal-identities" \
    --cert $(pwd)/"$NSX_SUPERUSER_CERT_FILE" \
    --key $(pwd)/"$NSX_SUPERUSER_KEY_FILE"
