#!/bin/bash

cd {{ biostar_dir }}
source conf/production.env
exec python manage.py update_index
