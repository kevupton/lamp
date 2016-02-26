# Make ssh dir
RUN mkdir /root/.ssh/

# Copy over private key, and set permissions
ADD id_rsa /root/.ssh/id_rsa

# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add bitbuckets key
RUN ssh-keyscan git.mevu.gg >> /root/.ssh/known_hosts

# Clone the conf files into the docker container
RUN rm -rf /app && git clone git@git.mevu.gg:rearch/application-api.git /app