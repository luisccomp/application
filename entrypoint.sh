#!/bin/sh

# This file executes on production server only...
python manage.py migrate --no-input
python manage.py collectstatic --no-input

python -m gunicorn application.wsgi:application -b 0:8000 -w 4
