###############################################################################################
# Docker file to build container for Biostar

FROM ubuntu

# Add biostar codebase.
RUN mkdir {{ base_dir }}
ADD biostar {{ biostar_dir }}

# Install python, pip, git, postgresql client.
RUN apt-get update
RUN apt-get install -y python python-pip git postgresql-client-9.3 python-psycopg2 nginx

# Create a password file for PostgreSQL (for users root and www-data).
RUN echo "*:*:*:{{ postgresql_username }}:{{ postgresql_password }}" > /root/.pgpass
RUN chmod 0600 /root/.pgpass
RUN mkdir /var/www
RUN echo "*:*:*:{{ postgresql_username }}:{{ postgresql_password }}" > /var/www/.pgpass
RUN chown -R www-data:www-data /var/www
RUN chmod 0600 /var/www/.pgpass

## END CUSTOMIZATION
##################################################################################################


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*