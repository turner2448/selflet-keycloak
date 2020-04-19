#!/bin/bash
cd /opt/jboss/keycloak/bin
echo "logging in"
./kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password password
echo "creating selflet"
./kcadm.sh create realms -s realm=selflet -s enabled=true -o
echo "creating client"
./kcadm.sh create clients -r selflet -s clientId=selflet-client -s enabled=true -s publicClient=true -s clientAuthenticatorType=client-secret -s secret=d0b8122f-8dfb-46b7-b68a-f5cc4e25d000 -s "redirectUris=[\"http://localhost:3000/*\"]" -s baseUrl=http://localhost:3000 -s adminUrl=http://localhost:3000
echo "creating user"
user1=$(./kcadm.sh create users -r selflet -s username=admin@admin.com -s enabled=true -s "attributes.agencyId=1" -s "attributes.agency=true" -s "attributes.tenant=false" -s "attributes.landlord=false") #'requiredActions=["UPDATE_PASSWORD"]'
./kcadm.sh set-password -r selflet --username admin@admin.com --new-password password --temporary
user=$(./kcadm.sh get users -r selflet)
echo $user | jq '.[] | select(.username == "admin@admin.com") | .id'


echo "Creating Group Admin group"
./kcadm.sh create groups -r selflet -s name=Agency_Admin
json=$(./kcadm.sh get groups -r selflet)
echo $json | jq '.[] | select(.name == "Agency_Admin") | .id'

echo "Adding admin@admin.com user to group Agency_Admin"
addString=users/$(echo $user | jq '.[] | select(.username == "admin@admin.com") | .id' | tr -d '"')/groups/$(echo $json | jq '.[] | select(.name == "Agency_Admin") | .id' | tr -d '"')
echo $addString
./kcadm.sh update $addString -r selflet -s realm=selflet -s userId=$(echo $user | jq '.[] | select(.username == "admin@admin.com") | .id') -s groupId=$(echo $json | jq '.[] | select(.name == "Agency_Admin") | .id') -n
