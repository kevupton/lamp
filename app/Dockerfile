FROM tutum/lamp:latest

ENV APP_DEBUG true
ENV APP_KEY sigLQLxJI6A9aPEGLt9Ms3H6LLbsFZ3j

ADD mysql-setup.sh /mysql-setup.sh
RUN chmod 755 /mysql-setup.sh

# Make ssh dir
RUN rm -rf /root/.ssh && mkdir /root/.ssh/
RUN apt-get install nodejs -yqq && apt-get install npm -yqq

# Copy over private key, and set permissions
ADD id_rsa /root/.ssh/id_rsa

# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add bitbuckets key
RUN ssh-keyscan git.mevu.gg >> /root/.ssh/known_hosts

# Clone the conf files into the docker container
RUN rm -rf /mevuio && git clone git@git.mevu.gg:general/mevu-io.git /mevuio
RUN cd /mevuio && npm install; exit 0
RUN rm -fr /var/www/html && ln -s /mevuio/src/main/html /var/www/html

EXPOSE 80 3306
CMD ["/run.sh"]

ENV DB_HOST localhost
ENV DB_DATABASE application_api
ENV DB_USERNAME root
ENV DB_PASSWORD=

ENV CACHE_DRIVER file
ENV SESSION_DRIVER file
ENV QUEUE_DRIVER sync

ENV MAIL_DRIVER smtp
ENV MAIL_HOST mailtrap.io
ENV MAIL_PORT 2525

ADD scripts.sh /pull
RUN chmod 755 /pull


