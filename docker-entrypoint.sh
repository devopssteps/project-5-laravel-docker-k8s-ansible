#!/bin/sh

# echo "⏳ Waiting for MySQL to be ready..."
# until nc -z -v -w30 $DB_HOST $DB_PORT
# do
#   echo "❗ Still waiting for MySQL..."
#   sleep 5
# done

# echo "✅ MySQL is ready. Running migrations..."
# php artisan migrate --force

# echo "🚀 Starting PHP-FPM..."
# exec php-fpm


#!/bin/bash

# Wait for MySQL to be ready
until nc -z db 3306; do
  echo "⏳ Waiting for MySQL to be ready..."
  sleep 2
done

echo "✅ MySQL is up. Starting php-fpm..."
exec php-fpm
