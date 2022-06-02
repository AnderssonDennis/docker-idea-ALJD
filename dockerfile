FROM mysql:debian
ENV MYSQL_TCP_PORT=4002
CMD tail -f /dev/null