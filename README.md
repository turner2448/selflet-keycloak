Builds and configures a Keycloak instance.

To build:-
docker build .

To run:-
sudo docker run --name keycloak -v $(pwd):/tmp --net keycloak-network -e DB_USER=keycloak -e DB_PASSWORD=password -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=password -p 8080:8080 jboss/keycloak 

Note
The batch script will create a new Selflet realm, however as config is stored in the database it may already exist.
