#!/usr/bin/env bash

if [ -f /mysql-setup.sh ] ; then
  mysql -uroot -e "create database $DB_DATABASE;"
fi