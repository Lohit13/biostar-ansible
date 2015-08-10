###############################################################################################
# Docker file to build container for Biostar

FROM phusion/baseimage:latest

# Set correct environment variables.
ENV HOME /root

# Install python, pip, git, postgresql client.
RUN apt-get update
RUN apt-get install -y python python-pip git postgresql-client-9.3 python-psycopg2 supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create a password file for PostgreSQL (for users root and www-data).
RUN echo "*:*:*:{{ postgresql_username }}:{{ postgresql_password }}" > /root/.pgpass
RUN chmod 0600 /root/.pgpass
RUN mkdir /var/www
RUN echo "*:*:*:{{ postgresql_username }}:{{ postgresql_password }}" > /var/www/.pgpass
RUN chown -R www-data:www-data /var/www
RUN chmod 0600 /var/www/.pgpass

#RUN mkdir /etc/service/biostar
#RUN ln -s {{ biostar_dir }}/run-biostar.sh /etc/service/biostar/run

#CMD {{ biostar_dir }}/run-biostar.sh

CMD ["/usr/bin/supervisord"]

## END CUSTOMIZATION
##################################################################################################