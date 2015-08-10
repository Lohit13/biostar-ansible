#!/bin/bash

add_update_index_to_crontab () {
    # Write the update index task to crontab

    command="cron-index.sh"
    crontab -l | grep $command
    res=`echo $?`
    # If:
    # res = 0 the command is already in the cron tab
    # res = 1 the command is not in the cron tab
    if [ "$res" -eq 1 ]; then
        echo " * Adding the update index command to the crontab..."
        # Every 10 mins.
        crontab -l | { cat; echo "*/10 * * * * {{ biostar_dir }}/$command"; } | crontab -

    else
        echo " * The update index command is already in the crontab..."
    fi
}

create_database () {
    # Create the database if not already existent

    echo " * Checking if the database already exists (this operation might give an error to be ignored)..."
    psql -h $POSTGRES_PORT_5432_TCP_ADDR -p $POSTGRES_PORT_5432_TCP_PORT -U {{ postgresql_username }} $DATABASE_NAME -c "SELECT id FROM users_user WHERE id=1;"
    res=`echo $?`
    # If:
    # res = 0 the database already exists
    # res != 0 the database does not exist
    if [ "$res" -eq 0 ]; then
        echo " * Database already existent..."
        newdb=1
    else
        echo " * Creating the database (this operation might give an error to be ignored)..."
        createdb -h $POSTGRES_PORT_5432_TCP_ADDR -p $POSTGRES_PORT_5432_TCP_PORT -U {{ postgresql_username }} $DATABASE_NAME
        newdb=0
    fi
}

#Install biostar requirements
sudo pip install -r {{ biostar_dir }}/{{ requirements_dir }}

cd {{ biostar_dir }}

echo " * Setting environment variables..."
source conf/production.env

# Create the database if not already existent
create_database

echo " * Initializing the database..."
./biostar.sh init

# Add the update index command to the crontab
add_update_index_to_crontab

echo " * Running waitress"
./biostar.sh waitress