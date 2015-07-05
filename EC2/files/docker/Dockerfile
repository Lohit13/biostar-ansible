###############################################################################################
# Docker file to build container for Biostar

FROM phusion/baseimage:latest

# Add biostar codebase.
ADD {{ rel_dir }} {{ biostar_dir }}

# Install python, pip, git, postgresql client.
RUN apt-get update
RUN apt-get install -y python python-pip git postgresql-client-9.3 python-psycopg2 supervisor
RUN service supervisor restart

# Create a password file for PostgreSQL (for users root and www-data).
RUN echo "*:*:*:{{ postgresql_username }}:{{ postgresql_password }}" > /root/.pgpass
RUN chmod 0600 /root/.pgpass
RUN mkdir /var/www
RUN echo "*:*:*:{{ postgresql_username }}:{{ postgresql_password }}" > /var/www/.pgpass
RUN chown -R www-data:www-data /var/www
RUN chmod 0600 /var/www/.pgpass

#Install biostar requirements
RUN pip install -r {{ biostar_dir }}/{{ requirements_dir }}

RUN mkdir /etc/service/biostar
RUN ln -s {{ biostar_dir }}/run-biostar.sh /etc/service/biostar/run

## END CUSTOMIZATION
##################################################################################################
