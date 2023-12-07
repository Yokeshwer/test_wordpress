#!/bin/bash
set -e

# Start Nginx in the background
#service nginx start

# Start PHP-FPM in the background
service php8.1-fpm start

# Execute the default WordPress entrypoint
exec "$@"



