export NSX_MANAGER=192.168.110.42
export NSX_USER=admin
export NSX_PASSWORD=VMware1!
curl -k -X DELETE "https://${NSX_MANAGER}/api/v1/trust-management/principal-identities/$1" -H "X-Allow-Overwrite: true" -u "$NSX_USER:$NSX_PASSWORD"
