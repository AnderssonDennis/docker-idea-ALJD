FROM bitnami/mysql:5.7.38
# Tillåt tomt lösenord
# enklare anslutningsinställningar under utveckling
ENV ALLOW_EMPTY_PASSWORD=yes

# Ställ in porten för att starta MySQL-servern på
ENV MYSQL_PORT_NUMBER=$PORT