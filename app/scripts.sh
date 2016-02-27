#!/usr/bin/env bash

cd /app
php artisan migrate:refresh --seed
vendor/bin/phpunit --configuration phpunit.xml