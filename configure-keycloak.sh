#!/bin/bash
cd /opt/jboss/keycloak/bin
echo "logging in"
./kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password password
echo "creating selflet"
./kcadm.sh create realms -s realm=selflet -s enabled=true -o
echo "creating client"
./kcadm.sh create clients -r selflet -s clientId=selflet-client -s enabled=true -s publicClient=true -s clientAuthenticatorType=client-secret -s secret=d0b8122f-8dfb-46b7-b68a-f5cc4e25d000 -s "redirectUris=[\"http://localhost:3000/*\"]" -s baseUrl=http://localhost:3000 -s adminUrl=http://localhost:3000
echo "creating user"
./kcadm.sh create users -r selflet -s username=test -s enabled=true  #'requiredActions=["UPDATE_PASSWORD"]'
./kcadm.sh set-password -r selflet --username test --new-password password --temporary
echo "Creating Group Admin group"
./kcadm.sh create groups -r selflet -s name=Agency_Admin
json=$(./kcadm.sh get groups -r selflet)
echo $json

