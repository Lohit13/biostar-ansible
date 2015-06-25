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

cd {{ virtualenv_dir }}

source bin/activate

cd {{ biostar_dir }}

echo " * Setting environment variables..."
source conf/production.env

echo " * Initializing the database..."
./biostar.sh init

# Add the update index command to the crontab
add_update_index_to_crontab

echo " * Running waitress"
./biostar.sh waitress
