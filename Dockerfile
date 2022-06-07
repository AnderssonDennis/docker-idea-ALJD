FROM nginx

### Start Nginx
#   1) delete the real Nginx root folder /usr/share/nginx/html
#   2) make a symbolic link /usr/share/nginx/html pointing to our work dir
#   3) replace port 80 (the default nginx port)
#      with our port in the config file
#   4) start Nginx

CMD rm -r /usr/share/nginx/html \
  && ln -s $(pwd) /usr/share/nginx/html \
  && sed -i "s/80/$PORT/" /etc/nginx/conf.d/default.conf \
  && nginx -g "daemon off;"