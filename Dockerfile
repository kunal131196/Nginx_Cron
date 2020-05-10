FROM nginx:latest
#COPY /etc/logrotat.d/nginx /etc/logrotate.d
RUN apt-get update -y && apt-get install logrotate cron -y
COPY nginx /etc/logrotate.d/nginx
COPY logrotate.sh /opt/
RUN chmod 0744 /opt/logrotate.sh
COPY crontab /etc/cron.d/logrotate_nginx
RUN chmod 0644 /etc/cron.d/logrotate_nginx
RUN /usr/bin/crontab /etc/cron.d/logrotate_nginx
#CMD ["nginx", "-g", "daemon off;"]
CMD ["/bin/bash", "-c", "/usr/sbin/service cron start && nginx -g 'daemon off;'"]
