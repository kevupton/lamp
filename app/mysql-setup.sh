#!/usr/bin/env bash

mysql -uroot -e "create database $DB_DATABASE;"
cd /app
php artisan migrate:refresh --seed