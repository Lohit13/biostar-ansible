# The update script which is run when a githook payload is delivered.

# Telling supervisord to stop monitoring biostar
supervisorctl stop all

# Kill the current serving process
waitressid=`ps aux | grep waitress |  awk -F ' ' '{print $2; exit;}'`
kill $waitressid

# Pull the changes
cd `pwd`
git pull

# Telling supervisor to start monitoring biostar again
supervisorctl start all