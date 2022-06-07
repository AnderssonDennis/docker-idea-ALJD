FROM mongo:5.0
# Med mongod (mongo-demonen använde för att starta mongoDB
# du kan ange port, men måste också ange en bind_ip
# (serverns externa ip) ELLER binda alla ip-nummer.
# Eftersom vi inte vet vilket ip-nummer Docker tilldelar
# behållare i Dockers interna nätverk vi använder -bind_ip_all
CMD mongod --port=$PORT --bind_ip_all