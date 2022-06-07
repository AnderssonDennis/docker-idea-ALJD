FROM nginx

# Ersätt den ursprungliga config.filen
# med vår egen (som innehåller den omvända proxykoden)
COPY nginx.conf /etc/nginx/nginx.conf