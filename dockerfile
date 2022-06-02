FROM php:apache-bullseye
# Start Apache correctly
CMD rm -r /var/www/html \
    && ln -s $(pwd) /var/www/html \
    && sed -i "s/80/$PORT/" /etc/apache2/sites-enabled/000-default.conf \
    && sed -i "s/80/$PORT/" /etc/apache2/ports.conf \
    && apache2-foreground

<<<<<<< HEAD
    
=======
FROM mysql:debian
ENV MYSQL_TCP_PORT=4002
CMD tail -f /dev/null
>>>>>>> 12ff690e9b627d24f20073c4a0bd4bfbd1333158
