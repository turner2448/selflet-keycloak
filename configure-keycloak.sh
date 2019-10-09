#!/bin/bash
cd /opt/jboss/keycloak/bin
echo "logging in"
./kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password password
echo "creating selflet"
./kcadm.sh create realms -s realm=selflet100 -s enabled=true -o
