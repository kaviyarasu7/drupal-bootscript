#!/usr/bin/env bash

echo "Installing Task shell...."
cmd="apt-get install tasksel"
su -c "$cmd"

echo "Installing LAMP stack...."
cmd="apt-get install lamp-server"
su -c "$cmd"

echo "Installing Enable apache2 rewrite...."
cmd="a2enmod rewrite"
su -c "$cmd"

echo "Installing apache restart...."
cmd="service apache2 restart"
su -c "$cmd"

echo "Installing Drush..."
cmd="apt-get install drush"
su -c "$cmd"

echo "Enter folder to of drupal:"
read f_name
echo "Drupal folder name is:$f_name"

echo "Going to /var/www.."
cd /var/www

echo "Installing Drupal..."
cmd="drush dl drupal --drupal-project-rename=$f_name"
su -c "$cmd"

echo "Going into $f_name ..."
cd $f_name

echo "Enter Db user name:"
read db_user
echo "Enter Db user pwd:"
read db_pwd
echo "Enter Db name:"
read db_name
echo "Enter Site user name:"
read site_user
echo "Enter site  pwd:"
read site_pwd


echo "Configuring Drupal..."
cmd="drush site-install standard --db-url=mysql://$db_user:$db_pwd@localhost/$db_name --site-name=$f_name --account-name=$site_user --account-pass=$site_pwd"
su -c "$cmd"

echo "Enable clean URL..."
cmd="drush vset clean_url 0 --yes"
su -c "$cmd"
