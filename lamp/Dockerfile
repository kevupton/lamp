FROM ubuntu:trusty
MAINTAINER Fernando Mayo <fernando@tutum.co>, Feng Honglin <hfeng@tutum.co>

ENV APP_ENV unit_test
ENV APP_DEBUG true
ENV APP_KEY sigLQLxJI6A9aPEGLt9Ms3H6LLbsFZ3j
ENV APP_HTTP_HOST api.mevu.dev

ENV DB_HOST localhost
ENV DB_DATABASE application_api
ENV DB_USERNAME root

ENV CACHE_DRIVER file
ENV SESSION_DRIVER file
ENV QUEUE_DRIVER sync

ENV MAIL_DRIVER smtp
ENV MAIL_HOST mailtrap.io
ENV MAIL_PORT 2525

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt && \
  apt-get -qq -y install curl && \
  curl -sS https://getcomposer.org/installer | php && \
  mv composer.phar /usr/local/bin/composer && \
  echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Add MySQL utils
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
RUN chmod 755 /*.sh

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Configure /app folder with sample app
RUN git clone https://github.com/fermayo/hello-world-lamp.git /app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

#Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M

# Add volumes for MySQL 
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]

#EXPOSE 80 3306
#CMD ["/run.sh"]

# NEW STUF ---------------------------------------------------------

# Make ssh dir
RUN rm -rf /root/.ssh && mkdir /root/.ssh/

# Copy over private key, and set permissions
ADD id_rsa /root/.ssh/id_rsa

# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add bitbuckets key
RUN ssh-keyscan git.mevu.gg >> /root/.ssh/known_hosts

# Clone the conf files into the docker container
RUN rm -rf /app && git clone git@git.mevu.gg:rearch/application-api.git /app

EXPOSE 80 3306
CMD ["/run.sh"]

RUN cd /app && composer install --prefer-dist

RUN export DB_PASSWORD=

RUN cd /app && php artisan migrate:refresh --seed && \
    vendor/bin/phpunit --configuration phpunit.xml

