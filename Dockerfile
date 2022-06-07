FROM nginx

WORKDIR ./iframer

CMD rm -r /usr/share/nginx/html \
  && ln -s $(pwd) /usr/share/nginx/html \
  && sed -i "s/80/$PORT/" /etc/nginx/conf.d/default.conf \
  && nginx -g "daemon off;"