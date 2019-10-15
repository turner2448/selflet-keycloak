FROM jboss/keycloak
ENV DB_USER=keycloak
ENV DB_PASSWORD=password
#ENV KEYCLOAK_USER=admin
#ENV KEYCLOAK_PASSWORD=password
#ADD configure-keycloak.sh /tmp/configure-keycloak.sh
#RUN ["/tmp/configure-keycloak.sh"]
EXPOSE 8080
