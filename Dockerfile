FROM mongo:5.0

CMD mongod --port=$PORT --bind_ip_all