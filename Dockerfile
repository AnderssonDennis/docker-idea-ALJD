FROM nginx:alpine
# Set working directory to nginx asset directory
WORKDIR /iframer/
# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]