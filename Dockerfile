FROM chapeter/alpine
MAINTAINER Chad Peterson, chapeter@cisco.com

WORKDIR /home
RUN git clone http://github.com/chapeter/sparkdaily
WORKDIR sparkdaily

RUN pip install -r requirements.txt

RUN echo '0 5 * * * /usr/bin/python /home/sparkdaily/sparkdaily.py >> /var/log/cron.log 2>&1' > crontab
RUN chmod 0644 crontab
RUN cp crontab /etc/crontabs/root
RUN touch /var/log/cron.log

EXPOSE 80

CMD crond && tail -f /var/log/cron.log
