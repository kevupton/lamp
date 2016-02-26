FROM tutum/lamp:latest

ENV APP_ENV unit_test
ENV APP_DEBUG true
ENV APP_KEY sigLQLxJI6A9aPEGLt9Ms3H6LLbsFZ3j
ENV APP_HTTP_HOST api.mevu.dev

ENV DB_HOST localhost
ENV DB_DATABASE application_api
ENV DB_USERNAME root

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

RUN cd /app && php artisan migrate:refresh --seed && \
    vendor/bin/phpunit --configuration phpunit.xml
